//Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
//Date        : Thu Jun  2 22:20:21 2022
//Host        : ww_cyxu running 64-bit major release  (build 9200)
//Command     : generate_target system_wrapper.bd
//Design      : system_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module system_wrapper
   (Cstart,
    Cstart1,
    DDR_addr,
    DDR_ba,
    DDR_cas_n,
    DDR_ck_n,
    DDR_ck_p,
    DDR_cke,
    DDR_cs_n,
    DDR_dm,
    DDR_dq,
    DDR_dqs_n,
    DDR_dqs_p,
    DDR_odt,
    DDR_ras_n,
    DDR_reset_n,
    DDR_we_n,
    Enb,
    Enb1,
    Expo_Ctrl,
    Expo_Ctrl1,
    Expo_start,
    Expo_start1,
    FIXED_IO_ddr_vrn,
    FIXED_IO_ddr_vrp,
    FIXED_IO_mio,
    FIXED_IO_ps_clk,
    FIXED_IO_ps_porb,
    FIXED_IO_ps_srstb,
    Frame_done,
    Frame_done1,
    Mode,
    Mode1,
    Pod,
    Pod1,
    clk_10M,
    clk_10M1,
    ipor,
    ipor1,
    mdd,
    mdd1,
    ocompclk,
    ocompclk1,
    oisadc,
    oisadc1,
    pl_clk,
    sensor_out);
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

  wire Cstart;
  wire Cstart1;
  wire [14:0]DDR_addr;
  wire [2:0]DDR_ba;
  wire DDR_cas_n;
  wire DDR_ck_n;
  wire DDR_ck_p;
  wire DDR_cke;
  wire DDR_cs_n;
  wire [3:0]DDR_dm;
  wire [31:0]DDR_dq;
  wire [3:0]DDR_dqs_n;
  wire [3:0]DDR_dqs_p;
  wire DDR_odt;
  wire DDR_ras_n;
  wire DDR_reset_n;
  wire DDR_we_n;
  wire Enb;
  wire Enb1;
  wire Expo_Ctrl;
  wire Expo_Ctrl1;
  wire Expo_start;
  wire Expo_start1;
  wire FIXED_IO_ddr_vrn;
  wire FIXED_IO_ddr_vrp;
  wire [53:0]FIXED_IO_mio;
  wire FIXED_IO_ps_clk;
  wire FIXED_IO_ps_porb;
  wire FIXED_IO_ps_srstb;
  wire Frame_done;
  wire Frame_done1;
  wire [1:0]Mode;
  wire [1:0]Mode1;
  wire [15:0]Pod;
  wire [15:0]Pod1;
  wire clk_10M;
  wire clk_10M1;
  wire ipor;
  wire ipor1;
  wire mdd;
  wire mdd1;
  wire ocompclk;
  wire ocompclk1;
  wire oisadc;
  wire oisadc1;
  wire pl_clk;
  wire [3:0]sensor_out;

  system system_i
       (.Cstart(Cstart),
        .Cstart1(Cstart1),
        .DDR_addr(DDR_addr),
        .DDR_ba(DDR_ba),
        .DDR_cas_n(DDR_cas_n),
        .DDR_ck_n(DDR_ck_n),
        .DDR_ck_p(DDR_ck_p),
        .DDR_cke(DDR_cke),
        .DDR_cs_n(DDR_cs_n),
        .DDR_dm(DDR_dm),
        .DDR_dq(DDR_dq),
        .DDR_dqs_n(DDR_dqs_n),
        .DDR_dqs_p(DDR_dqs_p),
        .DDR_odt(DDR_odt),
        .DDR_ras_n(DDR_ras_n),
        .DDR_reset_n(DDR_reset_n),
        .DDR_we_n(DDR_we_n),
        .Enb(Enb),
        .Enb1(Enb1),
        .Expo_Ctrl(Expo_Ctrl),
        .Expo_Ctrl1(Expo_Ctrl1),
        .Expo_start(Expo_start),
        .Expo_start1(Expo_start1),
        .FIXED_IO_ddr_vrn(FIXED_IO_ddr_vrn),
        .FIXED_IO_ddr_vrp(FIXED_IO_ddr_vrp),
        .FIXED_IO_mio(FIXED_IO_mio),
        .FIXED_IO_ps_clk(FIXED_IO_ps_clk),
        .FIXED_IO_ps_porb(FIXED_IO_ps_porb),
        .FIXED_IO_ps_srstb(FIXED_IO_ps_srstb),
        .Frame_done(Frame_done),
        .Frame_done1(Frame_done1),
        .Mode(Mode),
        .Mode1(Mode1),
        .Pod(Pod),
        .Pod1(Pod1),
        .clk_10M(clk_10M),
        .clk_10M1(clk_10M1),
        .ipor(ipor),
        .ipor1(ipor1),
        .mdd(mdd),
        .mdd1(mdd1),
        .ocompclk(ocompclk),
        .ocompclk1(ocompclk1),
        .oisadc(oisadc),
        .oisadc1(oisadc1),
        .pl_clk(pl_clk),
        .sensor_out(sensor_out));
endmodule
