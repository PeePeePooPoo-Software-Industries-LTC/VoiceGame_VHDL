library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.math_real.all;

entity Main is
	port (
		audio_interface_ADCDAT  : in    std_logic                     := '0';             -- audio_interface.ADCDAT
		audio_interface_ADCLRCK : in    std_logic                     := '0';             --                .ADCLRCK
		audio_interface_BCLK    : in    std_logic                     := '0';             --                .BCLK
		clk_clk                 : in    std_logic                     := '0';             --             clk.clk
		reset_reset             : in    std_logic                     := '0';             --           reset.reset
		sram_DQ                 : inout std_logic_vector(15 downto 0) := (others => '0'); --            sram.DQ
		sram_ADDR               : out   std_logic_vector(19 downto 0);                    --                .ADDR
		sram_LB_N               : out   std_logic;                                        --                .LB_N
		sram_UB_N               : out   std_logic;                                        --                .UB_N
		sram_CE_N               : out   std_logic;                                        --                .CE_N
		sram_OE_N               : out   std_logic;                                        --                .OE_N
		sram_WE_N               : out   std_logic;                                        --                .WE_N
		
		VGA_R : out std_logic_vector(7 downto 0);
		VGA_G : out std_logic_vector(7 downto 0);
		VGA_B : out std_logic_vector(7 downto 0);
		VGA_CLK : out std_logic;
		VGA_HS : out std_logic;
		VGA_VS : out std_logic;
		VGA_BLANK : out std_logic;
		VGA_SYNC : out std_logic;
		
		SW : in std_logic_vector(17 downto 0);
		LEDR : out std_logic_vector(17 downto 0);
		LEDG : out std_logic_vector(7 downto 0)
	);
end entity Main;

architecture rtl of Main is
	component NIOSII_Test is
		port (
			audio_interface_ADCDAT  : in    std_logic                     := '0';             -- audio_interface.ADCDAT
			audio_interface_ADCLRCK : in    std_logic                     := '0';             --                .ADCLRCK
			audio_interface_BCLK    : in    std_logic                     := '0';             --                .BCLK
			clk_clk                 : in    std_logic                     := '0';             --             clk.clk
			reset_reset_n             : in    std_logic                     := '0';             --           reset.reset
			sram_DQ                 : inout std_logic_vector(15 downto 0) := (others => '0'); --            sram.DQ
			sram_ADDR               : out   std_logic_vector(19 downto 0);                    --                .ADDR
			sram_LB_N               : out   std_logic;                                        --                .LB_N
			sram_UB_N               : out   std_logic;                                        --                .UB_N
			sram_CE_N               : out   std_logic;                                        --                .CE_N
			sram_OE_N               : out   std_logic;                                        --                .OE_N
			sram_WE_N               : out   std_logic;  
			buttons_export          : in    std_logic_vector(31 downto 0);
			vga_CLK                                       : out   std_logic;                                        --                                    vga.CLK
			vga_HS                                        : out   std_logic;                                        --                                       .HS
			vga_VS                                        : out   std_logic;                                        --                                       .VS
			vga_BLANK                                     : out   std_logic;                                        --                                       .BLANK
			vga_SYNC                                      : out   std_logic;                                        --                                       .SYNC
			vga_R                                         : out   std_logic_vector(7 downto 0);                     --                                       .R
			vga_G                                         : out   std_logic_vector(7 downto 0);                     --                                       .G
			vga_B                                         : out   std_logic_vector(7 downto 0)                      --                                       .B

		);
	end component NIOSII_Test;
		
	component vga_controller is
		generic(
			h_pulse 	:	INTEGER;    	--horiztonal sync pulse width in pixels
			h_bp	 	:	INTEGER;		--horiztonal back porch width in pixels
			h_pixels	:	INTEGER;		--horiztonal display width in pixels
			h_fp	 	:	INTEGER;		--horiztonal front porch width in pixels
			h_pol		:	STD_LOGIC;		--horizontal sync pulse polarity (1 = positive, 0 = negative)
			v_pulse 	:	INTEGER;			--vertical sync pulse width in rows
			v_bp	 	:	INTEGER;			--vertical back porch width in rows
			v_pixels	:	INTEGER;		--vertical display width in rows
			v_fp	 	:	INTEGER;			--vertical front porch width in rows
			v_pol		:	STD_LOGIC	--vertical sync pulse polarity (1 = positive, 0 = negative)
		);
		port(
			pixel_clk	:	IN		STD_LOGIC;	--pixel clock at frequency of VGA mode being used
			reset_n		:	IN		STD_LOGIC;	--active low asycnchronous reset
			h_sync		:	OUT	STD_LOGIC;	--horiztonal sync pulse
			v_sync		:	OUT	STD_LOGIC;	--vertical sync pulse
			disp_ena		:	OUT	STD_LOGIC;	--display enable ('1' = display time, '0' = blanking time)
			column		:	OUT	INTEGER;		--horizontal pixel coordinate
			row			:	OUT	INTEGER;		--vertical pixel coordinate
			n_blank		:	OUT	STD_LOGIC;	--direct blacking output to DAC
			n_sync		:	OUT	STD_LOGIC --sync-on-green output to DAC
		);
	end component vga_controller;
	
	component video_pll is
		port(
			inclk0 : IN STD_LOGIC  := '0';
			c0		 : OUT STD_LOGIC 
		);
	end component video_pll;
	
