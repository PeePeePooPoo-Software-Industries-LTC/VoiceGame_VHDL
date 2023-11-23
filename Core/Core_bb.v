
module Core (
	clk_clk,
	clk_25_clk,
	i2c_serial_sda_in,
	i2c_serial_scl_in,
	i2c_serial_sda_oe,
	i2c_serial_scl_oe,
	reset_reset_n,
	vga_external_interface_CLK,
	vga_external_interface_HS,
	vga_external_interface_VS,
	vga_external_interface_BLANK,
	vga_external_interface_SYNC,
	vga_external_interface_R,
	vga_external_interface_G,
	vga_external_interface_B,
	vga_sink_data,
	vga_sink_startofpacket,
	vga_sink_endofpacket,
	vga_sink_valid,
	vga_sink_ready);	

	input		clk_clk;
	input		clk_25_clk;
	input		i2c_serial_sda_in;
	input		i2c_serial_scl_in;
	output		i2c_serial_sda_oe;
	output		i2c_serial_scl_oe;
	input		reset_reset_n;
	output		vga_external_interface_CLK;
	output		vga_external_interface_HS;
	output		vga_external_interface_VS;
	output		vga_external_interface_BLANK;
	output		vga_external_interface_SYNC;
	output	[7:0]	vga_external_interface_R;
	output	[7:0]	vga_external_interface_G;
	output	[7:0]	vga_external_interface_B;
	input	[29:0]	vga_sink_data;
	input		vga_sink_startofpacket;
	input		vga_sink_endofpacket;
	input		vga_sink_valid;
	output		vga_sink_ready;
endmodule
