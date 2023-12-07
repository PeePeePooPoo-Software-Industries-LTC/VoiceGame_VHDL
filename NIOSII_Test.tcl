# qsys scripting (.tcl) file for NIOSII_Test
package require -exact qsys 16.0

create_system {NIOSII_Test}

set_project_property DEVICE_FAMILY {Cyclone IV E}
set_project_property DEVICE {EP4CE115F29C7}
set_project_property HIDE_FROM_IP_CATALOG {false}

# Instances and instance parameters
# (disabled instances are intentionally culled)
add_instance audio_0 altera_up_avalon_audio 18.0
set_instance_parameter_value audio_0 {audio_in} {1}
set_instance_parameter_value audio_0 {audio_out} {0}
set_instance_parameter_value audio_0 {avalon_bus_type} {Memory Mapped}
set_instance_parameter_value audio_0 {dw} {16}

add_instance audio_pll_0 altera_up_avalon_audio_pll 18.0
set_instance_parameter_value audio_pll_0 {audio_clk_freq} {12.288}
set_instance_parameter_value audio_pll_0 {gui_refclk} {50.0}

add_instance jtag_uart_0 altera_avalon_jtag_uart 18.1
set_instance_parameter_value jtag_uart_0 {allowMultipleConnections} {0}
set_instance_parameter_value jtag_uart_0 {hubInstanceID} {0}
set_instance_parameter_value jtag_uart_0 {readBufferDepth} {64}
set_instance_parameter_value jtag_uart_0 {readIRQThreshold} {8}
set_instance_parameter_value jtag_uart_0 {simInputCharacterStream} {}
set_instance_parameter_value jtag_uart_0 {simInteractiveOptions} {NO_INTERACTIVE_WINDOWS}
set_instance_parameter_value jtag_uart_0 {useRegistersForReadBuffer} {0}
set_instance_parameter_value jtag_uart_0 {useRegistersForWriteBuffer} {0}
set_instance_parameter_value jtag_uart_0 {useRelativePathForSimFile} {0}
set_instance_parameter_value jtag_uart_0 {writeBufferDepth} {64}
set_instance_parameter_value jtag_uart_0 {writeIRQThreshold} {8}

add_instance new_sdram_controller_0 altera_avalon_new_sdram_controller 18.1
set_instance_parameter_value new_sdram_controller_0 {TAC} {5.5}
set_instance_parameter_value new_sdram_controller_0 {TMRD} {3.0}
set_instance_parameter_value new_sdram_controller_0 {TRCD} {20.0}
set_instance_parameter_value new_sdram_controller_0 {TRFC} {70.0}
set_instance_parameter_value new_sdram_controller_0 {TRP} {20.0}
set_instance_parameter_value new_sdram_controller_0 {TWR} {14.0}
set_instance_parameter_value new_sdram_controller_0 {casLatency} {3}
set_instance_parameter_value new_sdram_controller_0 {columnWidth} {8}
set_instance_parameter_value new_sdram_controller_0 {dataWidth} {32}
set_instance_parameter_value new_sdram_controller_0 {generateSimulationModel} {0}
set_instance_parameter_value new_sdram_controller_0 {initNOPDelay} {0.0}
set_instance_parameter_value new_sdram_controller_0 {initRefreshCommands} {2}
set_instance_parameter_value new_sdram_controller_0 {masteredTristateBridgeSlave} {0}
set_instance_parameter_value new_sdram_controller_0 {model} {single_Micron_MT48LC4M32B2_7_chip}
set_instance_parameter_value new_sdram_controller_0 {numberOfBanks} {2}
set_instance_parameter_value new_sdram_controller_0 {numberOfChipSelects} {1}
set_instance_parameter_value new_sdram_controller_0 {pinsSharedViaTriState} {0}
set_instance_parameter_value new_sdram_controller_0 {powerUpDelay} {100.0}
set_instance_parameter_value new_sdram_controller_0 {refreshPeriod} {15.625}
set_instance_parameter_value new_sdram_controller_0 {registerDataIn} {1}
set_instance_parameter_value new_sdram_controller_0 {rowWidth} {12}

