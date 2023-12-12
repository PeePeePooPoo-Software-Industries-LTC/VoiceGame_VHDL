library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.math_real.all;

entity Main is
	port (
		I2C_SDAT							 : inout std_logic                     := '0';             -- audio_and_video_export.SDAT
		I2C_SCLK							 : out   std_logic;                                        --                       .SCLK
		AUD_ADCDAT				       : in    std_logic                     := '0';             --        audio_interface.ADCDAT
		AUD_ADCLRCK				       : in    std_logic                     := '0';             --                       .ADCLRCK
		AUD_BCLK				          : in    std_logic                     := '0';             --                       .BCLK
		clk_clk                     : in    std_logic                     := '0';             --                    clk.clk
		reset_reset                 : in    std_logic                     := '0';             --                  reset.reset
		sdram_clk_clk               : out   std_logic;                                        --              sdram_clk.clk
		sdram_wire_addr             : out   std_logic_vector(11 downto 0);                    --             sdram_wire.addr
		sdram_wire_ba               : out   std_logic;                                        --                       .ba
		sdram_wire_cas_n            : out   std_logic;                                        --                       .cas_n
		sdram_wire_cke              : out   std_logic;                                        --                       .cke
		sdram_wire_cs_n             : out   std_logic;                                        --                       .cs_n
		sdram_wire_dq               : inout std_logic_vector(31 downto 0) := (others => '0'); --                       .dq
		sdram_wire_dqm              : out   std_logic_vector(3 downto 0);                     --                       .dqm
		sdram_wire_ras_n            : out   std_logic;                                        --                       .ras_n
		sdram_wire_we_n             : out   std_logic;		--                       .we_n
		LEDR								 : out	std_logic_vector(17 downto 0);
		SW									 : in		std_logic_vector(17 downto 0);
		GPIO 								 : inout std_logic_vector(35 downto 0)
	);
end entity Main;

architecture rtl of Main is
	component NIOSII_Test is
		port (
			audio_and_video_export_SDAT : inout std_logic                     := '0';             -- audio_and_video_export.SDAT
			audio_and_video_export_SCLK : out   std_logic;                                        --                       .SCLK
			audio_interface_ADCDAT      : in    std_logic                     := '0';             --        audio_interface.ADCDAT
			audio_interface_ADCLRCK     : in    std_logic                     := '0';             --                       .ADCLRCK
			audio_interface_BCLK        : in    std_logic                     := '0';             --                       .BCLK
			clk_clk                     : in    std_logic                     := '0';             --                    clk.clk
			pio_ledr_export             : out   std_logic_vector(17 downto 0);                    --               pio_ledr.export
			pio_switches_export         : in    std_logic_vector(17 downto 0) := (others => '0'); --           pio_switches.export
			reset_reset                 : in    std_logic                     := '0';             --                  reset.reset
			sdram_clk_clk               : out   std_logic;                                        --              sdram_clk.clk
			sdram_wire_addr             : out   std_logic_vector(11 downto 0);                    --             sdram_wire.addr
			sdram_wire_ba               : out   std_logic;                                        --                       .ba
			sdram_wire_cas_n            : out   std_logic;                                        --                       .cas_n
			sdram_wire_cke              : out   std_logic;                                        --                       .cke
			sdram_wire_cs_n             : out   std_logic;                                        --                       .cs_n
			sdram_wire_dq               : inout std_logic_vector(31 downto 0) := (others => '0'); --                       .dq
			sdram_wire_dqm              : out   std_logic_vector(3 downto 0);                     --                       .dqm
			sdram_wire_ras_n            : out   std_logic;                                        --                       .ras_n
			sdram_wire_we_n             : out   std_logic                                         --                       .we_n
		);
	end component NIOSII_Test;
	
	signal LEDR_signal  : std_logic_vector(17 downto 0);
	signal SWITCHES_signal  : std_logic_vector(17 downto 0);
	
begin
	
	Main_test : component NIOSII_Test
		port map (
			clk_clk       => clk_clk,        --       clk.clk
			reset_reset   => reset_reset,    -- clk_reset.reset
			pio_ledr_export => LEDR_signal,           -- 
			pio_switches_export => SWITCHES_signal,           -- .
			audio_interface_BCLK    =>  AUD_BCLK,               --    .
			audio_interface_ADCLRCK => AUD_ADCLRCK,           -- .
			audio_interface_ADCDAT => AUD_ADCDAT,           -- .
			audio_and_video_export_SCLK => I2C_SCLK,           -- .
			audio_and_video_export_SDAT => I2C_SDAT,           -- .
			sdram_clk_clk => sdram_clk_clk,           -- .
			sdram_wire_addr => sdram_wire_addr,           -- .
			sdram_wire_ba => sdram_wire_ba,
			sdram_wire_cas_n => sdram_wire_cas_n,
			sdram_wire_cke => sdram_wire_cke,
			sdram_wire_cs_n => sdram_wire_cs_n,
			sdram_wire_dq => sdram_wire_dq,
			sdram_wire_dqm => sdram_wire_dqm,
			sdram_wire_ras_n => sdram_wire_ras_n,
			sdram_wire_we_n => sdram_wire_we_n
		);
		
		LEDR <= LEDR_signal;
		SWITCHES_signal <= SW;
		GPIO(0) <= AUD_BCLK;
		GPIO(1) <= AUD_ADCLRCK;
		GPIO(2) <= AUD_ADCDAT;
		

end architecture rtl;




