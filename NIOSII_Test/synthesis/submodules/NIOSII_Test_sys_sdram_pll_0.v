// NIOSII_Test_sys_sdram_pll_0.v

// This file was auto-generated from altera_up_avalon_sys_sdram_pll_hw.tcl.  If you edit it your changes
// will probably be lost.
// 
// Generated using ACDS version 18.1 625

`timescale 1 ps / 1 ps
module NIOSII_Test_sys_sdram_pll_0 (
		input  wire  ref_clk_clk,        //      ref_clk.clk
		input  wire  ref_reset_reset,    //    ref_reset.reset
		output wire  sys_clk_clk,        //      sys_clk.clk
		output wire  sdram_clk_clk,      //    sdram_clk.clk
		output wire  reset_source_reset  // reset_source.reset
	);

	wire    sys_pll_locked_export; // sys_pll:locked -> reset_from_locked:locked

	altera_up_altpll #(
		.OUTCLK0_MULT  (1),
		.OUTCLK0_DIV   (1),
		.OUTCLK1_MULT  (1),
		.OUTCLK1_DIV   (1),
		.OUTCLK2_MULT  (1),
		.OUTCLK2_DIV   (1),
		.PHASE_SHIFT   (-3000),
		.DEVICE_FAMILY ("Cyclone IV")
	) sys_pll (
		.refclk  (ref_clk_clk),           //  refclk.clk
		.reset   (ref_reset_reset),       //   reset.reset
		.locked  (sys_pll_locked_export), //  locked.export
		.outclk0 (sys_clk_clk),           // outclk0.clk
		.outclk1 (sdram_clk_clk),         // outclk1.clk
		.outclk2 ()                       // outclk2.clk
	);

	altera_up_avalon_reset_from_locked_signal reset_from_locked (
		.reset  (reset_source_reset),    // reset_source.reset
		.locked (sys_pll_locked_export)  //       locked.export
	);

endmodule
