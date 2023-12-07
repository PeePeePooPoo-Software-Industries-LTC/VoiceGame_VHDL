	NIOSII_Test u0 (
		.audio_interface_ADCDAT      (<connected-to-audio_interface_ADCDAT>),      //        audio_interface.ADCDAT
		.audio_interface_ADCLRCK     (<connected-to-audio_interface_ADCLRCK>),     //                       .ADCLRCK
		.audio_interface_BCLK        (<connected-to-audio_interface_BCLK>),        //                       .BCLK
		.clk_clk                     (<connected-to-clk_clk>),                     //                    clk.clk
		.reset_reset                 (<connected-to-reset_reset>),                 //                  reset.reset
		.sdram_clk_clk               (<connected-to-sdram_clk_clk>),               //              sdram_clk.clk
		.sdram_wire_addr             (<connected-to-sdram_wire_addr>),             //             sdram_wire.addr
		.sdram_wire_ba               (<connected-to-sdram_wire_ba>),               //                       .ba
		.sdram_wire_cas_n            (<connected-to-sdram_wire_cas_n>),            //                       .cas_n
		.sdram_wire_cke              (<connected-to-sdram_wire_cke>),              //                       .cke
		.sdram_wire_cs_n             (<connected-to-sdram_wire_cs_n>),             //                       .cs_n
		.sdram_wire_dq               (<connected-to-sdram_wire_dq>),               //                       .dq
		.sdram_wire_dqm              (<connected-to-sdram_wire_dqm>),              //                       .dqm
		.sdram_wire_ras_n            (<connected-to-sdram_wire_ras_n>),            //                       .ras_n
		.sdram_wire_we_n             (<connected-to-sdram_wire_we_n>),             //                       .we_n
		.pio_switches_export         (<connected-to-pio_switches_export>),         //           pio_switches.export
		.pio_ledr_export             (<connected-to-pio_ledr_export>),             //               pio_ledr.export
		.audio_and_video_export_SDAT (<connected-to-audio_and_video_export_SDAT>), // audio_and_video_export.SDAT
		.audio_and_video_export_SCLK (<connected-to-audio_and_video_export_SCLK>)  //                       .SCLK
	);

