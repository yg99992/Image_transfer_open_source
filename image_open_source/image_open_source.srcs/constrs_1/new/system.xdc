
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

create_clock -period 50.000 -name MAIN_CLK [get_ports pl_clk]
set_property PACKAGE_PIN U18 [get_ports pl_clk]
set_property IOSTANDARD LVCMOS33 [get_ports pl_clk]

connect_debug_port u_ila_0/probe0 [get_nets [list {system_i/image_ctl_0/inst/image_ctl_v1_0_S00_AXI_inst/SensorCtrl_top/SensorCtrl0/Cnt_start[0]} {system_i/image_ctl_0/inst/image_ctl_v1_0_S00_AXI_inst/SensorCtrl_top/SensorCtrl0/Cnt_start[1]} {system_i/image_ctl_0/inst/image_ctl_v1_0_S00_AXI_inst/SensorCtrl_top/SensorCtrl0/Cnt_start[2]} {system_i/image_ctl_0/inst/image_ctl_v1_0_S00_AXI_inst/SensorCtrl_top/SensorCtrl0/Cnt_start[3]} {system_i/image_ctl_0/inst/image_ctl_v1_0_S00_AXI_inst/SensorCtrl_top/SensorCtrl0/Cnt_start[4]} {system_i/image_ctl_0/inst/image_ctl_v1_0_S00_AXI_inst/SensorCtrl_top/SensorCtrl0/Cnt_start[5]} {system_i/image_ctl_0/inst/image_ctl_v1_0_S00_AXI_inst/SensorCtrl_top/SensorCtrl0/Cnt_start[6]} {system_i/image_ctl_0/inst/image_ctl_v1_0_S00_AXI_inst/SensorCtrl_top/SensorCtrl0/Cnt_start[7]} {system_i/image_ctl_0/inst/image_ctl_v1_0_S00_AXI_inst/SensorCtrl_top/SensorCtrl0/Cnt_start[8]} {system_i/image_ctl_0/inst/image_ctl_v1_0_S00_AXI_inst/SensorCtrl_top/SensorCtrl0/Cnt_start[9]} {system_i/image_ctl_0/inst/image_ctl_v1_0_S00_AXI_inst/SensorCtrl_top/SensorCtrl0/Cnt_start[10]} {system_i/image_ctl_0/inst/image_ctl_v1_0_S00_AXI_inst/SensorCtrl_top/SensorCtrl0/Cnt_start[11]} {system_i/image_ctl_0/inst/image_ctl_v1_0_S00_AXI_inst/SensorCtrl_top/SensorCtrl0/Cnt_start[12]} {system_i/image_ctl_0/inst/image_ctl_v1_0_S00_AXI_inst/SensorCtrl_top/SensorCtrl0/Cnt_start[13]} {system_i/image_ctl_0/inst/image_ctl_v1_0_S00_AXI_inst/SensorCtrl_top/SensorCtrl0/Cnt_start[14]} {system_i/image_ctl_0/inst/image_ctl_v1_0_S00_AXI_inst/SensorCtrl_top/SensorCtrl0/Cnt_start[15]} {system_i/image_ctl_0/inst/image_ctl_v1_0_S00_AXI_inst/SensorCtrl_top/SensorCtrl0/Cnt_start[16]} {system_i/image_ctl_0/inst/image_ctl_v1_0_S00_AXI_inst/SensorCtrl_top/SensorCtrl0/Cnt_start[17]} {system_i/image_ctl_0/inst/image_ctl_v1_0_S00_AXI_inst/SensorCtrl_top/SensorCtrl0/Cnt_start[18]} {system_i/image_ctl_0/inst/image_ctl_v1_0_S00_AXI_inst/SensorCtrl_top/SensorCtrl0/Cnt_start[19]} {system_i/image_ctl_0/inst/image_ctl_v1_0_S00_AXI_inst/SensorCtrl_top/SensorCtrl0/Cnt_start[20]}]]
connect_debug_port u_ila_0/probe1 [get_nets [list {system_i/image_ctl_0_Mode[0]} {system_i/image_ctl_0_Mode[1]}]]
connect_debug_port u_ila_0/probe2 [get_nets [list system_i/image_ctl_0_Cstart]]
connect_debug_port u_ila_0/probe3 [get_nets [list system_i/image_ctl_0_Expo_start]]
connect_debug_port u_ila_0/probe4 [get_nets [list system_i/image_ctl_0_Frame_done]]
connect_debug_port u_ila_0/probe5 [get_nets [list system_i/image_ctl_0_ipor]]
connect_debug_port u_ila_0/probe6 [get_nets [list system_i/image_ctl_0_mdd]]
connect_debug_port u_ila_0/probe7 [get_nets [list system_i/ocompclk_1]]
connect_debug_port u_ila_0/probe8 [get_nets [list system_i/oisadc_1]]
connect_debug_port u_ila_0/probe9 [get_nets [list system_i/image_ctl_0/inst/image_ctl_v1_0_S00_AXI_inst/SensorCtrl_top/SensorCtrl0/s00_axi_aresetn]]
connect_debug_port u_ila_0/probe10 [get_nets [list system_i/image_ctl_0/inst/image_ctl_v1_0_S00_AXI_inst/SensorCtrl_top/SensorCtrl0/start_up_r1]]
#connect_debug_port dbg_hub/clk [get_nets clk]

















