	component NIOSII_Test is
		port (
			audio_interface_ADCDAT          : in    std_logic                     := 'X';             -- ADCDAT
			audio_interface_ADCLRCK         : in    std_logic                     := 'X';             -- ADCLRCK
			audio_interface_BCLK            : in    std_logic                     := 'X';             -- BCLK
			clk_clk                         : in    std_logic                     := 'X';             -- clk
			onchip_memory_access_address    : in    std_logic_vector(16 downto 0) := (others => 'X'); -- address
			onchip_memory_access_chipselect : in    std_logic                     := 'X';             -- chipselect
			onchip_memory_access_clken      : in    std_logic                     := 'X';             -- clken
			onchip_memory_access_write      : in    std_logic                     := 'X';             -- write
			onchip_memory_access_readdata   : out   std_logic_vector(31 downto 0);                    -- readdata
			onchip_memory_access_writedata  : in    std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			onchip_memory_access_byteenable : in    std_logic_vector(3 downto 0)  := (others => 'X'); -- byteenable
			reset_reset                     : in    std_logic                     := 'X';             -- reset
			sdram_clk_clk                   : out   std_logic;                                        -- clk
			sdram_wire_addr                 : out   std_logic_vector(11 downto 0);                    -- addr
			sdram_wire_ba                   : out   std_logic;                                        -- ba
			sdram_wire_cas_n                : out   std_logic;                                        -- cas_n
			sdram_wire_cke                  : out   std_logic;                                        -- cke
			sdram_wire_cs_n                 : out   std_logic;                                        -- cs_n
			sdram_wire_dq                   : inout std_logic_vector(31 downto 0) := (others => 'X'); -- dq
			sdram_wire_dqm                  : out   std_logic_vector(3 downto 0);                     -- dqm
			sdram_wire_ras_n                : out   std_logic;                                        -- ras_n
			sdram_wire_we_n                 : out   std_logic                                         -- we_n
		);
	end component NIOSII_Test;

	u0 : component NIOSII_Test
		port map (
			audio_interface_ADCDAT          => CONNECTED_TO_audio_interface_ADCDAT,          --      audio_interface.ADCDAT
			audio_interface_ADCLRCK         => CONNECTED_TO_audio_interface_ADCLRCK,         --                     .ADCLRCK
			audio_interface_BCLK            => CONNECTED_TO_audio_interface_BCLK,            --                     .BCLK
			clk_clk                         => CONNECTED_TO_clk_clk,                         --                  clk.clk
			onchip_memory_access_address    => CONNECTED_TO_onchip_memory_access_address,    -- onchip_memory_access.address
			onchip_memory_access_chipselect => CONNECTED_TO_onchip_memory_access_chipselect, --                     .chipselect
			onchip_memory_access_clken      => CONNECTED_TO_onchip_memory_access_clken,      --                     .clken
			onchip_memory_access_write      => CONNECTED_TO_onchip_memory_access_write,      --                     .write
			onchip_memory_access_readdata   => CONNECTED_TO_onchip_memory_access_readdata,   --                     .readdata
			onchip_memory_access_writedata  => CONNECTED_TO_onchip_memory_access_writedata,  --                     .writedata
			onchip_memory_access_byteenable => CONNECTED_TO_onchip_memory_access_byteenable, --                     .byteenable
			reset_reset                     => CONNECTED_TO_reset_reset,                     --                reset.reset
			sdram_clk_clk                   => CONNECTED_TO_sdram_clk_clk,                   --            sdram_clk.clk
			sdram_wire_addr                 => CONNECTED_TO_sdram_wire_addr,                 --           sdram_wire.addr
			sdram_wire_ba                   => CONNECTED_TO_sdram_wire_ba,                   --                     .ba
			sdram_wire_cas_n                => CONNECTED_TO_sdram_wire_cas_n,                --                     .cas_n
			sdram_wire_cke                  => CONNECTED_TO_sdram_wire_cke,                  --                     .cke
			sdram_wire_cs_n                 => CONNECTED_TO_sdram_wire_cs_n,                 --                     .cs_n
			sdram_wire_dq                   => CONNECTED_TO_sdram_wire_dq,                   --                     .dq
			sdram_wire_dqm                  => CONNECTED_TO_sdram_wire_dqm,                  --                     .dqm
			sdram_wire_ras_n                => CONNECTED_TO_sdram_wire_ras_n,                --                     .ras_n
			sdram_wire_we_n                 => CONNECTED_TO_sdram_wire_we_n                  --                     .we_n
		);

