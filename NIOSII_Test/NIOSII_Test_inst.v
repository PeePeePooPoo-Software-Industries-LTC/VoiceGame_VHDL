	NIOSII_Test u0 (
		.audio_interface_ADCDAT  (<connected-to-audio_interface_ADCDAT>),  // audio_interface.ADCDAT
		.audio_interface_ADCLRCK (<connected-to-audio_interface_ADCLRCK>), //                .ADCLRCK
		.audio_interface_BCLK    (<connected-to-audio_interface_BCLK>),    //                .BCLK
		.sdram_wire_addr         (<connected-to-sdram_wire_addr>),         //      sdram_wire.addr
		.sdram_wire_ba           (<connected-to-sdram_wire_ba>),           //                .ba
		.sdram_wire_cas_n        (<connected-to-sdram_wire_cas_n>),        //                .cas_n
		.sdram_wire_cke          (<connected-to-sdram_wire_cke>),          //                .cke
		.sdram_wire_cs_n         (<connected-to-sdram_wire_cs_n>),         //                .cs_n
		.sdram_wire_dq           (<connected-to-sdram_wire_dq>),           //                .dq
		.sdram_wire_dqm          (<connected-to-sdram_wire_dqm>),          //                .dqm
		.sdram_wire_ras_n        (<connected-to-sdram_wire_ras_n>),        //                .ras_n
		.sdram_wire_we_n         (<connected-to-sdram_wire_we_n>),         //                .we_n
		.vga_CLK                 (<connected-to-vga_CLK>),                 //             vga.CLK
		.vga_HS                  (<connected-to-vga_HS>),                  //                .HS
		.vga_VS                  (<connected-to-vga_VS>),                  //                .VS
		.vga_BLANK               (<connected-to-vga_BLANK>),               //                .BLANK
		.vga_SYNC                (<connected-to-vga_SYNC>),                //                .SYNC
		.vga_R                   (<connected-to-vga_R>),                   //                .R
		.vga_G                   (<connected-to-vga_G>),                   //                .G
		.vga_B                   (<connected-to-vga_B>),                   //                .B
		.clk_clk                 (<connected-to-clk_clk>),                 //             clk.clk
		.reset_reset             (<connected-to-reset_reset>),             //           reset.reset
		.sdram_clk_clk           (<connected-to-sdram_clk_clk>)            //       sdram_clk.clk
	);

