	NIOSII_Test u0 (
		.audio_clk_clk           (<connected-to-audio_clk_clk>),           //       audio_clk.clk
		.audio_config_SDAT       (<connected-to-audio_config_SDAT>),       //    audio_config.SDAT
		.audio_config_SCLK       (<connected-to-audio_config_SCLK>),       //                .SCLK
		.audio_interface_ADCDAT  (<connected-to-audio_interface_ADCDAT>),  // audio_interface.ADCDAT
		.audio_interface_ADCLRCK (<connected-to-audio_interface_ADCLRCK>), //                .ADCLRCK
		.audio_interface_BCLK    (<connected-to-audio_interface_BCLK>),    //                .BCLK
		.buttons_export          (<connected-to-buttons_export>),          //         buttons.export
		.clk_clk                 (<connected-to-clk_clk>),                 //             clk.clk
		.prepare_pixel_dataa     (<connected-to-prepare_pixel_dataa>),     //   prepare_pixel.dataa
		.prepare_pixel_datab     (<connected-to-prepare_pixel_datab>),     //                .datab
		.prepare_pixel_result    (<connected-to-prepare_pixel_result>),    //                .result
		.reset_reset_n           (<connected-to-reset_reset_n>),           //           reset.reset_n
		.sram_DQ                 (<connected-to-sram_DQ>),                 //            sram.DQ
		.sram_ADDR               (<connected-to-sram_ADDR>),               //                .ADDR
		.sram_LB_N               (<connected-to-sram_LB_N>),               //                .LB_N
		.sram_UB_N               (<connected-to-sram_UB_N>),               //                .UB_N
		.sram_CE_N               (<connected-to-sram_CE_N>),               //                .CE_N
		.sram_OE_N               (<connected-to-sram_OE_N>),               //                .OE_N
		.sram_WE_N               (<connected-to-sram_WE_N>),               //                .WE_N
		.vga_CLK                 (<connected-to-vga_CLK>),                 //             vga.CLK
		.vga_HS                  (<connected-to-vga_HS>),                  //                .HS
		.vga_VS                  (<connected-to-vga_VS>),                  //                .VS
		.vga_BLANK               (<connected-to-vga_BLANK>),               //                .BLANK
		.vga_SYNC                (<connected-to-vga_SYNC>),                //                .SYNC
		.vga_R                   (<connected-to-vga_R>),                   //                .R
		.vga_G                   (<connected-to-vga_G>),                   //                .G
		.vga_B                   (<connected-to-vga_B>),                   //                .B
		.inc_max_shorts_dataa    (<connected-to-inc_max_shorts_dataa>),    //  inc_max_shorts.dataa
		.inc_max_shorts_datab    (<connected-to-inc_max_shorts_datab>),    //                .datab
		.inc_max_shorts_result   (<connected-to-inc_max_shorts_result>)    //                .result
	);

