// NIOSII_Test_video_pll_0.v

// This file was auto-generated from altera_up_avalon_video_pll_hw.tcl.  If you edit it your changes
// will probably be lost.
// 
// Generated using ACDS version 18.1 625

`timescale 1 ps / 1 ps
module NIOSII_Test_video_pll_0 (
		input  wire  ref_clk_clk,        //      ref_clk.clk
		input  wire  ref_reset_reset,    //    ref_reset.reset
		output wire  vga_clk_clk,        //      vga_clk.clk
		output wire  reset_source_reset  // reset_source.reset
	);

	wire    video_pll_locked_export; // video_pll:locked -> reset_from_locked:locked

	altera_up_altpll #(
		.OUTCLK0_MULT  (1),
		.OUTCLK0_DIV   (2),
		.OUTCLK1_MULT  (1),
		.OUTCLK1_DIV   (2),
		.OUTCLK2_MULT  (2),
		.OUTCLK2_DIV   (3),
		.PHASE_SHIFT   (0),
		.DEVICE_FAMILY ("Cyclone IV")
	) video_pll (
		.refclk  (ref_clk_clk),             //  refclk.clk
		.reset   (ref_reset_reset),         //   reset.reset
		.locked  (video_pll_locked_export), //  locked.export
		.outclk0 (),                        // outclk0.clk
		.outclk1 (vga_clk_clk),             // outclk1.clk
		.outclk2 ()                         // outclk2.clk
	);

	altera_up_avalon_reset_from_locked_signal reset_from_locked (
		.reset  (reset_source_reset),      // reset_source.reset
		.locked (video_pll_locked_export)  //       locked.export
	);

endmodule
