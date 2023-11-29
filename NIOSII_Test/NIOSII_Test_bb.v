
module NIOSII_Test (
	audio_interface_ADCDAT,
	audio_interface_ADCLRCK,
	audio_interface_BCLK,
	sdram_wire_addr,
	sdram_wire_ba,
	sdram_wire_cas_n,
	sdram_wire_cke,
	sdram_wire_cs_n,
	sdram_wire_dq,
	sdram_wire_dqm,
	sdram_wire_ras_n,
	sdram_wire_we_n,
	vga_CLK,
	vga_HS,
	vga_VS,
	vga_BLANK,
	vga_SYNC,
	vga_R,
	vga_G,
	vga_B,
	clk_clk,
	reset_reset,
	sdram_clk_clk);	

	input		audio_interface_ADCDAT;
	input		audio_interface_ADCLRCK;
	input		audio_interface_BCLK;
	output	[11:0]	sdram_wire_addr;
	output		sdram_wire_ba;
	output		sdram_wire_cas_n;
	output		sdram_wire_cke;
	output		sdram_wire_cs_n;
	inout	[31:0]	sdram_wire_dq;
	output	[3:0]	sdram_wire_dqm;
	output		sdram_wire_ras_n;
	output		sdram_wire_we_n;
	output		vga_CLK;
	output		vga_HS;
	output		vga_VS;
	output		vga_BLANK;
	output		vga_SYNC;
	output	[7:0]	vga_R;
	output	[7:0]	vga_G;
	output	[7:0]	vga_B;
	input		clk_clk;
	input		reset_reset;
	output		sdram_clk_clk;
endmodule
