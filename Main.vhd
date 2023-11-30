
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Main is
	port (
		audio_interface_ADCDAT  : in    std_logic                     := '0';             -- audio_interface.ADCDAT
		audio_interface_ADCLRCK : in    std_logic                     := '0';             --                .ADCLRCK
		audio_interface_BCLK    : in    std_logic                     := '0';             --                .BCLK
		clk_clk                 : in    std_logic                     := '0';             --             clk.clk
		reset_reset             : in    std_logic                     := '0';             --           reset.reset
		sdram_clk_clk           : out   std_logic;                                        --       sdram_clk.clk
		sdram_wire_addr         : out   std_logic_vector(11 downto 0);                    --      sdram_wire.addr
		sdram_wire_ba           : out   std_logic;                                        --                .ba
		sdram_wire_cas_n        : out   std_logic;                                        --                .cas_n
		sdram_wire_cke          : out   std_logic;                                        --                .cke
		sdram_wire_cs_n         : out   std_logic;                                        --                .cs_n
		sdram_wire_dq           : inout std_logic_vector(31 downto 0) := (others => '0'); --                .dq
		sdram_wire_dqm          : out   std_logic_vector(3 downto 0);                     --                .dqm
		sdram_wire_ras_n        : out   std_logic;                                        --                .ras_n
		sdram_wire_we_n         : out   std_logic;                                        --                .we_n
		
		VGA_R : out std_logic_vector(7 downto 0);
		VGA_G : out std_logic_vector(7 downto 0);
		VGA_B : out std_logic_vector(7 downto 0);
		VGA_CLK : out std_logic;
		VGA_HS : out std_logic;
		VGA_VS : out std_logic;
		VGA_BLANK : out std_logic;
		VGA_SYNC : out std_logic
	);
end entity Main;

architecture rtl of Main is
	component NIOSII_Test is
		port (
			audio_interface_ADCDAT  : in    std_logic                     := '0';             -- audio_interface.ADCDAT
			audio_interface_ADCLRCK : in    std_logic                     := '0';             --                .ADCLRCK
			audio_interface_BCLK    : in    std_logic                     := '0';             --                .BCLK
			clk_clk                 : in    std_logic                     := '0';             --             clk.clk
			reset_reset             : in    std_logic                     := '0';             --           reset.reset
			sdram_clk_clk           : out   std_logic;                                        --       sdram_clk.clk
			sdram_wire_addr         : out   std_logic_vector(11 downto 0);                    --      sdram_wire.addr
			sdram_wire_ba           : out   std_logic;                                        --                .ba
			sdram_wire_cas_n        : out   std_logic;                                        --                .cas_n
			sdram_wire_cke          : out   std_logic;                                        --                .cke
			sdram_wire_cs_n         : out   std_logic;                                        --                .cs_n
			sdram_wire_dq           : inout std_logic_vector(31 downto 0) := (others => '0'); --                .dq
			sdram_wire_dqm          : out   std_logic_vector(3 downto 0);                     --                .dqm
			sdram_wire_ras_n        : out   std_logic;                                        --                .ras_n
			sdram_wire_we_n         : out   std_logic;                                        --                .we_n
			video_clk_clk           : out   std_logic;                                        --       video_clk.clk
			video_reset_reset       : out   std_logic                                         --     video_reset.reset
		);
	end component NIOSII_Test;
	
	component vga_controller is
		generic(
			h_pulse 	:	INTEGER := 96;    	--horiztonal sync pulse width in pixels
			h_bp	 	:	INTEGER := 48;		--horiztonal back porch width in pixels
			h_pixels	:	INTEGER := 640;		--horiztonal display width in pixels
			h_fp	 	:	INTEGER := 16;		--horiztonal front porch width in pixels
			h_pol		:	STD_LOGIC := '0';		--horizontal sync pulse polarity (1 = positive, 0 = negative)
			v_pulse 	:	INTEGER := 2;			--vertical sync pulse width in rows
			v_bp	 	:	INTEGER := 33;			--vertical back porch width in rows
			v_pixels	:	INTEGER := 480;		--vertical display width in rows
			v_fp	 	:	INTEGER := 10;			--vertical front porch width in rows
			v_pol		:	STD_LOGIC := '0'	--vertical sync pulse polarity (1 = positive, 0 = negative)
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
	
	signal vga_pixel_clock : std_logic;
	signal vga_pixel_reset : std_logic;
	signal vga_is_on_screen : std_logic;
	signal vga_current_x : integer;
	signal vga_current_y : integer;
begin
	nios2_core : NIOSII_Test port map(
			audio_interface_ADCDAT  => audio_interface_ADCDAT,
			audio_interface_ADCLRCK => audio_interface_ADCLRCK,
			audio_interface_BCLK    => audio_interface_BCLK,
			clk_clk                 => clk_clk,
			reset_reset             => reset_reset,
			sdram_clk_clk           => sdram_clk_clk,
			sdram_wire_addr         => sdram_wire_addr,
			sdram_wire_ba           => sdram_wire_ba,
			sdram_wire_cas_n        => sdram_wire_cas_n,
			sdram_wire_cke          => sdram_wire_cke,
			sdram_wire_cs_n         => sdram_wire_cs_n,
			sdram_wire_dq           => sdram_wire_dq,
			sdram_wire_dqm          => sdram_wire_dqm,
			sdram_wire_ras_n        => sdram_wire_ras_n,
			sdram_wire_we_n         => sdram_wire_we_n,
			video_clk_clk           => vga_pixel_clock,
			video_reset_reset       => vga_pixel_reset
	);
	
	vga : vga_controller port map(
		pixel_clk	=> vga_pixel_clock,
		reset_n		=> vga_pixel_reset,
		h_sync		=> VGA_HS,
		v_sync		=> VGA_VS,
		disp_ena		=> vga_is_on_screen,
		column		=> vga_current_y,
		row			=> vga_current_x,
		n_blank		=> VGA_BLANK,
		n_sync		=> VGA_SYNC
	);
	
	process(vga_pixel_clock)
	begin
		if vga_is_on_screen = '1' then
			VGA_R <= (others => '0');
			VGA_G <= (others => '1');
			VGA_B <= (others => '0');
		else
			VGA_R <= (others => '0');
			VGA_G <= (others => '0');
			VGA_B <= (others => '0');
		end if;
	end process;
end architecture rtl;