add_instance nios2_gen2_0 altera_nios2_gen2 18.1
set_instance_parameter_value nios2_gen2_0 {bht_ramBlockType} {Automatic}
set_instance_parameter_value nios2_gen2_0 {breakOffset} {32}
set_instance_parameter_value nios2_gen2_0 {breakSlave} {None}
set_instance_parameter_value nios2_gen2_0 {cdx_enabled} {0}
set_instance_parameter_value nios2_gen2_0 {cpuArchRev} {1}
set_instance_parameter_value nios2_gen2_0 {cpuID} {0}
set_instance_parameter_value nios2_gen2_0 {cpuReset} {0}
set_instance_parameter_value nios2_gen2_0 {data_master_high_performance_paddr_base} {0}
set_instance_parameter_value nios2_gen2_0 {data_master_high_performance_paddr_size} {0.0}
set_instance_parameter_value nios2_gen2_0 {data_master_paddr_base} {0}
set_instance_parameter_value nios2_gen2_0 {data_master_paddr_size} {0.0}
set_instance_parameter_value nios2_gen2_0 {dcache_bursts} {false}
set_instance_parameter_value nios2_gen2_0 {dcache_numTCDM} {0}
set_instance_parameter_value nios2_gen2_0 {dcache_ramBlockType} {Automatic}
set_instance_parameter_value nios2_gen2_0 {dcache_size} {2048}
set_instance_parameter_value nios2_gen2_0 {dcache_tagramBlockType} {Automatic}
set_instance_parameter_value nios2_gen2_0 {dcache_victim_buf_impl} {ram}
set_instance_parameter_value nios2_gen2_0 {debug_OCIOnchipTrace} {_128}
set_instance_parameter_value nios2_gen2_0 {debug_assignJtagInstanceID} {0}
set_instance_parameter_value nios2_gen2_0 {debug_datatrigger} {0}
set_instance_parameter_value nios2_gen2_0 {debug_debugReqSignals} {0}
set_instance_parameter_value nios2_gen2_0 {debug_enabled} {1}
set_instance_parameter_value nios2_gen2_0 {debug_hwbreakpoint} {0}
set_instance_parameter_value nios2_gen2_0 {debug_jtagInstanceID} {0}
set_instance_parameter_value nios2_gen2_0 {debug_traceStorage} {onchip_trace}
set_instance_parameter_value nios2_gen2_0 {debug_traceType} {none}
set_instance_parameter_value nios2_gen2_0 {debug_triggerArming} {1}
set_instance_parameter_value nios2_gen2_0 {dividerType} {no_div}
set_instance_parameter_value nios2_gen2_0 {exceptionOffset} {32}
set_instance_parameter_value nios2_gen2_0 {exceptionSlave} {onchip_memory2_0.s1}
set_instance_parameter_value nios2_gen2_0 {fa_cache_line} {2}
set_instance_parameter_value nios2_gen2_0 {fa_cache_linesize} {0}
set_instance_parameter_value nios2_gen2_0 {flash_instruction_master_paddr_base} {0}
set_instance_parameter_value nios2_gen2_0 {flash_instruction_master_paddr_size} {0.0}
set_instance_parameter_value nios2_gen2_0 {icache_burstType} {None}
set_instance_parameter_value nios2_gen2_0 {icache_numTCIM} {0}
set_instance_parameter_value nios2_gen2_0 {icache_ramBlockType} {Automatic}
set_instance_parameter_value nios2_gen2_0 {icache_size} {4096}
set_instance_parameter_value nios2_gen2_0 {icache_tagramBlockType} {Automatic}
set_instance_parameter_value nios2_gen2_0 {impl} {Fast}
set_instance_parameter_value nios2_gen2_0 {instruction_master_high_performance_paddr_base} {0}
set_instance_parameter_value nios2_gen2_0 {instruction_master_high_performance_paddr_size} {0.0}
set_instance_parameter_value nios2_gen2_0 {instruction_master_paddr_base} {0}
set_instance_parameter_value nios2_gen2_0 {instruction_master_paddr_size} {0.0}
set_instance_parameter_value nios2_gen2_0 {io_regionbase} {0}
set_instance_parameter_value nios2_gen2_0 {io_regionsize} {0}
set_instance_parameter_value nios2_gen2_0 {master_addr_map} {0}
set_instance_parameter_value nios2_gen2_0 {mmu_TLBMissExcOffset} {0}
set_instance_parameter_value nios2_gen2_0 {mmu_TLBMissExcSlave} {None}
set_instance_parameter_value nios2_gen2_0 {mmu_autoAssignTlbPtrSz} {1}
set_instance_parameter_value nios2_gen2_0 {mmu_enabled} {0}
set_instance_parameter_value nios2_gen2_0 {mmu_processIDNumBits} {8}
set_instance_parameter_value nios2_gen2_0 {mmu_ramBlockType} {Automatic}
set_instance_parameter_value nios2_gen2_0 {mmu_tlbNumWays} {16}
set_instance_parameter_value nios2_gen2_0 {mmu_tlbPtrSz} {7}
set_instance_parameter_value nios2_gen2_0 {mmu_udtlbNumEntries} {6}
set_instance_parameter_value nios2_gen2_0 {mmu_uitlbNumEntries} {4}
set_instance_parameter_value nios2_gen2_0 {mpu_enabled} {0}
set_instance_parameter_value nios2_gen2_0 {mpu_minDataRegionSize} {12}
set_instance_parameter_value nios2_gen2_0 {mpu_minInstRegionSize} {12}
set_instance_parameter_value nios2_gen2_0 {mpu_numOfDataRegion} {8}
set_instance_parameter_value nios2_gen2_0 {mpu_numOfInstRegion} {8}
set_instance_parameter_value nios2_gen2_0 {mpu_useLimit} {0}
set_instance_parameter_value nios2_gen2_0 {mpx_enabled} {0}
set_instance_parameter_value nios2_gen2_0 {mul_32_impl} {2}
set_instance_parameter_value nios2_gen2_0 {mul_64_impl} {0}
set_instance_parameter_value nios2_gen2_0 {mul_shift_choice} {0}
set_instance_parameter_value nios2_gen2_0 {ocimem_ramBlockType} {Automatic}
set_instance_parameter_value nios2_gen2_0 {ocimem_ramInit} {0}
set_instance_parameter_value nios2_gen2_0 {regfile_ramBlockType} {Automatic}
set_instance_parameter_value nios2_gen2_0 {register_file_por} {0}
set_instance_parameter_value nios2_gen2_0 {resetOffset} {0}
set_instance_parameter_value nios2_gen2_0 {resetSlave} {onchip_memory2_0.s1}
set_instance_parameter_value nios2_gen2_0 {resetrequest_enabled} {1}
set_instance_parameter_value nios2_gen2_0 {setting_HBreakTest} {0}
set_instance_parameter_value nios2_gen2_0 {setting_HDLSimCachesCleared} {1}
set_instance_parameter_value nios2_gen2_0 {setting_activateMonitors} {1}
set_instance_parameter_value nios2_gen2_0 {setting_activateTestEndChecker} {0}
set_instance_parameter_value nios2_gen2_0 {setting_activateTrace} {0}
set_instance_parameter_value nios2_gen2_0 {setting_allow_break_inst} {0}
set_instance_parameter_value nios2_gen2_0 {setting_alwaysEncrypt} {1}
set_instance_parameter_value nios2_gen2_0 {setting_asic_add_scan_mode_input} {0}
set_instance_parameter_value nios2_gen2_0 {setting_asic_enabled} {0}
set_instance_parameter_value nios2_gen2_0 {setting_asic_synopsys_translate_on_off} {0}
set_instance_parameter_value nios2_gen2_0 {setting_asic_third_party_synthesis} {0}
set_instance_parameter_value nios2_gen2_0 {setting_avalonDebugPortPresent} {0}
set_instance_parameter_value nios2_gen2_0 {setting_bhtPtrSz} {8}
set_instance_parameter_value nios2_gen2_0 {setting_bigEndian} {0}
set_instance_parameter_value nios2_gen2_0 {setting_branchpredictiontype} {Dynamic}
set_instance_parameter_value nios2_gen2_0 {setting_breakslaveoveride} {0}
set_instance_parameter_value nios2_gen2_0 {setting_clearXBitsLDNonBypass} {1}
set_instance_parameter_value nios2_gen2_0 {setting_dc_ecc_present} {1}
set_instance_parameter_value nios2_gen2_0 {setting_disable_tmr_inj} {0}
set_instance_parameter_value nios2_gen2_0 {setting_disableocitrace} {0}
set_instance_parameter_value nios2_gen2_0 {setting_dtcm_ecc_present} {1}
set_instance_parameter_value nios2_gen2_0 {setting_ecc_present} {0}
set_instance_parameter_value nios2_gen2_0 {setting_ecc_sim_test_ports} {0}
set_instance_parameter_value nios2_gen2_0 {setting_exportHostDebugPort} {0}
set_instance_parameter_value nios2_gen2_0 {setting_exportPCB} {0}
set_instance_parameter_value nios2_gen2_0 {setting_export_large_RAMs} {0}
set_instance_parameter_value nios2_gen2_0 {setting_exportdebuginfo} {0}
set_instance_parameter_value nios2_gen2_0 {setting_exportvectors} {0}
set_instance_parameter_value nios2_gen2_0 {setting_fast_register_read} {0}
set_instance_parameter_value nios2_gen2_0 {setting_ic_ecc_present} {1}
set_instance_parameter_value nios2_gen2_0 {setting_interruptControllerType} {Internal}
set_instance_parameter_value nios2_gen2_0 {setting_itcm_ecc_present} {1}
set_instance_parameter_value nios2_gen2_0 {setting_mmu_ecc_present} {1}
set_instance_parameter_value nios2_gen2_0 {setting_oci_export_jtag_signals} {0}
set_instance_parameter_value nios2_gen2_0 {setting_oci_version} {1}
set_instance_parameter_value nios2_gen2_0 {setting_preciseIllegalMemAccessException} {0}
set_instance_parameter_value nios2_gen2_0 {setting_removeRAMinit} {0}
set_instance_parameter_value nios2_gen2_0 {setting_rf_ecc_present} {1}
set_instance_parameter_value nios2_gen2_0 {setting_shadowRegisterSets} {0}
set_instance_parameter_value nios2_gen2_0 {setting_showInternalSettings} {0}
set_instance_parameter_value nios2_gen2_0 {setting_showUnpublishedSettings} {0}
set_instance_parameter_value nios2_gen2_0 {setting_support31bitdcachebypass} {1}
set_instance_parameter_value nios2_gen2_0 {setting_tmr_output_disable} {0}
set_instance_parameter_value nios2_gen2_0 {setting_usedesignware} {0}
set_instance_parameter_value nios2_gen2_0 {shift_rot_impl} {1}
set_instance_parameter_value nios2_gen2_0 {tightly_coupled_data_master_0_paddr_base} {0}
set_instance_parameter_value nios2_gen2_0 {tightly_coupled_data_master_0_paddr_size} {0.0}
set_instance_parameter_value nios2_gen2_0 {tightly_coupled_data_master_1_paddr_base} {0}
set_instance_parameter_value nios2_gen2_0 {tightly_coupled_data_master_1_paddr_size} {0.0}
set_instance_parameter_value nios2_gen2_0 {tightly_coupled_data_master_2_paddr_base} {0}
set_instance_parameter_value nios2_gen2_0 {tightly_coupled_data_master_2_paddr_size} {0.0}
set_instance_parameter_value nios2_gen2_0 {tightly_coupled_data_master_3_paddr_base} {0}
set_instance_parameter_value nios2_gen2_0 {tightly_coupled_data_master_3_paddr_size} {0.0}
set_instance_parameter_value nios2_gen2_0 {tightly_coupled_instruction_master_0_paddr_base} {0}
set_instance_parameter_value nios2_gen2_0 {tightly_coupled_instruction_master_0_paddr_size} {0.0}
set_instance_parameter_value nios2_gen2_0 {tightly_coupled_instruction_master_1_paddr_base} {0}
set_instance_parameter_value nios2_gen2_0 {tightly_coupled_instruction_master_1_paddr_size} {0.0}
set_instance_parameter_value nios2_gen2_0 {tightly_coupled_instruction_master_2_paddr_base} {0}
set_instance_parameter_value nios2_gen2_0 {tightly_coupled_instruction_master_2_paddr_size} {0.0}
set_instance_parameter_value nios2_gen2_0 {tightly_coupled_instruction_master_3_paddr_base} {0}
set_instance_parameter_value nios2_gen2_0 {tightly_coupled_instruction_master_3_paddr_size} {0.0}
set_instance_parameter_value nios2_gen2_0 {tmr_enabled} {0}
set_instance_parameter_value nios2_gen2_0 {tracefilename} {}
set_instance_parameter_value nios2_gen2_0 {userDefinedSettings} {}

