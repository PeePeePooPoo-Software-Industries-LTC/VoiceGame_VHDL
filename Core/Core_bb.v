
module Core (
	audio_external_interface_ADCDAT,
	audio_external_interface_ADCLRCK,
	audio_external_interface_BCLK,
	audio_external_interface_DACDAT,
	audio_external_interface_DACLRCK,
	clk_clk,
	reset_reset_n,
	vga_external_interface_CLK,
	vga_external_interface_HS,
	vga_external_interface_VS,
	vga_external_interface_BLANK,
	vga_external_interface_SYNC,
	vga_external_interface_R,
	vga_external_interface_G,
	vga_external_interface_B,
	clocked_video_conduit_vid_clk,
	clocked_video_conduit_vid_data,
	clocked_video_conduit_overflow,
	clocked_video_conduit_vid_datavalid,
	clocked_video_conduit_vid_locked);	

	input		audio_external_interface_ADCDAT;
	input		audio_external_interface_ADCLRCK;
	input		audio_external_interface_BCLK;
	output		audio_external_interface_DACDAT;
	input		audio_external_interface_DACLRCK;
	input		clk_clk;
	input		reset_reset_n;
	output		vga_external_interface_CLK;
	output		vga_external_interface_HS;
	output		vga_external_interface_VS;
	output		vga_external_interface_BLANK;
	output		vga_external_interface_SYNC;
	output	[7:0]	vga_external_interface_R;
	output	[7:0]	vga_external_interface_G;
	output	[7:0]	vga_external_interface_B;
	input		clocked_video_conduit_vid_clk;
	input	[29:0]	clocked_video_conduit_vid_data;
	output		clocked_video_conduit_overflow;
	input		clocked_video_conduit_vid_datavalid;
	input		clocked_video_conduit_vid_locked;
endmodule
