
module NIOSII_Test (
	audio_interface_ADCDAT,
	audio_interface_ADCLRCK,
	audio_interface_BCLK,
	clk_clk,
	reset_reset_n,
	vga_CLK,
	vga_HS,
	vga_VS,
	vga_BLANK,
	vga_SYNC,
	vga_R,
	vga_G,
	vga_B,
	sdram_interface_addr,
	sdram_interface_ba,
	sdram_interface_cas_n,
	sdram_interface_cke,
	sdram_interface_cs_n,
	sdram_interface_dq,
	sdram_interface_dqm,
	sdram_interface_ras_n,
	sdram_interface_we_n);	

	input		audio_interface_ADCDAT;
	input		audio_interface_ADCLRCK;
	input		audio_interface_BCLK;
	input		clk_clk;
	input		reset_reset_n;
	output		vga_CLK;
	output		vga_HS;
	output		vga_VS;
	output		vga_BLANK;
	output		vga_SYNC;
	output	[7:0]	vga_R;
	output	[7:0]	vga_G;
	output	[7:0]	vga_B;
	output	[11:0]	sdram_interface_addr;
	output		sdram_interface_ba;
	output		sdram_interface_cas_n;
	output		sdram_interface_cke;
	output		sdram_interface_cs_n;
	inout	[31:0]	sdram_interface_dq;
	output	[3:0]	sdram_interface_dqm;
	output		sdram_interface_ras_n;
	output		sdram_interface_we_n;
endmodule