add_instance onchip_memory2_0 altera_avalon_onchip_memory2 18.1
set_instance_parameter_value onchip_memory2_0 {allowInSystemMemoryContentEditor} {0}
set_instance_parameter_value onchip_memory2_0 {blockType} {AUTO}
set_instance_parameter_value onchip_memory2_0 {copyInitFile} {0}
set_instance_parameter_value onchip_memory2_0 {dataWidth} {32}
set_instance_parameter_value onchip_memory2_0 {dataWidth2} {32}
set_instance_parameter_value onchip_memory2_0 {dualPort} {0}
set_instance_parameter_value onchip_memory2_0 {ecc_enabled} {0}
set_instance_parameter_value onchip_memory2_0 {enPRInitMode} {0}
set_instance_parameter_value onchip_memory2_0 {enableDiffWidth} {0}
set_instance_parameter_value onchip_memory2_0 {initMemContent} {1}
set_instance_parameter_value onchip_memory2_0 {initializationFileName} {onchip_mem.hex}
set_instance_parameter_value onchip_memory2_0 {instanceID} {NONE}
set_instance_parameter_value onchip_memory2_0 {memorySize} {400000.0}
set_instance_parameter_value onchip_memory2_0 {readDuringWriteMode} {OLD_DATA}
set_instance_parameter_value onchip_memory2_0 {resetrequest_enabled} {1}
set_instance_parameter_value onchip_memory2_0 {simAllowMRAMContentsFile} {0}
set_instance_parameter_value onchip_memory2_0 {simMemInitOnlyFilename} {0}
set_instance_parameter_value onchip_memory2_0 {singleClockOperation} {1}
set_instance_parameter_value onchip_memory2_0 {slave1Latency} {1}
set_instance_parameter_value onchip_memory2_0 {slave2Latency} {1}
set_instance_parameter_value onchip_memory2_0 {useNonDefaultInitFile} {0}
set_instance_parameter_value onchip_memory2_0 {useShallowMemBlocks} {0}
set_instance_parameter_value onchip_memory2_0 {writable} {1}

