	NIOSII_Test u0 (
		.audio_interface_ADCDAT  (<connected-to-audio_interface_ADCDAT>),  // audio_interface.ADCDAT
		.audio_interface_ADCLRCK (<connected-to-audio_interface_ADCLRCK>), //                .ADCLRCK
		.audio_interface_BCLK    (<connected-to-audio_interface_BCLK>),    //                .BCLK
		.clk_clk                 (<connected-to-clk_clk>),                 //             clk.clk
		.reset_reset_n           (<connected-to-reset_reset_n>),           //           reset.reset_n
		.vga_CLK                 (<connected-to-vga_CLK>),                 //             vga.CLK
		.vga_HS                  (<connected-to-vga_HS>),                  //                .HS
		.vga_VS                  (<connected-to-vga_VS>),                  //                .VS
		.vga_BLANK               (<connected-to-vga_BLANK>),               //                .BLANK
		.vga_SYNC                (<connected-to-vga_SYNC>),                //                .SYNC
		.vga_R                   (<connected-to-vga_R>),                   //                .R
		.vga_G                   (<connected-to-vga_G>),                   //                .G
		.vga_B                   (<connected-to-vga_B>),                   //                .B
		.sdram_interface_addr    (<connected-to-sdram_interface_addr>),    // sdram_interface.addr
		.sdram_interface_ba      (<connected-to-sdram_interface_ba>),      //                .ba
		.sdram_interface_cas_n   (<connected-to-sdram_interface_cas_n>),   //                .cas_n
		.sdram_interface_cke     (<connected-to-sdram_interface_cke>),     //                .cke
		.sdram_interface_cs_n    (<connected-to-sdram_interface_cs_n>),    //                .cs_n
		.sdram_interface_dq      (<connected-to-sdram_interface_dq>),      //                .dq
		.sdram_interface_dqm     (<connected-to-sdram_interface_dqm>),     //                .dqm
		.sdram_interface_ras_n   (<connected-to-sdram_interface_ras_n>),   //                .ras_n
		.sdram_interface_we_n    (<connected-to-sdram_interface_we_n>)     //                .we_n
	);

