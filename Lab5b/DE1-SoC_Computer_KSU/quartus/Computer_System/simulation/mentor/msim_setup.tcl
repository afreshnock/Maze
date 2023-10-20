
# (C) 2001-2023 Altera Corporation. All rights reserved.
# Your use of Altera Corporation's design tools, logic functions and 
# other software and tools, and its AMPP partner logic functions, and 
# any output files any of the foregoing (including device programming 
# or simulation files), and any associated documentation or information 
# are expressly subject to the terms and conditions of the Altera 
# Program License Subscription Agreement, Altera MegaCore Function 
# License Agreement, or other applicable license agreement, including, 
# without limitation, that your use is for the sole purpose of 
# programming logic devices manufactured by Altera and sold by Altera 
# or its authorized distributors. Please refer to the applicable 
# agreement for further details.

# ----------------------------------------
# Auto-generated simulation script msim_setup.tcl
# ----------------------------------------
# This script provides commands to simulate the following IP detected in
# your Quartus project:
#     Computer_System
# 
# Altera recommends that you source this Quartus-generated IP simulation
# script from your own customized top-level script, and avoid editing this
# generated script.
# 
# To write a top-level script that compiles Altera simulation libraries and
# the Quartus-generated IP in your project, along with your design and
# testbench files, copy the text from the TOP-LEVEL TEMPLATE section below
# into a new file, e.g. named "mentor.do", and modify the text as directed.
# 
# ----------------------------------------
# # TOP-LEVEL TEMPLATE - BEGIN
# #
# # QSYS_SIMDIR is used in the Quartus-generated IP simulation script to
# # construct paths to the files required to simulate the IP in your Quartus
# # project. By default, the IP script assumes that you are launching the
# # simulator from the IP script location. If launching from another
# # location, set QSYS_SIMDIR to the output directory you specified when you
# # generated the IP script, relative to the directory from which you launch
# # the simulator.
# #
# set QSYS_SIMDIR <script generation output directory>
# #
# # Source the generated IP simulation script.
# source $QSYS_SIMDIR/mentor/msim_setup.tcl
# #
# # Set any compilation options you require (this is unusual).
# set USER_DEFINED_COMPILE_OPTIONS <compilation options>
# set USER_DEFINED_VHDL_COMPILE_OPTIONS <compilation options for VHDL>
# set USER_DEFINED_VERILOG_COMPILE_OPTIONS <compilation options for Verilog>
# #
# # Call command to compile the Quartus EDA simulation library.
# dev_com
# #
# # Call command to compile the Quartus-generated IP simulation files.
# com
# #
# # Add commands to compile all design files and testbench files, including
# # the top level. (These are all the files required for simulation other
# # than the files compiled by the Quartus-generated IP simulation script)
# #
# vlog <compilation options> <design and testbench files>
# #
# # Set the top-level simulation or testbench module/entity name, which is
# # used by the elab command to elaborate the top level.
# #
# set TOP_LEVEL_NAME <simulation top>
# #
# # Set any elaboration options you require.
# set USER_DEFINED_ELAB_OPTIONS <elaboration options>
# #
# # Call command to elaborate your design and testbench.
# elab
# #
# # Run the simulation.
# run -a
# #
# # Report success to the shell.
# exit -code 0
# #
# # TOP-LEVEL TEMPLATE - END
# ----------------------------------------
# 
# IP SIMULATION SCRIPT
# ----------------------------------------
# If Computer_System is one of several IP cores in your
# Quartus project, you can generate a simulation script
# suitable for inclusion in your top-level simulation
# script by running the following command line:
# 
# ip-setup-simulation --quartus-project=<quartus project>
# 
# ip-setup-simulation will discover the Altera IP
# within the Quartus project, and generate a unified
# script which supports all the Altera IP within the design.
# ----------------------------------------
# ACDS 18.1 625 win32 2023.09.25.09:40:03

# ----------------------------------------
# Initialize variables
if ![info exists SYSTEM_INSTANCE_NAME] { 
  set SYSTEM_INSTANCE_NAME ""
} elseif { ![ string match "" $SYSTEM_INSTANCE_NAME ] } { 
  set SYSTEM_INSTANCE_NAME "/$SYSTEM_INSTANCE_NAME"
}

if ![info exists TOP_LEVEL_NAME] { 
  set TOP_LEVEL_NAME "Computer_System"
}

if ![info exists QSYS_SIMDIR] { 
  set QSYS_SIMDIR "./../"
}

if ![info exists QUARTUS_INSTALL_DIR] { 
  set QUARTUS_INSTALL_DIR "C:/intelfpga_lite/18.1/quartus/"
}

if ![info exists USER_DEFINED_COMPILE_OPTIONS] { 
  set USER_DEFINED_COMPILE_OPTIONS ""
}
if ![info exists USER_DEFINED_VHDL_COMPILE_OPTIONS] { 
  set USER_DEFINED_VHDL_COMPILE_OPTIONS ""
}
if ![info exists USER_DEFINED_VERILOG_COMPILE_OPTIONS] { 
  set USER_DEFINED_VERILOG_COMPILE_OPTIONS ""
}
if ![info exists USER_DEFINED_ELAB_OPTIONS] { 
  set USER_DEFINED_ELAB_OPTIONS ""
}

# ----------------------------------------
# Initialize simulation properties - DO NOT MODIFY!
set ELAB_OPTIONS ""
set SIM_OPTIONS ""
if ![ string match "*-64 vsim*" [ vsim -version ] ] {
} else {
}