--	signal vga_pixel_clock : std_logic;
--	signal vga_is_on_screen : std_logic;
--	signal vga_current_x : integer;
--	signal vga_current_y : integer;
	
	type LineBuffer is array (639 downto 0) of std_logic_vector(23 downto 0);
	signal line_buffer : LineBuffer;
	
	signal pio_pixel_color : std_logic_vector(23 downto 0);
	signal pio_pixel_position : std_logic_vector(31 downto 0);
	signal buttons_sig : std_logic_vector(31 downto 0);
	signal pio_request : std_logic;
begin
--	pio_pixel_position <= "00000000000000100000000000000001";
	LEDR(7 downto 0) <= pio_pixel_color(7 downto 0);
	
	pio_request <= SW(0);
	LEDR(17) <= pio_request;
	buttons_sig(3 downto 0) <= SW(4 downto 1);

	nios2_core : NIOSII_Test port map(
			audio_interface_ADCDAT  => audio_interface_ADCDAT,
			audio_interface_ADCLRCK => audio_interface_ADCLRCK,
			audio_interface_BCLK    => audio_interface_BCLK,
			clk_clk                 => clk_clk,
			reset_reset_n           => reset_reset,

			sram_DQ                 => sram_DQ,
			sram_ADDR               => sram_ADDR,
			sram_LB_N               => sram_LB_N,
			sram_UB_N               => sram_UB_N,
			sram_CE_N               => sram_CE_N,
			sram_OE_N               => sram_OE_N,
			sram_WE_N               => sram_WE_N,
			
			buttons_export => buttons_sig,

			vga_CLK => vga_CLK,
			vga_HS => vga_HS,
			vga_VS => vga_VS,
			vga_BLANK => vga_BLANK,
			vga_SYNC => vga_SYNC,
			vga_R => vga_R,
			vga_G => vga_G,
			vga_B => vga_B
	);
	
--	vga : vga_controller generic map(
--		h_pulse 	=> 96,    	--horiztonal sync pulse width in pixels
--		h_bp	 	=> 48, 	--horiztonal back porch width in pixels
--		h_pixels	=> 640,		--horiztonal display width in pixels
--		h_fp	 	=> 16,		--horiztonal front porch width in pixels
--		h_pol		=> '0',		--horizontal sync pulse polarity (1 = positive, 0 = negative)
--		v_pulse 	=> 3,			--vertical sync pulse width in rows
--		v_bp	 	=> 28,			--vertical back porch width in rows
--		v_pixels	=> 480,		--vertical display width in rows
--		v_fp	 	=> 9,			--vertical front porch width in rows
--		v_pol		=> '0'	--vertical sync pulse polarity (1 = positive, 0 = negative)
--	)	port map(
--		pixel_clk	=> vga_pixel_clock,
--		reset_n		=> reset_reset,
--		h_sync		=> VGA_HS,
--		v_sync		=> VGA_VS,
--		disp_ena		=> vga_is_on_screen,
--		column		=> vga_current_x,
--		row			=> vga_current_y,
--		n_blank		=> VGA_BLANK,
--		n_sync		=> VGA_SYNC
--	);
	
--	video_pll_component : video_pll port map(
--		inclk0 => clk_clk,
--		c0 => vga_pixel_clock
--	);	
	
--	process(vga_is_on_screen, vga_current_x, vga_current_y)
--		variable first : std_logic := '0';
--		variable color : std_logic_vector(23 downto 0) := (others => '0');
--	begin
--		if (vga_is_on_screen = '1') then
--			if (vga_current_x rem 64 = 0) then
--				pio_pixel_position <= std_logic_vector(
--					to_unsigned(vga_current_x, 16)
--				) & std_logic_vector(
--					to_unsigned(vga_current_y, 16)
--				);
--			end if;
--			color := pio_pixel_color;
--			
--			VGA_R <= color(23 downto 16);
--			VGA_G <= color(15 downto 8);
--			VGA_B <= color(7 downto 0);
--		else
--			VGA_R <= (others => '0');
--			VGA_G <= (others => '0');
--			VGA_B <= (others => '0');
--		end if;
--	end process;
	
--	VGA_CLK <= vga_pixel_clock;
end architecture rtl;
