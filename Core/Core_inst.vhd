	component Core is
		port (
			clk_clk                      : in  std_logic                     := 'X';             -- clk
			clk_25_clk                   : in  std_logic                     := 'X';             -- clk
			i2c_serial_sda_in            : in  std_logic                     := 'X';             -- sda_in
			i2c_serial_scl_in            : in  std_logic                     := 'X';             -- scl_in
			i2c_serial_sda_oe            : out std_logic;                                        -- sda_oe
			i2c_serial_scl_oe            : out std_logic;                                        -- scl_oe
			reset_reset_n                : in  std_logic                     := 'X';             -- reset_n
			vga_external_interface_CLK   : out std_logic;                                        -- CLK
			vga_external_interface_HS    : out std_logic;                                        -- HS
			vga_external_interface_VS    : out std_logic;                                        -- VS
			vga_external_interface_BLANK : out std_logic;                                        -- BLANK
			vga_external_interface_SYNC  : out std_logic;                                        -- SYNC
			vga_external_interface_R     : out std_logic_vector(7 downto 0);                     -- R
			vga_external_interface_G     : out std_logic_vector(7 downto 0);                     -- G
			vga_external_interface_B     : out std_logic_vector(7 downto 0);                     -- B
			vga_sink_data                : in  std_logic_vector(29 downto 0) := (others => 'X'); -- data
			vga_sink_startofpacket       : in  std_logic                     := 'X';             -- startofpacket
			vga_sink_endofpacket         : in  std_logic                     := 'X';             -- endofpacket
			vga_sink_valid               : in  std_logic                     := 'X';             -- valid
			vga_sink_ready               : out std_logic                                         -- ready
		);
	end component Core;

	u0 : component Core
		port map (
			clk_clk                      => CONNECTED_TO_clk_clk,                      --                    clk.clk
			clk_25_clk                   => CONNECTED_TO_clk_25_clk,                   --                 clk_25.clk
			i2c_serial_sda_in            => CONNECTED_TO_i2c_serial_sda_in,            --             i2c_serial.sda_in
			i2c_serial_scl_in            => CONNECTED_TO_i2c_serial_scl_in,            --                       .scl_in
			i2c_serial_sda_oe            => CONNECTED_TO_i2c_serial_sda_oe,            --                       .sda_oe
			i2c_serial_scl_oe            => CONNECTED_TO_i2c_serial_scl_oe,            --                       .scl_oe
			reset_reset_n                => CONNECTED_TO_reset_reset_n,                --                  reset.reset_n
			vga_external_interface_CLK   => CONNECTED_TO_vga_external_interface_CLK,   -- vga_external_interface.CLK
			vga_external_interface_HS    => CONNECTED_TO_vga_external_interface_HS,    --                       .HS
			vga_external_interface_VS    => CONNECTED_TO_vga_external_interface_VS,    --                       .VS
			vga_external_interface_BLANK => CONNECTED_TO_vga_external_interface_BLANK, --                       .BLANK
			vga_external_interface_SYNC  => CONNECTED_TO_vga_external_interface_SYNC,  --                       .SYNC
			vga_external_interface_R     => CONNECTED_TO_vga_external_interface_R,     --                       .R
			vga_external_interface_G     => CONNECTED_TO_vga_external_interface_G,     --                       .G
			vga_external_interface_B     => CONNECTED_TO_vga_external_interface_B,     --                       .B
			vga_sink_data                => CONNECTED_TO_vga_sink_data,                --               vga_sink.data
			vga_sink_startofpacket       => CONNECTED_TO_vga_sink_startofpacket,       --                       .startofpacket
			vga_sink_endofpacket         => CONNECTED_TO_vga_sink_endofpacket,         --                       .endofpacket
			vga_sink_valid               => CONNECTED_TO_vga_sink_valid,               --                       .valid
			vga_sink_ready               => CONNECTED_TO_vga_sink_ready                --                       .ready
		);