# ----------------------------------------
# Copy ROM/RAM files to simulation directory
alias file_copy {
  echo "\[exec\] file_copy"
  file copy -force $QSYS_SIMDIR/submodules/altera_up_video_char_mode_rom_128.mif ./
  file copy -force $QSYS_SIMDIR/submodules/altera_up_video_fb_color_rom.mif ./
  file copy -force $QSYS_SIMDIR/submodules/Computer_System_Onchip_SRAM.hex ./
}

# ----------------------------------------
# Create compilation libraries
proc ensure_lib { lib } { if ![file isdirectory $lib] { vlib $lib } }
ensure_lib          ./libraries/     
ensure_lib          ./libraries/work/
vmap       work     ./libraries/work/
vmap       work_lib ./libraries/work/
if ![ string match "*ModelSim ALTERA*" [ vsim -version ] ] {
  ensure_lib                       ./libraries/altera_ver/           
  vmap       altera_ver            ./libraries/altera_ver/           
  ensure_lib                       ./libraries/lpm_ver/              
  vmap       lpm_ver               ./libraries/lpm_ver/              
  ensure_lib                       ./libraries/sgate_ver/            
  vmap       sgate_ver             ./libraries/sgate_ver/            
  ensure_lib                       ./libraries/altera_mf_ver/        
  vmap       altera_mf_ver         ./libraries/altera_mf_ver/        
  ensure_lib                       ./libraries/altera_lnsim_ver/     
  vmap       altera_lnsim_ver      ./libraries/altera_lnsim_ver/     
  ensure_lib                       ./libraries/cyclonev_ver/         
  vmap       cyclonev_ver          ./libraries/cyclonev_ver/         
  ensure_lib                       ./libraries/cyclonev_hssi_ver/    
  vmap       cyclonev_hssi_ver     ./libraries/cyclonev_hssi_ver/    
  ensure_lib                       ./libraries/cyclonev_pcie_hip_ver/
  vmap       cyclonev_pcie_hip_ver ./libraries/cyclonev_pcie_hip_ver/
}
ensure_lib                                                    ./libraries/altera_common_sv_packages/                         
vmap       altera_common_sv_packages                          ./libraries/altera_common_sv_packages/                         
ensure_lib                                                    ./libraries/error_adapter_0/                                   
vmap       error_adapter_0                                    ./libraries/error_adapter_0/                                   
ensure_lib                                                    ./libraries/video_pll/                                         
vmap       video_pll                                          ./libraries/video_pll/                                         
ensure_lib                                                    ./libraries/border/                                            
vmap       border                                             ./libraries/border/                                            
ensure_lib                                                    ./libraries/rsp_mux/                                           
vmap       rsp_mux                                            ./libraries/rsp_mux/                                           
ensure_lib                                                    ./libraries/rsp_demux/                                         
vmap       rsp_demux                                          ./libraries/rsp_demux/                                         
ensure_lib                                                    ./libraries/cmd_mux/                                           
vmap       cmd_mux                                            ./libraries/cmd_mux/                                           
ensure_lib                                                    ./libraries/cmd_demux/                                         
vmap       cmd_demux                                          ./libraries/cmd_demux/                                         
ensure_lib                                                    ./libraries/router_002/                                        
vmap       router_002                                         ./libraries/router_002/                                        
ensure_lib                                                    ./libraries/router/                                            
vmap       router                                             ./libraries/router/                                            
ensure_lib                                                    ./libraries/avalon_st_adapter_002/                             
vmap       avalon_st_adapter_002                              ./libraries/avalon_st_adapter_002/                             
ensure_lib                                                    ./libraries/avalon_st_adapter_001/                             
vmap       avalon_st_adapter_001                              ./libraries/avalon_st_adapter_001/                             
ensure_lib                                                    ./libraries/avalon_st_adapter/                                 
vmap       avalon_st_adapter                                  ./libraries/avalon_st_adapter/                                 
ensure_lib                                                    ./libraries/rsp_mux_002/                                       
vmap       rsp_mux_002                                        ./libraries/rsp_mux_002/                                       
ensure_lib                                                    ./libraries/rsp_demux_003/                                     
vmap       rsp_demux_003                                      ./libraries/rsp_demux_003/                                     
ensure_lib                                                    ./libraries/rsp_demux_002/                                     
vmap       rsp_demux_002                                      ./libraries/rsp_demux_002/                                     
ensure_lib                                                    ./libraries/rsp_demux_001/                                     
vmap       rsp_demux_001                                      ./libraries/rsp_demux_001/                                     
ensure_lib                                                    ./libraries/cmd_mux_003/                                       
vmap       cmd_mux_003                                        ./libraries/cmd_mux_003/                                       
ensure_lib                                                    ./libraries/cmd_mux_002/                                       
vmap       cmd_mux_002                                        ./libraries/cmd_mux_002/                                       
ensure_lib                                                    ./libraries/cmd_mux_001/                                       
vmap       cmd_mux_001                                        ./libraries/cmd_mux_001/                                       
ensure_lib                                                    ./libraries/cmd_demux_002/                                     
vmap       cmd_demux_002                                      ./libraries/cmd_demux_002/                                     
ensure_lib                                                    ./libraries/VGA_Subsystem_char_buffer_slave_burst_adapter/     
vmap       VGA_Subsystem_char_buffer_slave_burst_adapter      ./libraries/VGA_Subsystem_char_buffer_slave_burst_adapter/     
ensure_lib                                                    ./libraries/router_006/                                        
vmap       router_006                                         ./libraries/router_006/                                        
ensure_lib                                                    ./libraries/router_005/                                        
vmap       router_005                                         ./libraries/router_005/                                        
ensure_lib                                                    ./libraries/router_004/                                        
vmap       router_004                                         ./libraries/router_004/                                        
ensure_lib                                                    ./libraries/router_003/                                        
vmap       router_003                                         ./libraries/router_003/                                        
ensure_lib                                                    ./libraries/VGA_Subsystem_char_buffer_slave_agent_rsp_fifo/    
vmap       VGA_Subsystem_char_buffer_slave_agent_rsp_fifo     ./libraries/VGA_Subsystem_char_buffer_slave_agent_rsp_fifo/    
ensure_lib                                                    ./libraries/VGA_Subsystem_char_buffer_slave_agent/             
vmap       VGA_Subsystem_char_buffer_slave_agent              ./libraries/VGA_Subsystem_char_buffer_slave_agent/             
ensure_lib                                                    ./libraries/ARM_A9_HPS_h2f_axi_master_agent/                   
vmap       ARM_A9_HPS_h2f_axi_master_agent                    ./libraries/ARM_A9_HPS_h2f_axi_master_agent/                   
ensure_lib                                                    ./libraries/VGA_Subsystem_char_buffer_slave_translator/        
vmap       VGA_Subsystem_char_buffer_slave_translator         ./libraries/VGA_Subsystem_char_buffer_slave_translator/        
ensure_lib                                                    ./libraries/ARM_A9_HPS_f2h_axi_slave_wr_cmd_width_adapter/     
vmap       ARM_A9_HPS_f2h_axi_slave_wr_cmd_width_adapter      ./libraries/ARM_A9_HPS_f2h_axi_slave_wr_cmd_width_adapter/     
ensure_lib                                                    ./libraries/F2H_Mem_Window_00000000_expanded_master_limiter/   
vmap       F2H_Mem_Window_00000000_expanded_master_limiter    ./libraries/F2H_Mem_Window_00000000_expanded_master_limiter/   
ensure_lib                                                    ./libraries/ARM_A9_HPS_f2h_axi_slave_agent/                    
vmap       ARM_A9_HPS_f2h_axi_slave_agent                     ./libraries/ARM_A9_HPS_f2h_axi_slave_agent/                    
ensure_lib                                                    ./libraries/F2H_Mem_Window_00000000_expanded_master_agent/     
vmap       F2H_Mem_Window_00000000_expanded_master_agent      ./libraries/F2H_Mem_Window_00000000_expanded_master_agent/     
ensure_lib                                                    ./libraries/F2H_Mem_Window_00000000_expanded_master_translator/
vmap       F2H_Mem_Window_00000000_expanded_master_translator ./libraries/F2H_Mem_Window_00000000_expanded_master_translator/
ensure_lib                                                    ./libraries/VGA_Pixel_RGB_Resampler/                           
vmap       VGA_Pixel_RGB_Resampler                            ./libraries/VGA_Pixel_RGB_Resampler/                           
ensure_lib                                                    ./libraries/VGA_Pixel_FIFO/                                    
vmap       VGA_Pixel_FIFO                                     ./libraries/VGA_Pixel_FIFO/                                    
ensure_lib                                                    ./libraries/VGA_Pixel_DMA/                                     
vmap       VGA_Pixel_DMA                                      ./libraries/VGA_Pixel_DMA/                                     
ensure_lib                                                    ./libraries/VGA_PLL/                                           
vmap       VGA_PLL                                            ./libraries/VGA_PLL/                                           
ensure_lib                                                    ./libraries/VGA_Dual_Clock_FIFO/                               
vmap       VGA_Dual_Clock_FIFO                                ./libraries/VGA_Dual_Clock_FIFO/                               
ensure_lib                                                    ./libraries/VGA_Controller/                                    
vmap       VGA_Controller                                     ./libraries/VGA_Controller/                                    
ensure_lib                                                    ./libraries/VGA_Char_Buffer/                                   
vmap       VGA_Char_Buffer                                    ./libraries/VGA_Char_Buffer/                                   
ensure_lib                                                    ./libraries/VGA_Alpha_Blender/                                 
vmap       VGA_Alpha_Blender                                  ./libraries/VGA_Alpha_Blender/                                 
ensure_lib                                                    ./libraries/reset_from_locked/                                 
vmap       reset_from_locked                                  ./libraries/reset_from_locked/                                 
ensure_lib                                                    ./libraries/sys_pll/                                           
vmap       sys_pll                                            ./libraries/sys_pll/                                           
ensure_lib                                                    ./libraries/hps_io/                                            
vmap       hps_io                                             ./libraries/hps_io/                                            
ensure_lib                                                    ./libraries/fpga_interfaces/                                   
vmap       fpga_interfaces                                    ./libraries/fpga_interfaces/                                   
ensure_lib                                                    ./libraries/rst_controller/                                    
vmap       rst_controller                                     ./libraries/rst_controller/                                    
ensure_lib                                                    ./libraries/irq_mapper_001/                                    
vmap       irq_mapper_001                                     ./libraries/irq_mapper_001/                                    
ensure_lib                                                    ./libraries/irq_mapper/                                        
vmap       irq_mapper                                         ./libraries/irq_mapper/                                        
ensure_lib                                                    ./libraries/mm_interconnect_3/                                 
vmap       mm_interconnect_3                                  ./libraries/mm_interconnect_3/                                 
ensure_lib                                                    ./libraries/mm_interconnect_2/                                 
vmap       mm_interconnect_2                                  ./libraries/mm_interconnect_2/                                 
ensure_lib                                                    ./libraries/mm_interconnect_1/                                 
vmap       mm_interconnect_1                                  ./libraries/mm_interconnect_1/                                 
ensure_lib                                                    ./libraries/mm_interconnect_0/                                 
vmap       mm_interconnect_0                                  ./libraries/mm_interconnect_0/                                 
ensure_lib                                                    ./libraries/VGA_Subsystem/                                     
vmap       VGA_Subsystem                                      ./libraries/VGA_Subsystem/                                     
ensure_lib                                                    ./libraries/System_PLL/                                        
vmap       System_PLL                                         ./libraries/System_PLL/                                        
ensure_lib                                                    ./libraries/SysID/                                             
vmap       SysID                                              ./libraries/SysID/                                             
ensure_lib                                                    ./libraries/Slider_Switches/                                   
vmap       Slider_Switches                                    ./libraries/Slider_Switches/                                   
ensure_lib                                                    ./libraries/SDRAM/                                             
vmap       SDRAM                                              ./libraries/SDRAM/                                             
ensure_lib                                                    ./libraries/Pushbuttons/                                       
vmap       Pushbuttons                                        ./libraries/Pushbuttons/                                       
ensure_lib                                                    ./libraries/Pixel_DMA_Addr_Translation/                        
vmap       Pixel_DMA_Addr_Translation                         ./libraries/Pixel_DMA_Addr_Translation/                        
ensure_lib                                                    ./libraries/Onchip_SRAM/                                       
vmap       Onchip_SRAM                                        ./libraries/Onchip_SRAM/                                       
ensure_lib                                                    ./libraries/LEDs/                                              
vmap       LEDs                                               ./libraries/LEDs/                                              
ensure_lib                                                    ./libraries/HEX3_HEX0/                                         
vmap       HEX3_HEX0                                          ./libraries/HEX3_HEX0/                                         
ensure_lib                                                    ./libraries/F2H_Mem_Window_00000000/                           
vmap       F2H_Mem_Window_00000000                            ./libraries/F2H_Mem_Window_00000000/                           
ensure_lib                                                    ./libraries/Audio_space/                                       
vmap       Audio_space                                        ./libraries/Audio_space/                                       
ensure_lib                                                    ./libraries/Audio_ctrl/                                        
vmap       Audio_ctrl                                         ./libraries/Audio_ctrl/                                        
ensure_lib                                                    ./libraries/Audio_DACL_Dat/                                    
vmap       Audio_DACL_Dat                                     ./libraries/Audio_DACL_Dat/                                    
ensure_lib                                                    ./libraries/Audio_ADCL_Dat/                                    
vmap       Audio_ADCL_Dat                                     ./libraries/Audio_ADCL_Dat/                                    
ensure_lib                                                    ./libraries/AV_Config/                                         
vmap       AV_Config                                          ./libraries/AV_Config/                                         
ensure_lib                                                    ./libraries/ARM_A9_HPS/                                        
vmap       ARM_A9_HPS                                         ./libraries/ARM_A9_HPS/                                        

