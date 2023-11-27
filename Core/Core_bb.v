
module Core (
	clk_clk,
	vga_external_interface_CLK,
	vga_external_interface_HS,
	vga_external_interface_VS,
	vga_external_interface_BLANK,
	vga_external_interface_SYNC,
	vga_external_interface_R,
	vga_external_interface_G,
	vga_external_interface_B,
	reset_reset_n,
	audio_0_external_interface_ADCDAT,
	audio_0_external_interface_ADCLRCK,
	audio_0_external_interface_BCLK,
	audio_0_external_interface_DACDAT,
	audio_0_external_interface_DACLRCK,
	alt_vip_cti_0_clocked_video_vid_clk,
	alt_vip_cti_0_clocked_video_vid_data,
	alt_vip_cti_0_clocked_video_overflow,
	alt_vip_cti_0_clocked_video_vid_datavalid,
	alt_vip_cti_0_clocked_video_vid_locked,
	alt_vip_cti_0_clocked_video_vid_v_sync,
	alt_vip_cti_0_clocked_video_vid_h_sync,
	alt_vip_cti_0_clocked_video_vid_f);	

	input		clk_clk;
	output		vga_external_interface_CLK;
	output		vga_external_interface_HS;
	output		vga_external_interface_VS;
	output		vga_external_interface_BLANK;
	output		vga_external_interface_SYNC;
	output	[7:0]	vga_external_interface_R;
	output	[7:0]	vga_external_interface_G;
	output	[7:0]	vga_external_interface_B;
	input		reset_reset_n;
	input		audio_0_external_interface_ADCDAT;
	input		audio_0_external_interface_ADCLRCK;
	input		audio_0_external_interface_BCLK;
	output		audio_0_external_interface_DACDAT;
	input		audio_0_external_interface_DACLRCK;
	input		alt_vip_cti_0_clocked_video_vid_clk;
	input	[29:0]	alt_vip_cti_0_clocked_video_vid_data;
	output		alt_vip_cti_0_clocked_video_overflow;
	input		alt_vip_cti_0_clocked_video_vid_datavalid;
	input		alt_vip_cti_0_clocked_video_vid_locked;
	input		alt_vip_cti_0_clocked_video_vid_v_sync;
	input		alt_vip_cti_0_clocked_video_vid_h_sync;
	input		alt_vip_cti_0_clocked_video_vid_f;
endmodule
