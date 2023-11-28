	Core u0 (
		.audio_external_interface_ADCDAT     (<connected-to-audio_external_interface_ADCDAT>),     // audio_external_interface.ADCDAT
		.audio_external_interface_ADCLRCK    (<connected-to-audio_external_interface_ADCLRCK>),    //                         .ADCLRCK
		.audio_external_interface_BCLK       (<connected-to-audio_external_interface_BCLK>),       //                         .BCLK
		.audio_external_interface_DACDAT     (<connected-to-audio_external_interface_DACDAT>),     //                         .DACDAT
		.audio_external_interface_DACLRCK    (<connected-to-audio_external_interface_DACLRCK>),    //                         .DACLRCK
		.clk_clk                             (<connected-to-clk_clk>),                             //                      clk.clk
		.reset_reset_n                       (<connected-to-reset_reset_n>),                       //                    reset.reset_n
		.vga_external_interface_CLK          (<connected-to-vga_external_interface_CLK>),          //   vga_external_interface.CLK
		.vga_external_interface_HS           (<connected-to-vga_external_interface_HS>),           //                         .HS
		.vga_external_interface_VS           (<connected-to-vga_external_interface_VS>),           //                         .VS
		.vga_external_interface_BLANK        (<connected-to-vga_external_interface_BLANK>),        //                         .BLANK
		.vga_external_interface_SYNC         (<connected-to-vga_external_interface_SYNC>),         //                         .SYNC
		.vga_external_interface_R            (<connected-to-vga_external_interface_R>),            //                         .R
		.vga_external_interface_G            (<connected-to-vga_external_interface_G>),            //                         .G
		.vga_external_interface_B            (<connected-to-vga_external_interface_B>),            //                         .B
		.clocked_video_conduit_vid_clk       (<connected-to-clocked_video_conduit_vid_clk>),       //    clocked_video_conduit.vid_clk
		.clocked_video_conduit_vid_data      (<connected-to-clocked_video_conduit_vid_data>),      //                         .vid_data
		.clocked_video_conduit_overflow      (<connected-to-clocked_video_conduit_overflow>),      //                         .overflow
		.clocked_video_conduit_vid_datavalid (<connected-to-clocked_video_conduit_vid_datavalid>), //                         .vid_datavalid
		.clocked_video_conduit_vid_locked    (<connected-to-clocked_video_conduit_vid_locked>)     //                         .vid_locked
	);

