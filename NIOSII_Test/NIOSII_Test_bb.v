
module NIOSII_Test (
	audio_clk_clk,
	audio_config_SDAT,
	audio_config_SCLK,
	audio_interface_ADCDAT,
	audio_interface_ADCLRCK,
	audio_interface_BCLK,
	buttons_export,
	clk_clk,
	inc_max_shorts_dataa,
	inc_max_shorts_datab,
	inc_max_shorts_result,
	prepare_pixel_dataa,
	prepare_pixel_datab,
	prepare_pixel_result,
	reset_reset_n,
	sram_DQ,
	sram_ADDR,
	sram_LB_N,
	sram_UB_N,
	sram_CE_N,
	sram_OE_N,
	sram_WE_N,
	vga_CLK,
	vga_HS,
	vga_VS,
	vga_BLANK,
	vga_SYNC,
	vga_R,
	vga_G,
	vga_B);	

	output		audio_clk_clk;
	inout		audio_config_SDAT;
	output		audio_config_SCLK;
	input		audio_interface_ADCDAT;
	input		audio_interface_ADCLRCK;
	input		audio_interface_BCLK;
	input	[3:0]	buttons_export;
	input		clk_clk;
	output	[31:0]	inc_max_shorts_dataa;
	output	[31:0]	inc_max_shorts_datab;
	input	[31:0]	inc_max_shorts_result;
	output	[31:0]	prepare_pixel_dataa;
	output	[31:0]	prepare_pixel_datab;
	input	[31:0]	prepare_pixel_result;
	input		reset_reset_n;
	inout	[15:0]	sram_DQ;
	output	[19:0]	sram_ADDR;
	output		sram_LB_N;
	output		sram_UB_N;
	output		sram_CE_N;
	output		sram_OE_N;
	output		sram_WE_N;
	output		vga_CLK;
	output		vga_HS;
	output		vga_VS;
	output		vga_BLANK;
	output		vga_SYNC;
	output	[7:0]	vga_R;
	output	[7:0]	vga_G;
	output	[7:0]	vga_B;
endmodule
