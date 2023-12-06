
module NIOSII_Test (
	audio_interface_ADCDAT,
	audio_interface_ADCLRCK,
	audio_interface_BCLK,
	clk_clk,
	pio_pixel_color_external_connection_export,
	pio_pixel_position_external_connection_export,
	pio_request_external_connection_export,
	reset_reset,
	sdram_clk_clk,
	sdram_wire_addr,
	sdram_wire_ba,
	sdram_wire_cas_n,
	sdram_wire_cke,
	sdram_wire_cs_n,
	sdram_wire_dq,
	sdram_wire_dqm,
	sdram_wire_ras_n,
	sdram_wire_we_n);	

	input		audio_interface_ADCDAT;
	input		audio_interface_ADCLRCK;
	input		audio_interface_BCLK;
	input		clk_clk;
	output	[23:0]	pio_pixel_color_external_connection_export;
	input	[31:0]	pio_pixel_position_external_connection_export;
	input		pio_request_external_connection_export;
	input		reset_reset;
	output		sdram_clk_clk;
	output	[11:0]	sdram_wire_addr;
	output		sdram_wire_ba;
	output		sdram_wire_cas_n;
	output		sdram_wire_cke;
	output		sdram_wire_cs_n;
	inout	[31:0]	sdram_wire_dq;
	output	[3:0]	sdram_wire_dqm;
	output		sdram_wire_ras_n;
	output		sdram_wire_we_n;
endmodule
