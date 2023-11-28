
module NIOSII_Test (
	clk_clk,
	reset_reset_n,
	audio_interface_ADCDAT,
	audio_interface_ADCLRCK,
	audio_interface_BCLK,
	video_interface_CLK,
	video_interface_HS,
	video_interface_VS,
	video_interface_BLANK,
	video_interface_SYNC,
	video_interface_R,
	video_interface_G,
	video_interface_B);	

	input		clk_clk;
	input		reset_reset_n;
	input		audio_interface_ADCDAT;
	input		audio_interface_ADCLRCK;
	input		audio_interface_BCLK;
	output		video_interface_CLK;
	output		video_interface_HS;
	output		video_interface_VS;
	output		video_interface_BLANK;
	output		video_interface_SYNC;
	output	[7:0]	video_interface_R;
	output	[7:0]	video_interface_G;
	output	[7:0]	video_interface_B;
endmodule
