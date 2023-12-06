
module NIOSII_Test (
	audio_interface_ADCDAT,
	audio_interface_ADCLRCK,
	audio_interface_BCLK,
	audio_interface_DACDAT,
	audio_interface_DACLRCK,
	clk_clk,
	keys_export,
	ledgs_export,
	reset_reset_n,
	vga_CLK,
	vga_HS,
	vga_VS,
	vga_BLANK,
	vga_SYNC,
	vga_R,
	vga_G,
	vga_B);	

	input		audio_interface_ADCDAT;
	input		audio_interface_ADCLRCK;
	input		audio_interface_BCLK;
	output		audio_interface_DACDAT;
	input		audio_interface_DACLRCK;
	input		clk_clk;
	input	[2:0]	keys_export;
	output	[7:0]	ledgs_export;
	input		reset_reset_n;
	output		vga_CLK;
	output		vga_HS;
	output		vga_VS;
	output		vga_BLANK;
	output		vga_SYNC;
	output	[7:0]	vga_R;
	output	[7:0]	vga_G;
	output	[7:0]	vga_B;
endmodule