# ----------------------------------------
# Compile device library files
alias dev_com {
  echo "\[exec\] dev_com"
  if ![ string match "*ModelSim ALTERA*" [ vsim -version ] ] {
    eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.v"                     -work altera_ver           
    eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/220model.v"                              -work lpm_ver              
    eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.v"                                 -work sgate_ver            
    eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.v"                             -work altera_mf_ver        
    eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim.sv"                         -work altera_lnsim_ver     
    eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/mentor/cyclonev_atoms_ncrypt.v"          -work cyclonev_ver         
    eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/mentor/cyclonev_hmi_atoms_ncrypt.v"      -work cyclonev_ver         
    eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_atoms.v"                        -work cyclonev_ver         
    eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/mentor/cyclonev_hssi_atoms_ncrypt.v"     -work cyclonev_hssi_ver    
    eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_hssi_atoms.v"                   -work cyclonev_hssi_ver    
    eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/mentor/cyclonev_pcie_hip_atoms_ncrypt.v" -work cyclonev_pcie_hip_ver
    eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_pcie_hip_atoms.v"               -work cyclonev_pcie_hip_ver
  }
}

# ----------------------------------------
# Compile the design files in correct order
alias com {
  echo "\[exec\] com"
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/verbosity_pkg.sv"                                                                                        -work altera_common_sv_packages                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/avalon_utilities_pkg.sv"                                                                                 -work altera_common_sv_packages                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/avalon_mm_pkg.sv"                                                                                        -work altera_common_sv_packages                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/Computer_System_mm_interconnect_1_avalon_st_adapter_002_error_adapter_0.sv" -L altera_common_sv_packages -work error_adapter_0                                   
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/Computer_System_mm_interconnect_1_avalon_st_adapter_001_error_adapter_0.sv" -L altera_common_sv_packages -work error_adapter_0                                   
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/Computer_System_mm_interconnect_1_avalon_st_adapter_error_adapter_0.sv"     -L altera_common_sv_packages -work error_adapter_0                                   
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/Computer_System_VGA_Subsystem_VGA_PLL_video_pll.vo"                                                      -work video_pll                                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_mm_slave_bfm.sv"                                              -L altera_common_sv_packages -work border                                            
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_interrupt_sink.sv"                                            -L altera_common_sv_packages -work border                                            
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_clock_source.sv"                                              -L altera_common_sv_packages -work border                                            
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_reset_source.sv"                                              -L altera_common_sv_packages -work border                                            
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/Computer_System_ARM_A9_HPS_hps_io_border_memory.sv"                         -L altera_common_sv_packages -work border                                            
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/Computer_System_ARM_A9_HPS_hps_io_border_hps_io.sv"                         -L altera_common_sv_packages -work border                                            
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/Computer_System_ARM_A9_HPS_hps_io_border.sv"                                -L altera_common_sv_packages -work border                                            
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/Computer_System_mm_interconnect_2_rsp_mux.sv"                               -L altera_common_sv_packages -work rsp_mux                                           
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                                -L altera_common_sv_packages -work rsp_mux                                           
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/Computer_System_mm_interconnect_2_rsp_demux.sv"                             -L altera_common_sv_packages -work rsp_demux                                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/Computer_System_mm_interconnect_2_cmd_mux.sv"                               -L altera_common_sv_packages -work cmd_mux                                           
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                                -L altera_common_sv_packages -work cmd_mux                                           
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/Computer_System_mm_interconnect_2_cmd_demux.sv"                             -L altera_common_sv_packages -work cmd_demux                                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/Computer_System_mm_interconnect_2_router_002.sv"                            -L altera_common_sv_packages -work router_002                                        
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/Computer_System_mm_interconnect_2_router.sv"                                -L altera_common_sv_packages -work router                                            
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/Computer_System_mm_interconnect_1_avalon_st_adapter_002.v"                                               -work avalon_st_adapter_002                             
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/Computer_System_mm_interconnect_1_avalon_st_adapter_001.v"                                               -work avalon_st_adapter_001                             
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/Computer_System_mm_interconnect_1_avalon_st_adapter.v"                                                   -work avalon_st_adapter                                 
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/Computer_System_mm_interconnect_1_rsp_mux_002.sv"                           -L altera_common_sv_packages -work rsp_mux_002                                       
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                                -L altera_common_sv_packages -work rsp_mux_002                                       
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/Computer_System_mm_interconnect_1_rsp_mux.sv"                               -L altera_common_sv_packages -work rsp_mux                                           
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                                -L altera_common_sv_packages -work rsp_mux                                           
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/Computer_System_mm_interconnect_1_rsp_demux_003.sv"                         -L altera_common_sv_packages -work rsp_demux_003                                     
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/Computer_System_mm_interconnect_1_rsp_demux_002.sv"                         -L altera_common_sv_packages -work rsp_demux_002                                     
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/Computer_System_mm_interconnect_1_rsp_demux_001.sv"                         -L altera_common_sv_packages -work rsp_demux_001                                     
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/Computer_System_mm_interconnect_1_rsp_demux.sv"                             -L altera_common_sv_packages -work rsp_demux                                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/Computer_System_mm_interconnect_1_cmd_mux_003.sv"                           -L altera_common_sv_packages -work cmd_mux_003                                       
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                                -L altera_common_sv_packages -work cmd_mux_003                                       
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/Computer_System_mm_interconnect_1_cmd_mux_002.sv"                           -L altera_common_sv_packages -work cmd_mux_002                                       
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                                -L altera_common_sv_packages -work cmd_mux_002                                       
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/Computer_System_mm_interconnect_1_cmd_mux_001.sv"                           -L altera_common_sv_packages -work cmd_mux_001                                       
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                                -L altera_common_sv_packages -work cmd_mux_001                                       
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/Computer_System_mm_interconnect_1_cmd_mux.sv"                               -L altera_common_sv_packages -work cmd_mux                                           
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                                -L altera_common_sv_packages -work cmd_mux                                           
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/Computer_System_mm_interconnect_1_cmd_demux_002.sv"                         -L altera_common_sv_packages -work cmd_demux_002                                     
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/Computer_System_mm_interconnect_1_cmd_demux.sv"                             -L altera_common_sv_packages -work cmd_demux                                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter.sv"                                             -L altera_common_sv_packages -work VGA_Subsystem_char_buffer_slave_burst_adapter     
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter_uncmpr.sv"                                      -L altera_common_sv_packages -work VGA_Subsystem_char_buffer_slave_burst_adapter     
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter_13_1.sv"                                        -L altera_common_sv_packages -work VGA_Subsystem_char_buffer_slave_burst_adapter     
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter_new.sv"                                         -L altera_common_sv_packages -work VGA_Subsystem_char_buffer_slave_burst_adapter     
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_incr_burst_converter.sv"                                             -L altera_common_sv_packages -work VGA_Subsystem_char_buffer_slave_burst_adapter     
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_wrap_burst_converter.sv"                                             -L altera_common_sv_packages -work VGA_Subsystem_char_buffer_slave_burst_adapter     
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_default_burst_converter.sv"                                          -L altera_common_sv_packages -work VGA_Subsystem_char_buffer_slave_burst_adapter     
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_address_alignment.sv"                                         -L altera_common_sv_packages -work VGA_Subsystem_char_buffer_slave_burst_adapter     
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_stage.sv"                                         -L altera_common_sv_packages -work VGA_Subsystem_char_buffer_slave_burst_adapter     
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_base.v"                                           -L altera_common_sv_packages -work VGA_Subsystem_char_buffer_slave_burst_adapter     
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/Computer_System_mm_interconnect_1_router_006.sv"                            -L altera_common_sv_packages -work router_006                                        
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/Computer_System_mm_interconnect_1_router_005.sv"                            -L altera_common_sv_packages -work router_005                                        
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/Computer_System_mm_interconnect_1_router_004.sv"                            -L altera_common_sv_packages -work router_004                                        
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/Computer_System_mm_interconnect_1_router_003.sv"                            -L altera_common_sv_packages -work router_003                                        
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/Computer_System_mm_interconnect_1_router_002.sv"                            -L altera_common_sv_packages -work router_002                                        
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/Computer_System_mm_interconnect_1_router.sv"                                -L altera_common_sv_packages -work router                                            
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_avalon_sc_fifo.v"                                                                                 -work VGA_Subsystem_char_buffer_slave_agent_rsp_fifo    
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_slave_agent.sv"                                               -L altera_common_sv_packages -work VGA_Subsystem_char_buffer_slave_agent             
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_burst_uncompressor.sv"                                        -L altera_common_sv_packages -work VGA_Subsystem_char_buffer_slave_agent             
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_axi_master_ni.sv"                                             -L altera_common_sv_packages -work ARM_A9_HPS_h2f_axi_master_agent                   
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_address_alignment.sv"                                         -L altera_common_sv_packages -work ARM_A9_HPS_h2f_axi_master_agent                   
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_slave_translator.sv"                                          -L altera_common_sv_packages -work VGA_Subsystem_char_buffer_slave_translator        
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_width_adapter.sv"                                             -L altera_common_sv_packages -work ARM_A9_HPS_f2h_axi_slave_wr_cmd_width_adapter     
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_address_alignment.sv"                                         -L altera_common_sv_packages -work ARM_A9_HPS_f2h_axi_slave_wr_cmd_width_adapter     
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_burst_uncompressor.sv"                                        -L altera_common_sv_packages -work ARM_A9_HPS_f2h_axi_slave_wr_cmd_width_adapter     
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/Computer_System_mm_interconnect_0_rsp_mux.sv"                               -L altera_common_sv_packages -work rsp_mux                                           
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                                -L altera_common_sv_packages -work rsp_mux                                           
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/Computer_System_mm_interconnect_0_rsp_demux.sv"                             -L altera_common_sv_packages -work rsp_demux                                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/Computer_System_mm_interconnect_0_cmd_mux.sv"                               -L altera_common_sv_packages -work cmd_mux                                           
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                                -L altera_common_sv_packages -work cmd_mux                                           
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/Computer_System_mm_interconnect_0_cmd_demux.sv"                             -L altera_common_sv_packages -work cmd_demux                                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_traffic_limiter.sv"                                           -L altera_common_sv_packages -work F2H_Mem_Window_00000000_expanded_master_limiter   
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_reorder_memory.sv"                                            -L altera_common_sv_packages -work F2H_Mem_Window_00000000_expanded_master_limiter   
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_sc_fifo.v"                                                    -L altera_common_sv_packages -work F2H_Mem_Window_00000000_expanded_master_limiter   
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_base.v"                                           -L altera_common_sv_packages -work F2H_Mem_Window_00000000_expanded_master_limiter   
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/Computer_System_mm_interconnect_0_router_003.sv"                            -L altera_common_sv_packages -work router_003                                        
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/Computer_System_mm_interconnect_0_router.sv"                                -L altera_common_sv_packages -work router                                            
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_axi_slave_ni.sv"                                              -L altera_common_sv_packages -work ARM_A9_HPS_f2h_axi_slave_agent                    
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_burst_uncompressor.sv"                                        -L altera_common_sv_packages -work ARM_A9_HPS_f2h_axi_slave_agent                    
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_avalon_sc_fifo.v"                                                                                 -work ARM_A9_HPS_f2h_axi_slave_agent                    
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_address_alignment.sv"                                         -L altera_common_sv_packages -work ARM_A9_HPS_f2h_axi_slave_agent                    
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_master_agent.sv"                                              -L altera_common_sv_packages -work F2H_Mem_Window_00000000_expanded_master_agent     
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_master_translator.sv"                                         -L altera_common_sv_packages -work F2H_Mem_Window_00000000_expanded_master_translator
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/Computer_System_VGA_Subsystem_VGA_Pixel_RGB_Resampler.v"                                                 -work VGA_Pixel_RGB_Resampler                           
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/Computer_System_VGA_Subsystem_VGA_Pixel_FIFO.v"                                                          -work VGA_Pixel_FIFO                                    
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/Computer_System_VGA_Subsystem_VGA_Pixel_DMA.v"                                                           -work VGA_Pixel_DMA                                     
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/Computer_System_VGA_Subsystem_VGA_PLL.v"                                                                 -work VGA_PLL                                           
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/Computer_System_VGA_Subsystem_VGA_Dual_Clock_FIFO.v"                                                     -work VGA_Dual_Clock_FIFO                               
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_up_avalon_video_vga_timing.v"                                                                     -work VGA_Controller                                    
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/Computer_System_VGA_Subsystem_VGA_Controller.v"                                                          -work VGA_Controller                                    
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_up_video_128_character_rom.v"                                                                     -work VGA_Char_Buffer                                   
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_up_video_fb_color_rom.v"                                                                          -work VGA_Char_Buffer                                   
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/Computer_System_VGA_Subsystem_VGA_Char_Buffer.v"                                                         -work VGA_Char_Buffer                                   
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_up_video_alpha_blender_normal.v"                                                                  -work VGA_Alpha_Blender                                 
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_up_video_alpha_blender_simple.v"                                                                  -work VGA_Alpha_Blender                                 
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/Computer_System_VGA_Subsystem_VGA_Alpha_Blender.v"                                                       -work VGA_Alpha_Blender                                 
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_up_avalon_reset_from_locked_signal.v"                                                             -work reset_from_locked                                 
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/Computer_System_System_PLL_sys_pll.vo"                                                                   -work sys_pll                                           
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/Computer_System_ARM_A9_HPS_hps_io.v"                                                                     -work hps_io                                            
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_mm_slave_bfm.sv"                                              -L altera_common_sv_packages -work fpga_interfaces                                   
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/questa_mvc_svapi.svh"                                                       -L altera_common_sv_packages -work fpga_interfaces                                   
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/mgc_common_axi.sv"                                                          -L altera_common_sv_packages -work fpga_interfaces                                   
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/mgc_axi_master.sv"                                                          -L altera_common_sv_packages -work fpga_interfaces                                   
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/mgc_axi_slave.sv"                                                           -L altera_common_sv_packages -work fpga_interfaces                                   
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_interrupt_sink.sv"                                            -L altera_common_sv_packages -work fpga_interfaces                                   
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_clock_source.sv"                                              -L altera_common_sv_packages -work fpga_interfaces                                   
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_reset_source.sv"                                              -L altera_common_sv_packages -work fpga_interfaces                                   
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/Computer_System_ARM_A9_HPS_fpga_interfaces.sv"                              -L altera_common_sv_packages -work fpga_interfaces                                   
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_reset_controller.v"                                                                               -work rst_controller                                    
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_reset_synchronizer.v"                                                                             -work rst_controller                                    
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/Computer_System_irq_mapper_001.sv"                                          -L altera_common_sv_packages -work irq_mapper_001                                    
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/Computer_System_irq_mapper.sv"                                              -L altera_common_sv_packages -work irq_mapper                                        
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/Computer_System_mm_interconnect_3.v"                                                                     -work mm_interconnect_3                                 
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/Computer_System_mm_interconnect_2.v"                                                                     -work mm_interconnect_2                                 
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/Computer_System_mm_interconnect_1.v"                                                                     -work mm_interconnect_1                                 
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/Computer_System_mm_interconnect_0.v"                                                                     -work mm_interconnect_0                                 
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/Computer_System_VGA_Subsystem.v"                                                                         -work VGA_Subsystem                                     
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/Computer_System_System_PLL.v"                                                                            -work System_PLL                                        
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/Computer_System_SysID.v"                                                                                 -work SysID                                             
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/Computer_System_Slider_Switches.v"                                                                       -work Slider_Switches                                   
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/Computer_System_SDRAM.v"                                                                                 -work SDRAM                                             
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/Computer_System_SDRAM_test_component.v"                                                                  -work SDRAM                                             
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/Computer_System_Pushbuttons.v"                                                                           -work Pushbuttons                                       
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_up_avalon_video_dma_ctrl_addr_trans.v"                                                            -work Pixel_DMA_Addr_Translation                        
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/Computer_System_Onchip_SRAM.v"                                                                           -work Onchip_SRAM                                       
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/Computer_System_LEDs.v"                                                                                  -work LEDs                                              
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/Computer_System_HEX3_HEX0.v"                                                                             -work HEX3_HEX0                                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_address_span_extender.sv"                                            -L altera_common_sv_packages -work F2H_Mem_Window_00000000                           
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/Computer_System_Audio_space.v"                                                                           -work Audio_space                                       
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/Computer_System_Audio_ctrl.v"                                                                            -work Audio_ctrl                                        
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/Computer_System_Audio_DACL_Dat.v"                                                                        -work Audio_DACL_Dat                                    
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/Computer_System_Audio_ADCL_Dat.v"                                                                        -work Audio_ADCL_Dat                                    
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_up_av_config_serial_bus_controller.v"                                                             -work AV_Config                                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_up_slow_clock_generator.v"                                                                        -work AV_Config                                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_up_av_config_auto_init.v"                                                                         -work AV_Config                                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_up_av_config_auto_init_dc2.v"                                                                     -work AV_Config                                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_up_av_config_auto_init_d5m.v"                                                                     -work AV_Config                                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_up_av_config_auto_init_lcm.v"                                                                     -work AV_Config                                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_up_av_config_auto_init_ltm.v"                                                                     -work AV_Config                                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_up_av_config_auto_init_ob_de1_soc.v"                                                              -work AV_Config                                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_up_av_config_auto_init_ob_de2_115.v"                                                              -work AV_Config                                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_up_av_config_auto_init_ob_de2i_150.v"                                                             -work AV_Config                                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_up_av_config_auto_init_ob_de10_standard.v"                                                        -work AV_Config                                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_up_av_config_auto_init_ob_audio.v"                                                                -work AV_Config                                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_up_av_config_auto_init_ob_adv7180.v"                                                              -work AV_Config                                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_up_av_config_auto_init_ob_adv7181.v"                                                              -work AV_Config                                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/Computer_System_AV_Config.v"                                                                             -work AV_Config                                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/Computer_System_ARM_A9_HPS.v"                                                                            -work ARM_A9_HPS                                        
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/Computer_System.v"                                                                                                                                                          
}

