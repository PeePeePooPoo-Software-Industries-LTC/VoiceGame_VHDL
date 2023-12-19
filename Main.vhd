library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.math_real.all;

entity Main is
    port (
        -- Basic system clock & reset pins
        clk_clk     : in    std_logic                       := '0';
        reset_reset : in    std_logic                       := '0';

        -- Audio pins
        I2C_SDAT    : inout std_logic                       := '0';
        I2C_SCLK    : out   std_logic;
        AUD_ADCDAT  : in    std_logic                       := '0';
        AUD_ADCLRCK : in    std_logic                       := '0';
        AUD_BCLK    : in    std_logic                       := '0';
        AUD_XCK     : out   std_logic;

        -- SRAM pins
        sram_DQ     : inout std_logic_vector(15 downto 0)   := (others => '0');
        sram_ADDR   : out   std_logic_vector(19 downto 0);
        sram_LB_N   : out   std_logic;
        sram_UB_N   : out   std_logic;
        sram_CE_N   : out   std_logic;
        sram_OE_N   : out   std_logic;
        sram_WE_N   : out   std_logic;

        -- VGA pins
        VGA_R       : out   std_logic_vector(7  downto 0);
        VGA_G       : out   std_logic_vector(7  downto 0);
        VGA_B       : out   std_logic_vector(7  downto 0);
        VGA_CLK     : out   std_logic;
        VGA_HS      : out   std_logic;
        VGA_VS      : out   std_logic;
        VGA_BLANK   : out   std_logic;
        VGA_SYNC    : out   std_logic;

        -- FPGA board utility pins
        GPIO        : out   std_logic_vector(35 downto 0);
		  KEY			  : in	 std_logic_vector(3 downto 0);
        LEDR        : out   std_logic_vector(17 downto 0);
        LEDG        : out   std_logic_vector(7  downto 0)
    );
end entity Main;

architecture rtl of Main is
    component NIOSII_Test is
        port (
            audio_config_SDAT       : inout std_logic                       := '0';
            audio_config_SCLK       : out   std_logic;
            audio_interface_ADCDAT  : in    std_logic                       := '0';
            audio_interface_ADCLRCK : in    std_logic                       := '0';
            audio_interface_BCLK    : in    std_logic                       := '0';
            audio_clk_clk           : out   std_logic;

            clk_clk                 : in    std_logic                       := '0';
            reset_reset_n           : in    std_logic                       := '0';

            sram_DQ                 : inout std_logic_vector(15 downto 0)   := (others => '0');
            sram_ADDR               : out   std_logic_vector(19 downto 0);
            sram_LB_N               : out   std_logic;
            sram_UB_N               : out   std_logic;
            sram_CE_N               : out   std_logic;
            sram_OE_N               : out   std_logic;
            sram_WE_N               : out   std_logic;

            buttons_export          : in    std_logic_vector(3 downto 0);

            vga_CLK                 : out   std_logic;
            vga_HS                  : out   std_logic;
            vga_VS                  : out   std_logic;
            vga_BLANK               : out   std_logic;
            vga_SYNC                : out   std_logic;
            vga_R                   : out   std_logic_vector(7  downto 0);
            vga_G                   : out   std_logic_vector(7  downto 0);
            vga_B                   : out   std_logic_vector(7  downto 0)                      --                                       .B
        );
    end component NIOSII_Test;
    
    component video_pll is
        port(
            inclk0 : IN STD_LOGIC  := '0';
            c0         : OUT STD_LOGIC 
        );
    end component video_pll;
    
    signal button_passthrough : std_logic_vector(3 downto 0);
begin
    button_passthrough(KEY'range) <= KEY;
    
    nios2_core : NIOSII_Test port map(
        clk_clk                 => clk_clk,
        reset_reset_n           => reset_reset,

        audio_config_SDAT       => I2C_SDAT,
        audio_config_SCLK       => I2C_SCLK,
        audio_interface_ADCDAT  => AUD_ADCDAT,
        audio_interface_ADCLRCK => AUD_ADCLRCK,
        audio_interface_BCLK    => AUD_BCLK,
        audio_clk_clk           => AUD_XCK,

        sram_DQ                 => sram_DQ,
        sram_ADDR               => sram_ADDR,
        sram_LB_N               => sram_LB_N,
        sram_UB_N               => sram_UB_N,
        sram_CE_N               => sram_CE_N,
        sram_OE_N               => sram_OE_N,
        sram_WE_N               => sram_WE_N,
        
        buttons_export          => button_passthrough,

        vga_CLK                 => vga_CLK,
        vga_HS                  => vga_HS,
        vga_VS                  => vga_VS,
        vga_BLANK               => vga_BLANK,
        vga_SYNC                => vga_SYNC,
        vga_R                   => vga_R,
        vga_G                   => vga_G,
        vga_B                   => vga_B
    );
end architecture rtl;
