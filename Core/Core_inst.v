	Core u0 (
		.clk_clk                      (<connected-to-clk_clk>),                      //                    clk.clk
		.clk_25_clk                   (<connected-to-clk_25_clk>),                   //                 clk_25.clk
		.i2c_serial_sda_in            (<connected-to-i2c_serial_sda_in>),            //             i2c_serial.sda_in
		.i2c_serial_scl_in            (<connected-to-i2c_serial_scl_in>),            //                       .scl_in
		.i2c_serial_sda_oe            (<connected-to-i2c_serial_sda_oe>),            //                       .sda_oe
		.i2c_serial_scl_oe            (<connected-to-i2c_serial_scl_oe>),            //                       .scl_oe
		.reset_reset_n                (<connected-to-reset_reset_n>),                //                  reset.reset_n
		.vga_external_interface_CLK   (<connected-to-vga_external_interface_CLK>),   // vga_external_interface.CLK
		.vga_external_interface_HS    (<connected-to-vga_external_interface_HS>),    //                       .HS
		.vga_external_interface_VS    (<connected-to-vga_external_interface_VS>),    //                       .VS
		.vga_external_interface_BLANK (<connected-to-vga_external_interface_BLANK>), //                       .BLANK
		.vga_external_interface_SYNC  (<connected-to-vga_external_interface_SYNC>),  //                       .SYNC
		.vga_external_interface_R     (<connected-to-vga_external_interface_R>),     //                       .R
		.vga_external_interface_G     (<connected-to-vga_external_interface_G>),     //                       .G
		.vga_external_interface_B     (<connected-to-vga_external_interface_B>),     //                       .B
		.vga_sink_data                (<connected-to-vga_sink_data>),                //               vga_sink.data
		.vga_sink_startofpacket       (<connected-to-vga_sink_startofpacket>),       //                       .startofpacket
		.vga_sink_endofpacket         (<connected-to-vga_sink_endofpacket>),         //                       .endofpacket
		.vga_sink_valid               (<connected-to-vga_sink_valid>),               //                       .valid
		.vga_sink_ready               (<connected-to-vga_sink_ready>)                //                       .ready
	);