# ----------------------------------------
# Elaborate top level design
alias elab {
  echo "\[exec\] elab"
  eval vsim -t ps $ELAB_OPTIONS $USER_DEFINED_ELAB_OPTIONS -L work -L work_lib -L altera_common_sv_packages -L error_adapter_0 -L video_pll -L border -L rsp_mux -L rsp_demux -L cmd_mux -L cmd_demux -L router_002 -L router -L avalon_st_adapter_002 -L avalon_st_adapter_001 -L avalon_st_adapter -L rsp_mux_002 -L rsp_demux_003 -L rsp_demux_002 -L rsp_demux_001 -L cmd_mux_003 -L cmd_mux_002 -L cmd_mux_001 -L cmd_demux_002 -L VGA_Subsystem_char_buffer_slave_burst_adapter -L router_006 -L router_005 -L router_004 -L router_003 -L VGA_Subsystem_char_buffer_slave_agent_rsp_fifo -L VGA_Subsystem_char_buffer_slave_agent -L ARM_A9_HPS_h2f_axi_master_agent -L VGA_Subsystem_char_buffer_slave_translator -L ARM_A9_HPS_f2h_axi_slave_wr_cmd_width_adapter -L F2H_Mem_Window_00000000_expanded_master_limiter -L ARM_A9_HPS_f2h_axi_slave_agent -L F2H_Mem_Window_00000000_expanded_master_agent -L F2H_Mem_Window_00000000_expanded_master_translator -L VGA_Pixel_RGB_Resampler -L VGA_Pixel_FIFO -L VGA_Pixel_DMA -L VGA_PLL -L VGA_Dual_Clock_FIFO -L VGA_Controller -L VGA_Char_Buffer -L VGA_Alpha_Blender -L reset_from_locked -L sys_pll -L hps_io -L fpga_interfaces -L rst_controller -L irq_mapper_001 -L irq_mapper -L mm_interconnect_3 -L mm_interconnect_2 -L mm_interconnect_1 -L mm_interconnect_0 -L VGA_Subsystem -L System_PLL -L SysID -L Slider_Switches -L SDRAM -L Pushbuttons -L Pixel_DMA_Addr_Translation -L Onchip_SRAM -L LEDs -L HEX3_HEX0 -L F2H_Mem_Window_00000000 -L Audio_space -L Audio_ctrl -L Audio_DACL_Dat -L Audio_ADCL_Dat -L AV_Config -L ARM_A9_HPS -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver $TOP_LEVEL_NAME
}