add_instance pio_pixel_color altera_avalon_pio 18.1
set_instance_parameter_value pio_pixel_color {bitClearingEdgeCapReg} {0}
set_instance_parameter_value pio_pixel_color {bitModifyingOutReg} {0}
set_instance_parameter_value pio_pixel_color {captureEdge} {0}
set_instance_parameter_value pio_pixel_color {direction} {Output}
set_instance_parameter_value pio_pixel_color {edgeType} {RISING}
set_instance_parameter_value pio_pixel_color {generateIRQ} {0}
set_instance_parameter_value pio_pixel_color {irqType} {LEVEL}
set_instance_parameter_value pio_pixel_color {resetValue} {0.0}
set_instance_parameter_value pio_pixel_color {simDoTestBenchWiring} {0}
set_instance_parameter_value pio_pixel_color {simDrivenValue} {0.0}
set_instance_parameter_value pio_pixel_color {width} {24}

add_instance pio_pixel_position altera_avalon_pio 18.1
set_instance_parameter_value pio_pixel_position {bitClearingEdgeCapReg} {0}
set_instance_parameter_value pio_pixel_position {bitModifyingOutReg} {0}
set_instance_parameter_value pio_pixel_position {captureEdge} {0}
set_instance_parameter_value pio_pixel_position {direction} {Input}
set_instance_parameter_value pio_pixel_position {edgeType} {RISING}
set_instance_parameter_value pio_pixel_position {generateIRQ} {0}
set_instance_parameter_value pio_pixel_position {irqType} {LEVEL}
set_instance_parameter_value pio_pixel_position {resetValue} {0.0}
set_instance_parameter_value pio_pixel_position {simDoTestBenchWiring} {0}
set_instance_parameter_value pio_pixel_position {simDrivenValue} {0.0}
set_instance_parameter_value pio_pixel_position {width} {32}

