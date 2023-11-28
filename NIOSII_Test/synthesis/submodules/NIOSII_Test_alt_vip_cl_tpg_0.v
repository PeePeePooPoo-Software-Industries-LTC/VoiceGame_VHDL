// NIOSII_Test_alt_vip_cl_tpg_0.v

// This file was auto-generated from alt_vip_cl_tpg_hw.tcl.  If you edit it your changes
// will probably be lost.
// 
// Generated using ACDS version 18.1 625

`timescale 1 ps / 1 ps
module NIOSII_Test_alt_vip_cl_tpg_0 #(
		parameter PIXELS_IN_PARALLEL = 1
	) (
		input  wire        main_clock,         // main_clock.clk
		input  wire        main_reset,         // main_reset.reset
		output wire [29:0] dout_data,          //       dout.data
		output wire        dout_valid,         //           .valid
		output wire        dout_startofpacket, //           .startofpacket
		output wire        dout_endofpacket,   //           .endofpacket
		input  wire        dout_ready          //           .ready
	);

	wire         scheduler_av_st_cmd_vob_valid;         // scheduler:av_st_cmd_vob_valid -> video_out:av_st_cmd_valid
	wire  [63:0] scheduler_av_st_cmd_vob_data;          // scheduler:av_st_cmd_vob_data -> video_out:av_st_cmd_data
	wire         scheduler_av_st_cmd_vob_ready;         // video_out:av_st_cmd_ready -> scheduler:av_st_cmd_vob_ready
	wire         scheduler_av_st_cmd_vob_startofpacket; // scheduler:av_st_cmd_vob_startofpacket -> video_out:av_st_cmd_startofpacket
	wire         scheduler_av_st_cmd_vob_endofpacket;   // scheduler:av_st_cmd_vob_endofpacket -> video_out:av_st_cmd_endofpacket
	wire         core_0_av_st_dout_valid;               // core_0:av_st_dout_valid -> video_out:av_st_din_valid
	wire  [61:0] core_0_av_st_dout_data;                // core_0:av_st_dout_data -> video_out:av_st_din_data
	wire         core_0_av_st_dout_ready;               // video_out:av_st_din_ready -> core_0:av_st_dout_ready
	wire         core_0_av_st_dout_startofpacket;       // core_0:av_st_dout_startofpacket -> video_out:av_st_din_startofpacket
	wire         core_0_av_st_dout_endofpacket;         // core_0:av_st_dout_endofpacket -> video_out:av_st_din_endofpacket
	wire         scheduler_av_st_cmd_ac_valid;          // scheduler:av_st_cmd_ac_valid -> core_0:av_st_cmd_valid
	wire  [63:0] scheduler_av_st_cmd_ac_data;           // scheduler:av_st_cmd_ac_data -> core_0:av_st_cmd_data
	wire         scheduler_av_st_cmd_ac_ready;          // core_0:av_st_cmd_ready -> scheduler:av_st_cmd_ac_ready
	wire         scheduler_av_st_cmd_ac_startofpacket;  // scheduler:av_st_cmd_ac_startofpacket -> core_0:av_st_cmd_startofpacket
	wire         scheduler_av_st_cmd_ac_endofpacket;    // scheduler:av_st_cmd_ac_endofpacket -> core_0:av_st_cmd_endofpacket

	generate
		// If any of the display statements (or deliberately broken
		// instantiations) within this generate block triggers then this module
		// has been instantiated this module with a set of parameters different
		// from those it was generated for.  This will usually result in a
		// non-functioning system.
		if (PIXELS_IN_PARALLEL != 1)
		begin
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
			instantiated_with_wrong_parameters_error_see_comment_above
					pixels_in_parallel_check ( .error(1'b1) );
		end
	endgenerate

	alt_vip_video_output_bridge #(
		.BITS_PER_SYMBOL              (10),
		.NUMBER_OF_COLOR_PLANES       (3),
		.COLOR_PLANES_ARE_IN_PARALLEL (1),
		.PIXELS_IN_PARALLEL           (1),
		.VIDEO_PROTOCOL_NO            (1),
		.READY_LATENCY_1              (1),
		.SOP_PRE_ALIGNED              (1),
		.MULTI_CONTEXT_SUPPORT        (0),
		.TYPE_11_SUPPORT              (0),
		.NO_CONCATENATION             (0),
		.PIPELINE_READY               (0),
		.SRC_WIDTH                    (8),
		.DST_WIDTH                    (8),
		.CONTEXT_WIDTH                (8),
		.TASK_WIDTH                   (8),
		.LOW_LATENCY_COMMAND_MODE     (0)
	) video_out (
		.clock                        (main_clock),                            //     main_clock.clk
		.reset                        (main_reset),                            //     main_reset.reset
		.av_st_cmd_valid              (scheduler_av_st_cmd_vob_valid),         //      av_st_cmd.valid
		.av_st_cmd_startofpacket      (scheduler_av_st_cmd_vob_startofpacket), //               .startofpacket
		.av_st_cmd_endofpacket        (scheduler_av_st_cmd_vob_endofpacket),   //               .endofpacket
		.av_st_cmd_data               (scheduler_av_st_cmd_vob_data),          //               .data
		.av_st_cmd_ready              (scheduler_av_st_cmd_vob_ready),         //               .ready
		.av_st_din_valid              (core_0_av_st_dout_valid),               //      av_st_din.valid
		.av_st_din_startofpacket      (core_0_av_st_dout_startofpacket),       //               .startofpacket
		.av_st_din_endofpacket        (core_0_av_st_dout_endofpacket),         //               .endofpacket
		.av_st_din_data               (core_0_av_st_dout_data),                //               .data
		.av_st_din_ready              (core_0_av_st_dout_ready),               //               .ready
		.av_st_vid_dout_data          (dout_data),                             // av_st_vid_dout.data
		.av_st_vid_dout_valid         (dout_valid),                            //               .valid
		.av_st_vid_dout_startofpacket (dout_startofpacket),                    //               .startofpacket
		.av_st_vid_dout_endofpacket   (dout_endofpacket),                      //               .endofpacket
		.av_st_vid_dout_ready         (dout_ready)                             //               .ready
	);

	NIOSII_Test_alt_vip_cl_tpg_0_scheduler scheduler (
		.clock                       (main_clock),                            //    main_clock.clk
		.reset                       (main_reset),                            //    main_reset.reset
		.av_st_cmd_ac_valid          (scheduler_av_st_cmd_ac_valid),          //  av_st_cmd_ac.valid
		.av_st_cmd_ac_startofpacket  (scheduler_av_st_cmd_ac_startofpacket),  //              .startofpacket
		.av_st_cmd_ac_endofpacket    (scheduler_av_st_cmd_ac_endofpacket),    //              .endofpacket
		.av_st_cmd_ac_data           (scheduler_av_st_cmd_ac_data),           //              .data
		.av_st_cmd_ac_ready          (scheduler_av_st_cmd_ac_ready),          //              .ready
		.av_st_cmd_vob_valid         (scheduler_av_st_cmd_vob_valid),         // av_st_cmd_vob.valid
		.av_st_cmd_vob_startofpacket (scheduler_av_st_cmd_vob_startofpacket), //              .startofpacket
		.av_st_cmd_vob_endofpacket   (scheduler_av_st_cmd_vob_endofpacket),   //              .endofpacket
		.av_st_cmd_vob_data          (scheduler_av_st_cmd_vob_data),          //              .data
		.av_st_cmd_vob_ready         (scheduler_av_st_cmd_vob_ready)          //              .ready
	);

	alt_vip_tpg_bars_alg_core #(
		.BITS_PER_SYMBOL              (10),
		.PIXELS_IN_PARALLEL           (1),
		.NUMBER_OF_COLOR_PLANES       (3),
		.COLOR_PLANES_ARE_IN_PARALLEL (1),
		.TPG_CS                       ("RGB_444"),
		.MAX_WIDTH                    (640),
		.MAX_HEIGHT                   (480),
		.PIPELINE_READY               (0),
		.SRC_WIDTH                    (8),
		.DST_WIDTH                    (8),
		.CONTEXT_WIDTH                (8),
		.TASK_WIDTH                   (8),
		.SOURCE_ID                    (0),
		.GREYSCALE                    (0),
		.BW_ONLY                      (0)
	) core_0 (
		.clock                    (main_clock),                           // main_clock.clk
		.reset                    (main_reset),                           // main_reset.reset
		.av_st_cmd_valid          (scheduler_av_st_cmd_ac_valid),         //  av_st_cmd.valid
		.av_st_cmd_startofpacket  (scheduler_av_st_cmd_ac_startofpacket), //           .startofpacket
		.av_st_cmd_endofpacket    (scheduler_av_st_cmd_ac_endofpacket),   //           .endofpacket
		.av_st_cmd_data           (scheduler_av_st_cmd_ac_data),          //           .data
		.av_st_cmd_ready          (scheduler_av_st_cmd_ac_ready),         //           .ready
		.av_st_dout_valid         (core_0_av_st_dout_valid),              // av_st_dout.valid
		.av_st_dout_startofpacket (core_0_av_st_dout_startofpacket),      //           .startofpacket
		.av_st_dout_endofpacket   (core_0_av_st_dout_endofpacket),        //           .endofpacket
		.av_st_dout_data          (core_0_av_st_dout_data),               //           .data
		.av_st_dout_ready         (core_0_av_st_dout_ready)               //           .ready
	);

endmodule