# ----------------------------------------
# Elaborate the top level design with novopt option
alias elab_debug {
  echo "\[exec\] elab_debug"
  eval vsim -novopt -t ps $ELAB_OPTIONS $USER_DEFINED_ELAB_OPTIONS -L work -L work_lib -L altera_common_sv_packages -L error_adapter_0 -L video_pll -L border -L rsp_mux -L rsp_demux -L cmd_mux -L cmd_demux -L router_002 -L router -L avalon_st_adapter_002 -L avalon_st_adapter_001 -L avalon_st_adapter -L rsp_mux_002 -L rsp_demux_003 -L rsp_demux_002 -L rsp_demux_001 -L cmd_mux_003 -L cmd_mux_002 -L cmd_mux_001 -L cmd_demux_002 -L VGA_Subsystem_char_buffer_slave_burst_adapter -L router_006 -L router_005 -L router_004 -L router_003 -L VGA_Subsystem_char_buffer_slave_agent_rsp_fifo -L VGA_Subsystem_char_buffer_slave_agent -L ARM_A9_HPS_h2f_axi_master_agent -L VGA_Subsystem_char_buffer_slave_translator -L ARM_A9_HPS_f2h_axi_slave_wr_cmd_width_adapter -L F2H_Mem_Window_00000000_expanded_master_limiter -L ARM_A9_HPS_f2h_axi_slave_agent -L F2H_Mem_Window_00000000_expanded_master_agent -L F2H_Mem_Window_00000000_expanded_master_translator -L VGA_Pixel_RGB_Resampler -L VGA_Pixel_FIFO -L VGA_Pixel_DMA -L VGA_PLL -L VGA_Dual_Clock_FIFO -L VGA_Controller -L VGA_Char_Buffer -L VGA_Alpha_Blender -L reset_from_locked -L sys_pll -L hps_io -L fpga_interfaces -L rst_controller -L irq_mapper_001 -L irq_mapper -L mm_interconnect_3 -L mm_interconnect_2 -L mm_interconnect_1 -L mm_interconnect_0 -L VGA_Subsystem -L System_PLL -L SysID -L Slider_Switches -L SDRAM -L Pushbuttons -L Pixel_DMA_Addr_Translation -L Onchip_SRAM -L LEDs -L HEX3_HEX0 -L F2H_Mem_Window_00000000 -L Audio_space -L Audio_ctrl -L Audio_DACL_Dat -L Audio_ADCL_Dat -L AV_Config -L ARM_A9_HPS -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver $TOP_LEVEL_NAME
}