add_instance pio_request altera_avalon_pio 18.1
set_instance_parameter_value pio_request {bitClearingEdgeCapReg} {0}
set_instance_parameter_value pio_request {bitModifyingOutReg} {0}
set_instance_parameter_value pio_request {captureEdge} {1}
set_instance_parameter_value pio_request {direction} {Input}
set_instance_parameter_value pio_request {edgeType} {RISING}
set_instance_parameter_value pio_request {generateIRQ} {1}
set_instance_parameter_value pio_request {irqType} {EDGE}
set_instance_parameter_value pio_request {resetValue} {0.0}
set_instance_parameter_value pio_request {simDoTestBenchWiring} {0}
set_instance_parameter_value pio_request {simDrivenValue} {0.0}
set_instance_parameter_value pio_request {width} {1}

add_instance sys_sdram_pll_0 altera_up_avalon_sys_sdram_pll 18.0
set_instance_parameter_value sys_sdram_pll_0 {CIII_boards} {DE0}
set_instance_parameter_value sys_sdram_pll_0 {CIV_boards} {DE2-115}
set_instance_parameter_value sys_sdram_pll_0 {CV_boards} {DE10-Standard}
set_instance_parameter_value sys_sdram_pll_0 {MAX10_boards} {DE10-Lite}
set_instance_parameter_value sys_sdram_pll_0 {gui_outclk} {50.0}
set_instance_parameter_value sys_sdram_pll_0 {gui_refclk} {50.0}
set_instance_parameter_value sys_sdram_pll_0 {other_boards} {None}

