
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
		sdram_clk_clk           : out   std_logic;                                        --       sdram_clk.clk
		sdram_wire_addr         : out   std_logic_vector(12 downto 0);                    --      sdram_wire.addr
		sdram_wire_ba           : out   std_logic_vector(1 downto 0);                                        --                .ba
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
		VGA_SYNC : out std_logic;
		
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
			reset_reset             : in    std_logic                     := '0';             --           reset.reset
			sdram_clk_clk           : out   std_logic;                                        --       sdram_clk.clk
			sdram_wire_addr         : out   std_logic_vector(12 downto 0);                    --      sdram_wire.addr
			sdram_wire_ba           : out   std_logic_vector(1 downto 0);                                        --                .ba
			sdram_wire_cas_n        : out   std_logic;                                        --                .cas_n
			sdram_wire_cke          : out   std_logic;                                        --                .cke
			sdram_wire_cs_n         : out   std_logic;                                        --                .cs_n
			sdram_wire_dq           : inout std_logic_vector(31 downto 0) := (others => '0'); --                .dq
			sdram_wire_dqm          : out   std_logic_vector(3 downto 0);                     --                .dqm
			sdram_wire_ras_n        : out   std_logic;                                        --                .ras_n
			sdram_wire_we_n         : out   std_logic                                         --                .we_n
		);
	end component NIOSII_Test;
	
	component sdram is
		generic (
			-- clock frequency (in MHz)
			--
			-- This value must be provided, as it is used to calculate the number of
			-- clock cycles required for the other timing values.
		 CLK_FREQ : real;

		 -- 32-bit controller interface
		 ADDR_WIDTH : natural := 23;
		 DATA_WIDTH : natural := 32;

		 -- SDRAM interface
		 SDRAM_ADDR_WIDTH : natural := 13;
		 SDRAM_DATA_WIDTH : natural := 16;
		 SDRAM_COL_WIDTH  : natural := 9;
		 SDRAM_ROW_WIDTH  : natural := 13;
		 SDRAM_BANK_WIDTH : natural := 2;

		 -- The delay in clock cycles, between the start of a read command and the
		 -- availability of the output data.
		 CAS_LATENCY : natural := 2; -- 2=below 133MHz, 3=above 133MHz

		 -- The number of 16-bit words to be bursted during a read/write.
		 BURST_LENGTH : natural := 2;

		 -- timing values (in nanoseconds)
		 --
		 -- These values can be adjusted to match the exact timing of your SDRAM
		 -- chip (refer to the datasheet).
		 T_DESL : real := 200000.0; -- startup delay
		 T_MRD  : real :=     12.0; -- mode register cycle time
		 T_RC   : real :=     60.0; -- row cycle time
		 T_RCD  : real :=     18.0; -- RAS to CAS delay
		 T_RP   : real :=     18.0; -- precharge to activate delay
		 T_WR   : real :=     12.0; -- write recovery time
		 T_REFI : real :=   7800.0  -- average refresh interval
		);
		port (
		 -- reset
		 reset : in std_logic := '0';

		 -- clock
		 clk : in std_logic;

		 -- address bus
		 addr : in unsigned(ADDR_WIDTH-1 downto 0);

		 -- input data bus
		 data : in std_logic_vector(DATA_WIDTH-1 downto 0);

		 -- When the write enable signal is asserted, a write operation will be performed.
		 we : in std_logic;

		 -- When the request signal is asserted, an operation will be performed.
		 req : in std_logic;

		 -- The acknowledge signal is asserted by the SDRAM controller when
		 -- a request has been accepted.
		 ack : out std_logic;

		 -- The valid signal is asserted when there is a valid word on the output
		 -- data bus.
		 valid : out std_logic;

		 -- output data bus
		 q : out std_logic_vector(DATA_WIDTH-1 downto 0);

		 -- SDRAM interface (e.g. AS4C16M16SA-6TCN, IS42S16400F, etc.)
		 sdram_a     : out unsigned(SDRAM_ADDR_WIDTH-1 downto 0);
		 sdram_ba    : out unsigned(SDRAM_BANK_WIDTH-1 downto 0);
		 sdram_dq    : inout std_logic_vector(SDRAM_DATA_WIDTH-1 downto 0);
		 sdram_cke   : out std_logic;
		 sdram_cs_n  : out std_logic;
		 sdram_ras_n : out std_logic;
		 sdram_cas_n : out std_logic;
		 sdram_we_n  : out std_logic;
		 sdram_dqml  : out std_logic;
		 sdram_dqmh  : out std_logic
	  );
	end component sdram;
		
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
	
	signal vga_pixel_clock : std_logic;
	signal vga_is_on_screen : std_logic;
	signal vga_current_x : integer;
	signal vga_current_y : integer;
	
	type LineBuffer is array (639 downto 0) of std_logic_vector(23 downto 0);
	signal line_buffer : LineBuffer;
	
	-- signals for SDRAM
	signal sdram_addr : unsigned(22 downto 0);
	signal sdram_data : std_logic_vector(31 downto 0);
	signal sdram_we	: std_logic;
	signal sdram_req	: std_logic;
	signal sdram_ack	: std_logic; -- Output.
	signal sdram_valid	: std_logic; -- Output if valid word.
	signal sdram_output	: std_logic_vector(31 downto 0);
	
	signal sdram_a_to_sdram_wire_a : unsigned(12 downto 0);
	signal sdram_ba_to_sdram_wire_ba : unsigned(1 downto 0);
	
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
			sdram_wire_we_n         => sdram_wire_we_n
	);
	
	vga : vga_controller generic map(
		h_pulse 	=> 96,    	--horiztonal sync pulse width in pixels
		h_bp	 	=> 48, 	--horiztonal back porch width in pixels
		h_pixels	=> 640,		--horiztonal display width in pixels
		h_fp	 	=> 16,		--horiztonal front porch width in pixels
		h_pol		=> '0',		--horizontal sync pulse polarity (1 = positive, 0 = negative)
		v_pulse 	=> 3,			--vertical sync pulse width in rows
		v_bp	 	=> 28,			--vertical back porch width in rows
		v_pixels	=> 480,		--vertical display width in rows
		v_fp	 	=> 9,			--vertical front porch width in rows
		v_pol		=> '0'	--vertical sync pulse polarity (1 = positive, 0 = negative)
	)	port map(
		pixel_clk	=> vga_pixel_clock,
		reset_n		=> reset_reset,
		h_sync		=> VGA_HS,
		v_sync		=> VGA_VS,
		disp_ena		=> vga_is_on_screen,
		column		=> vga_current_x,
		row			=> vga_current_y,
		n_blank		=> VGA_BLANK,
		n_sync		=> VGA_SYNC
	);
	
	video_pll_component : video_pll port map(
		inclk0 => clk_clk,
		c0 => vga_pixel_clock
	);	
	
	-- :(
	sdram_wire_addr	<= std_logic_vector(sdram_a_to_sdram_wire_a);
	sdram_wire_ba		<= std_logic_vector(sdram_ba_to_sdram_wire_ba);
	
	sdram_controller : sdram generic map(
	
	-- Generic map for SDRAM
		CLK_FREQ => 50.0, -- clock frequency (in MHz)
		T_DESL	=> 200000.0, -- startup delay in ns
		T_MRD		=> 12.0, -- mode register cycle time
		T_RC   	=> 60.0, -- row cycle time
		T_RCD		=> 18.0, -- RAS to CAS delay
		T_RP 		=> 18.0, -- precharge to activate delay
		T_WR  	=> 12.0, -- write recovery time
		T_REFI 	=> 7800.0  -- average refresh interval
	) port map(
		clk => clk_clk,
		addr => sdram_addr,
		data => sdram_data,
		we => sdram_we,
		req => sdram_req,
		ack => sdram_ack,
		valid => sdram_valid,
		q => sdram_output,
		
		sdram_a	=> sdram_a_to_sdram_wire_a,
		sdram_ba	=> sdram_ba_to_sdram_wire_ba,
		sdram_dq	=> sdram_wire_dq(15 downto 0),
		sdram_cke	=>	sdram_wire_cke,
		sdram_cs_n	=> sdram_wire_cs_n,
		sdram_ras_n => sdram_wire_ras_n,
		sdram_cas_n => sdram_wire_cas_n,
		sdram_we_n	=> sdram_wire_we_n,
		sdram_dqml	=>	sdram_wire_dqm(0),
		sdram_dqmh	=>	sdram_wire_dqm(1)
		
--		sdram_a     : out unsigned(SDRAM_ADDR_WIDTH-1 downto 0);
--    sdram_ba    : out unsigned(SDRAM_BANK_WIDTH-1 downto 0);
--    sdram_dq    : inout std_logic_vector(SDRAM_DATA_WIDTH-1 downto 0);
--    sdram_cke   : out std_logic;
--    sdram_cs_n  : out std_logic;
--    sdram_ras_n : out std_logic;
--    sdram_cas_n : out std_logic;
--    sdram_we_n  : out std_logic;
--    sdram_dqml  : out std_logic;
--    sdram_dqmh  : out std_logic
	);
	-- Port map.
--	 -- reset
--		 reset : in std_logic := '0';
--
--		 -- clock
--		 clk : in std_logic;
--
--		 -- address bus
--		 addr : in unsigned(ADDR_WIDTH-1 downto 0);
--
--		 -- input data bus
--		 data : in std_logic_vector(DATA_WIDTH-1 downto 0);
--
--		 -- When the write enable signal is asserted, a write operation will be performed.
--		 we : in std_logic;
--
--		 -- When the request signal is asserted, an operation will be performed.
--		 req : in std_logic;
--
--		 -- The acknowledge signal is asserted by the SDRAM controller when
--		 -- a request has been accepted.
--		 ack : out std_logic;
--
--		 -- The valid signal is asserted when there is a valid word on the output
--		 -- data bus.
--		 valid : out std_logic;
--
--		 -- output data bus
--		 q : out std_logic_vector(DATA_WIDTH-1 downto 0);

	process(vga_is_on_screen, vga_current_x, vga_current_y)
		variable first : std_logic := '0';
		variable color : std_logic_vector(23 downto 0) := (others => '0');
	begin
		if (first = '0') then
			color := "000000000000000011111111";
			sdram_addr <= (others => '0');
			sdram_data <= (others => '0');
			sdram_we <= '1';
			sdram_req <= '1';
			
			-- ???
			
			sdram_req <= '0';
			
			first := '1';
		end if;
	
		if (vga_is_on_screen = '1') then
			VGA_R <= color(23 downto 16);
			VGA_G <= color(15 downto 8);
			VGA_B <= color(7 downto 0);
		else
			VGA_R <= (others => '0');
			VGA_G <= (others => '0');
			VGA_B <= (others => '0');
		end if;
	end process;
	
	VGA_CLK <= vga_pixel_clock;
	LEDR(0) <= sdram_ack;
	LEDR(1) <= sdram_valid;
end architecture rtl;
