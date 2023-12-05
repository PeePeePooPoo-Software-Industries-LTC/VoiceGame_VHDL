
module NIOSII_Test (
	audio_interface_ADCDAT,
	audio_interface_ADCLRCK,
	audio_interface_BCLK,
	clk_clk,
	onchip_memory_access_address,
	onchip_memory_access_chipselect,
	onchip_memory_access_clken,
	onchip_memory_access_write,
	onchip_memory_access_readdata,
	onchip_memory_access_writedata,
	onchip_memory_access_byteenable,
	reset_reset,
	sdram_clk_clk,
	sdram_wire_addr,
	sdram_wire_ba,
	sdram_wire_cas_n,
	sdram_wire_cke,
	sdram_wire_cs_n,
	sdram_wire_dq,
	sdram_wire_dqm,
	sdram_wire_ras_n,
	sdram_wire_we_n);	

	input		audio_interface_ADCDAT;
	input		audio_interface_ADCLRCK;
	input		audio_interface_BCLK;
	input		clk_clk;
	input	[16:0]	onchip_memory_access_address;
	input		onchip_memory_access_chipselect;
	input		onchip_memory_access_clken;
	input		onchip_memory_access_write;
	output	[31:0]	onchip_memory_access_readdata;
	input	[31:0]	onchip_memory_access_writedata;
	input	[3:0]	onchip_memory_access_byteenable;
	input		reset_reset;
	output		sdram_clk_clk;
	output	[11:0]	sdram_wire_addr;
	output		sdram_wire_ba;
	output		sdram_wire_cas_n;
	output		sdram_wire_cke;
	output		sdram_wire_cs_n;
	inout	[31:0]	sdram_wire_dq;
	output	[3:0]	sdram_wire_dqm;
	output		sdram_wire_ras_n;
	output		sdram_wire_we_n;
endmodule