# exported interfaces
add_interface audio_interface conduit end
set_interface_property audio_interface EXPORT_OF audio_0.external_interface
add_interface clk clock sink
set_interface_property clk EXPORT_OF sys_sdram_pll_0.ref_clk
add_interface pio_pixel_color_external_connection conduit end
set_interface_property pio_pixel_color_external_connection EXPORT_OF pio_pixel_color.external_connection
add_interface pio_pixel_position_external_connection conduit end
set_interface_property pio_pixel_position_external_connection EXPORT_OF pio_pixel_position.external_connection
add_interface pio_request_external_connection conduit end
set_interface_property pio_request_external_connection EXPORT_OF pio_request.external_connection
add_interface reset reset sink
set_interface_property reset EXPORT_OF sys_sdram_pll_0.ref_reset
add_interface sdram_clk clock source
set_interface_property sdram_clk EXPORT_OF sys_sdram_pll_0.sdram_clk
add_interface sdram_wire conduit end
set_interface_property sdram_wire EXPORT_OF new_sdram_controller_0.wire

# connections and connection parameters
add_connection audio_pll_0.audio_clk audio_0.clk

add_connection audio_pll_0.reset_source audio_0.reset

add_connection nios2_gen2_0.data_master audio_0.avalon_audio_slave
set_connection_parameter_value nios2_gen2_0.data_master/audio_0.avalon_audio_slave arbitrationPriority {1}
set_connection_parameter_value nios2_gen2_0.data_master/audio_0.avalon_audio_slave baseAddress {0x01101030}
set_connection_parameter_value nios2_gen2_0.data_master/audio_0.avalon_audio_slave defaultConnection {0}