# ----------------------------------------
# Compile all the design files and elaborate the top level design
alias ld "
  dev_com
  com
  elab
"

# ----------------------------------------
# Compile all the design files and elaborate the top level design with -novopt
alias ld_debug "
  dev_com
  com
  elab_debug
"

# ----------------------------------------
# Print out user commmand line aliases
alias h {
  echo "List Of Command Line Aliases"
  echo
  echo "file_copy                                         -- Copy ROM/RAM files to simulation directory"
  echo
  echo "dev_com                                           -- Compile device library files"
  echo
  echo "com                                               -- Compile the design files in correct order"
  echo
  echo "elab                                              -- Elaborate top level design"
  echo
  echo "elab_debug                                        -- Elaborate the top level design with novopt option"
  echo
  echo "ld                                                -- Compile all the design files and elaborate the top level design"
  echo
  echo "ld_debug                                          -- Compile all the design files and elaborate the top level design with -novopt"
  echo
  echo 
  echo
  echo "List Of Variables"
  echo
  echo "TOP_LEVEL_NAME                                    -- Top level module name."
  echo "                                                     For most designs, this should be overridden"
  echo "                                                     to enable the elab/elab_debug aliases."
  echo
  echo "SYSTEM_INSTANCE_NAME                              -- Instantiated system module name inside top level module."
  echo
  echo "QSYS_SIMDIR                                       -- Platform Designer base simulation directory."
  echo
  echo "QUARTUS_INSTALL_DIR                               -- Quartus installation directory."
  echo
  echo "USER_DEFINED_COMPILE_OPTIONS                      -- User-defined compile options, added to com/dev_com aliases."
  echo
  echo "USER_DEFINED_ELAB_OPTIONS                         -- User-defined elaboration options, added to elab/elab_debug aliases."
  echo
  echo "USER_DEFINED_VHDL_COMPILE_OPTIONS                 -- User-defined vhdl compile options, added to com/dev_com aliases."
  echo
  echo "USER_DEFINED_VERILOG_COMPILE_OPTIONS              -- User-defined verilog compile options, added to com/dev_com aliases."
}
file_copy
h
