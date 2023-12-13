library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.math_real.all;

entity Main is
	port (
		I2C_SDAT       : inout std_logic                     := '0';             --    audio_config.SDAT
		I2C_SCLK       : out   std_logic;                                        --                .SCLK
		AUD_ADCDAT  : in    std_logic                     := '0';             -- audio_interface.ADCDAT
		AUD_ADCLRCK : in    std_logic                     := '0';             --                .ADCLRCK
		AUD_BCLK    : in    std_logic                     := '0';             --                .BCLK
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
			audio_config_SDAT       : inout std_logic                     := '0';             --    audio_config.SDAT
			audio_config_SCLK       : out   std_logic;                                        --                .SCLK
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
	
	type LineBuffer is array (639 downto 0) of std_logic_vector(23 downto 0);
	signal line_buffer : LineBuffer;
	
	signal buttons_sig : std_logic_vector(31 downto 0);
begin
	buttons_sig(3 downto 0) <= SW(3 downto 0);

	nios2_core : NIOSII_Test port map(
			audio_config_SDAT       => I2C_SDAT,
			audio_config_SCLK       => I2C_SCLK,
			audio_interface_ADCDAT  => AUD_ADCDAT,
			audio_interface_ADCLRCK => AUD_ADCLRCK,
			audio_interface_BCLK    => AUD_BCLK,
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
end architecture rtl;