add_connection nios2_gen2_0.data_master jtag_uart_0.avalon_jtag_slave
set_connection_parameter_value nios2_gen2_0.data_master/jtag_uart_0.avalon_jtag_slave arbitrationPriority {1}
set_connection_parameter_value nios2_gen2_0.data_master/jtag_uart_0.avalon_jtag_slave baseAddress {0x01101040}
set_connection_parameter_value nios2_gen2_0.data_master/jtag_uart_0.avalon_jtag_slave defaultConnection {0}

add_connection nios2_gen2_0.data_master new_sdram_controller_0.s1
set_connection_parameter_value nios2_gen2_0.data_master/new_sdram_controller_0.s1 arbitrationPriority {1}
set_connection_parameter_value nios2_gen2_0.data_master/new_sdram_controller_0.s1 baseAddress {0x00800000}
set_connection_parameter_value nios2_gen2_0.data_master/new_sdram_controller_0.s1 defaultConnection {0}

add_connection nios2_gen2_0.data_master nios2_gen2_0.debug_mem_slave
set_connection_parameter_value nios2_gen2_0.data_master/nios2_gen2_0.debug_mem_slave arbitrationPriority {1}
set_connection_parameter_value nios2_gen2_0.data_master/nios2_gen2_0.debug_mem_slave baseAddress {0x01100800}
set_connection_parameter_value nios2_gen2_0.data_master/nios2_gen2_0.debug_mem_slave defaultConnection {0}

add_connection nios2_gen2_0.data_master onchip_memory2_0.s1
set_connection_parameter_value nios2_gen2_0.data_master/onchip_memory2_0.s1 arbitrationPriority {1}
set_connection_parameter_value nios2_gen2_0.data_master/onchip_memory2_0.s1 baseAddress {0x01080000}
set_connection_parameter_value nios2_gen2_0.data_master/onchip_memory2_0.s1 defaultConnection {0}

add_connection nios2_gen2_0.data_master pio_pixel_color.s1
set_connection_parameter_value nios2_gen2_0.data_master/pio_pixel_color.s1 arbitrationPriority {1}
set_connection_parameter_value nios2_gen2_0.data_master/pio_pixel_color.s1 baseAddress {0x01101000}
set_connection_parameter_value nios2_gen2_0.data_master/pio_pixel_color.s1 defaultConnection {0}

add_connection nios2_gen2_0.data_master pio_pixel_position.s1
set_connection_parameter_value nios2_gen2_0.data_master/pio_pixel_position.s1 arbitrationPriority {1}
set_connection_parameter_value nios2_gen2_0.data_master/pio_pixel_position.s1 baseAddress {0x01101020}
set_connection_parameter_value nios2_gen2_0.data_master/pio_pixel_position.s1 defaultConnection {0}

add_connection nios2_gen2_0.data_master pio_request.s1
set_connection_parameter_value nios2_gen2_0.data_master/pio_request.s1 arbitrationPriority {1}
set_connection_parameter_value nios2_gen2_0.data_master/pio_request.s1 baseAddress {0x01101010}
set_connection_parameter_value nios2_gen2_0.data_master/pio_request.s1 defaultConnection {0}

