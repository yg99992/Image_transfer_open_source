// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Thu Jun  2 22:21:48 2022
// Host        : ww_cyxu running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/01_FPGA_project/Image_sensor/Image_transfer_open_source/project_1_7_9/project_1.srcs/sources_1/bd/system/system_stub.v
// Design      : system
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module system(Cstart, Cstart1, DDR_addr, DDR_ba, DDR_cas_n, 
  DDR_ck_n, DDR_ck_p, DDR_cke, DDR_cs_n, DDR_dm, DDR_dq, DDR_dqs_n, DDR_dqs_p, DDR_odt, DDR_ras_n, 
  DDR_reset_n, DDR_we_n, Enb, Enb1, Expo_Ctrl, Expo_Ctrl1, Expo_start, Expo_start1, 
  FIXED_IO_ddr_vrn, FIXED_IO_ddr_vrp, FIXED_IO_mio, FIXED_IO_ps_clk, FIXED_IO_ps_porb, 
  FIXED_IO_ps_srstb, Frame_done, Frame_done1, Mode, Mode1, Pod, Pod1, clk_10M, clk_10M1, ipor, ipor1, 
  mdd, mdd1, ocompclk, ocompclk1, oisadc, oisadc1, pl_clk, sensor_out)
/* synthesis syn_black_box black_box_pad_pin="Cstart,Cstart1,DDR_addr[14:0],DDR_ba[2:0],DDR_cas_n,DDR_ck_n,DDR_ck_p,DDR_cke,DDR_cs_n,DDR_dm[3:0],DDR_dq[31:0],DDR_dqs_n[3:0],DDR_dqs_p[3:0],DDR_odt,DDR_ras_n,DDR_reset_n,DDR_we_n,Enb,Enb1,Expo_Ctrl,Expo_Ctrl1,Expo_start,Expo_start1,FIXED_IO_ddr_vrn,FIXED_IO_ddr_vrp,FIXED_IO_mio[53:0],FIXED_IO_ps_clk,FIXED_IO_ps_porb,FIXED_IO_ps_srstb,Frame_done,Frame_done1,Mode[1:0],Mode1[1:0],Pod[15:0],Pod1[15:0],clk_10M,clk_10M1,ipor,ipor1,mdd,mdd1,ocompclk,ocompclk1,oisadc,oisadc1,pl_clk,sensor_out[3:0]" */;
  output Cstart;
  output Cstart1;
  inout [14:0]DDR_addr;
  inout [2:0]DDR_ba;
  inout DDR_cas_n;
  inout DDR_ck_n;
  inout DDR_ck_p;
  inout DDR_cke;
  inout DDR_cs_n;
  inout [3:0]DDR_dm;
  inout [31:0]DDR_dq;
  inout [3:0]DDR_dqs_n;
  inout [3:0]DDR_dqs_p;
  inout DDR_odt;
  inout DDR_ras_n;
  inout DDR_reset_n;
  inout DDR_we_n;
  output Enb;
  output Enb1;
  output Expo_Ctrl;
  output Expo_Ctrl1;
  output Expo_start;
  output Expo_start1;
  inout FIXED_IO_ddr_vrn;
  inout FIXED_IO_ddr_vrp;
  inout [53:0]FIXED_IO_mio;
  inout FIXED_IO_ps_clk;
  inout FIXED_IO_ps_porb;
  inout FIXED_IO_ps_srstb;
  output Frame_done;
  output Frame_done1;
  output [1:0]Mode;
  output [1:0]Mode1;
  input [15:0]Pod;
  output [15:0]Pod1;
  output clk_10M;
  output clk_10M1;
  output ipor;
  output ipor1;
  output mdd;
  output mdd1;
  input ocompclk;
  output ocompclk1;
  input oisadc;
  output oisadc1;
  input pl_clk;
  input [3:0]sensor_out;
endmodule
