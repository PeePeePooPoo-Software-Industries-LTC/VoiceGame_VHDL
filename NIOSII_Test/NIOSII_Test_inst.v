	NIOSII_Test u0 (
		.clk_clk                 (<connected-to-clk_clk>),                 //             clk.clk
		.reset_reset_n           (<connected-to-reset_reset_n>),           //           reset.reset_n
		.audio_interface_ADCDAT  (<connected-to-audio_interface_ADCDAT>),  // audio_interface.ADCDAT
		.audio_interface_ADCLRCK (<connected-to-audio_interface_ADCLRCK>), //                .ADCLRCK
		.audio_interface_BCLK    (<connected-to-audio_interface_BCLK>),    //                .BCLK
		.video_interface_CLK     (<connected-to-video_interface_CLK>),     // video_interface.CLK
		.video_interface_HS      (<connected-to-video_interface_HS>),      //                .HS
		.video_interface_VS      (<connected-to-video_interface_VS>),      //                .VS
		.video_interface_BLANK   (<connected-to-video_interface_BLANK>),   //                .BLANK
		.video_interface_SYNC    (<connected-to-video_interface_SYNC>),    //                .SYNC
		.video_interface_R       (<connected-to-video_interface_R>),       //                .R
		.video_interface_G       (<connected-to-video_interface_G>),       //                .G
		.video_interface_B       (<connected-to-video_interface_B>)        //                .B
	);