add_connection nios2_gen2_0.debug_reset_request jtag_uart_0.reset

add_connection nios2_gen2_0.debug_reset_request nios2_gen2_0.reset

add_connection nios2_gen2_0.debug_reset_request onchip_memory2_0.reset1

add_connection nios2_gen2_0.instruction_master new_sdram_controller_0.s1
set_connection_parameter_value nios2_gen2_0.instruction_master/new_sdram_controller_0.s1 arbitrationPriority {1}
set_connection_parameter_value nios2_gen2_0.instruction_master/new_sdram_controller_0.s1 baseAddress {0x00800000}
set_connection_parameter_value nios2_gen2_0.instruction_master/new_sdram_controller_0.s1 defaultConnection {0}

add_connection nios2_gen2_0.instruction_master nios2_gen2_0.debug_mem_slave
set_connection_parameter_value nios2_gen2_0.instruction_master/nios2_gen2_0.debug_mem_slave arbitrationPriority {1}
set_connection_parameter_value nios2_gen2_0.instruction_master/nios2_gen2_0.debug_mem_slave baseAddress {0x01100800}
set_connection_parameter_value nios2_gen2_0.instruction_master/nios2_gen2_0.debug_mem_slave defaultConnection {0}

add_connection nios2_gen2_0.instruction_master onchip_memory2_0.s1
set_connection_parameter_value nios2_gen2_0.instruction_master/onchip_memory2_0.s1 arbitrationPriority {1}
set_connection_parameter_value nios2_gen2_0.instruction_master/onchip_memory2_0.s1 baseAddress {0x01080000}
set_connection_parameter_value nios2_gen2_0.instruction_master/onchip_memory2_0.s1 defaultConnection {0}

add_connection nios2_gen2_0.irq audio_0.interrupt
set_connection_parameter_value nios2_gen2_0.irq/audio_0.interrupt irqNumber {0}

add_connection nios2_gen2_0.irq jtag_uart_0.irq
set_connection_parameter_value nios2_gen2_0.irq/jtag_uart_0.irq irqNumber {1}

add_connection nios2_gen2_0.irq pio_request.irq
set_connection_parameter_value nios2_gen2_0.irq/pio_request.irq irqNumber {2}

add_connection sys_sdram_pll_0.reset_source audio_pll_0.ref_reset

add_connection sys_sdram_pll_0.reset_source new_sdram_controller_0.reset

add_connection sys_sdram_pll_0.reset_source onchip_memory2_0.reset1

add_connection sys_sdram_pll_0.reset_source pio_pixel_color.reset

add_connection sys_sdram_pll_0.reset_source pio_pixel_position.reset

add_connection sys_sdram_pll_0.reset_source pio_request.reset

add_connection sys_sdram_pll_0.sys_clk audio_pll_0.ref_clk

add_connection sys_sdram_pll_0.sys_clk jtag_uart_0.clk

add_connection sys_sdram_pll_0.sys_clk new_sdram_controller_0.clk

add_connection sys_sdram_pll_0.sys_clk nios2_gen2_0.clk

add_connection sys_sdram_pll_0.sys_clk onchip_memory2_0.clk1

add_connection sys_sdram_pll_0.sys_clk pio_pixel_color.clk

add_connection sys_sdram_pll_0.sys_clk pio_pixel_position.clk

add_connection sys_sdram_pll_0.sys_clk pio_request.clk

# interconnect requirements
set_interconnect_requirement {$system} {qsys_mm.clockCrossingAdapter} {HANDSHAKE}
set_interconnect_requirement {$system} {qsys_mm.enableEccProtection} {FALSE}
set_interconnect_requirement {$system} {qsys_mm.insertDefaultSlave} {FALSE}
set_interconnect_requirement {$system} {qsys_mm.maxAdditionalLatency} {1}

save_system {NIOSII_Test.qsys}
