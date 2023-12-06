	component NIOSII_Test is
		port (
			audio_interface_ADCDAT                        : in    std_logic                     := 'X';             -- ADCDAT
			audio_interface_ADCLRCK                       : in    std_logic                     := 'X';             -- ADCLRCK
			audio_interface_BCLK                          : in    std_logic                     := 'X';             -- BCLK
			clk_clk                                       : in    std_logic                     := 'X';             -- clk
			pio_pixel_color_external_connection_export    : out   std_logic_vector(23 downto 0);                    -- export
			pio_pixel_position_external_connection_export : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
			pio_request_external_connection_export        : in    std_logic                     := 'X';             -- export
			reset_reset                                   : in    std_logic                     := 'X';             -- reset
			sdram_clk_clk                                 : out   std_logic;                                        -- clk
			sdram_wire_addr                               : out   std_logic_vector(11 downto 0);                    -- addr
			sdram_wire_ba                                 : out   std_logic;                                        -- ba
			sdram_wire_cas_n                              : out   std_logic;                                        -- cas_n
			sdram_wire_cke                                : out   std_logic;                                        -- cke
			sdram_wire_cs_n                               : out   std_logic;                                        -- cs_n
			sdram_wire_dq                                 : inout std_logic_vector(31 downto 0) := (others => 'X'); -- dq
			sdram_wire_dqm                                : out   std_logic_vector(3 downto 0);                     -- dqm
			sdram_wire_ras_n                              : out   std_logic;                                        -- ras_n
			sdram_wire_we_n                               : out   std_logic                                         -- we_n
		);
	end component NIOSII_Test;

	u0 : component NIOSII_Test
		port map (
			audio_interface_ADCDAT                        => CONNECTED_TO_audio_interface_ADCDAT,                        --                        audio_interface.ADCDAT
			audio_interface_ADCLRCK                       => CONNECTED_TO_audio_interface_ADCLRCK,                       --                                       .ADCLRCK
			audio_interface_BCLK                          => CONNECTED_TO_audio_interface_BCLK,                          --                                       .BCLK
			clk_clk                                       => CONNECTED_TO_clk_clk,                                       --                                    clk.clk
			pio_pixel_color_external_connection_export    => CONNECTED_TO_pio_pixel_color_external_connection_export,    --    pio_pixel_color_external_connection.export
			pio_pixel_position_external_connection_export => CONNECTED_TO_pio_pixel_position_external_connection_export, -- pio_pixel_position_external_connection.export
			pio_request_external_connection_export        => CONNECTED_TO_pio_request_external_connection_export,        --        pio_request_external_connection.export
			reset_reset                                   => CONNECTED_TO_reset_reset,                                   --                                  reset.reset
			sdram_clk_clk                                 => CONNECTED_TO_sdram_clk_clk,                                 --                              sdram_clk.clk
			sdram_wire_addr                               => CONNECTED_TO_sdram_wire_addr,                               --                             sdram_wire.addr
			sdram_wire_ba                                 => CONNECTED_TO_sdram_wire_ba,                                 --                                       .ba
			sdram_wire_cas_n                              => CONNECTED_TO_sdram_wire_cas_n,                              --                                       .cas_n
			sdram_wire_cke                                => CONNECTED_TO_sdram_wire_cke,                                --                                       .cke
			sdram_wire_cs_n                               => CONNECTED_TO_sdram_wire_cs_n,                               --                                       .cs_n
			sdram_wire_dq                                 => CONNECTED_TO_sdram_wire_dq,                                 --                                       .dq
			sdram_wire_dqm                                => CONNECTED_TO_sdram_wire_dqm,                                --                                       .dqm
			sdram_wire_ras_n                              => CONNECTED_TO_sdram_wire_ras_n,                              --                                       .ras_n
			sdram_wire_we_n                               => CONNECTED_TO_sdram_wire_we_n                                --                                       .we_n
		);

