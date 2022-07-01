-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
-- Date        : Thu Jun  2 22:21:48 2022
-- Host        : ww_cyxu running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               C:/01_FPGA_project/Image_sensor/Image_transfer_open_source/project_1_7_9/project_1.srcs/sources_1/bd/system/system_stub.vhdl
-- Design      : system
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg400-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity system is
  Port ( 
    Cstart : out STD_LOGIC;
    Cstart1 : out STD_LOGIC;
    DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_cas_n : inout STD_LOGIC;
    DDR_ck_n : inout STD_LOGIC;
    DDR_ck_p : inout STD_LOGIC;
    DDR_cke : inout STD_LOGIC;
    DDR_cs_n : inout STD_LOGIC;
    DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_odt : inout STD_LOGIC;
    DDR_ras_n : inout STD_LOGIC;
    DDR_reset_n : inout STD_LOGIC;
    DDR_we_n : inout STD_LOGIC;
    Enb : out STD_LOGIC;
    Enb1 : out STD_LOGIC;
    Expo_Ctrl : out STD_LOGIC;
    Expo_Ctrl1 : out STD_LOGIC;
    Expo_start : out STD_LOGIC;
    Expo_start1 : out STD_LOGIC;
    FIXED_IO_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ps_clk : inout STD_LOGIC;
    FIXED_IO_ps_porb : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
    Frame_done : out STD_LOGIC;
    Frame_done1 : out STD_LOGIC;
    Mode : out STD_LOGIC_VECTOR ( 1 downto 0 );
    Mode1 : out STD_LOGIC_VECTOR ( 1 downto 0 );
    Pod : in STD_LOGIC_VECTOR ( 15 downto 0 );
    Pod1 : out STD_LOGIC_VECTOR ( 15 downto 0 );
    clk_10M : out STD_LOGIC;
    clk_10M1 : out STD_LOGIC;
    ipor : out STD_LOGIC;
    ipor1 : out STD_LOGIC;
    mdd : out STD_LOGIC;
    mdd1 : out STD_LOGIC;
    ocompclk : in STD_LOGIC;
    ocompclk1 : out STD_LOGIC;
    oisadc : in STD_LOGIC;
    oisadc1 : out STD_LOGIC;
    pl_clk : in STD_LOGIC;
    sensor_out : in STD_LOGIC_VECTOR ( 3 downto 0 )
  );

end system;

architecture stub of system is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "Cstart,Cstart1,DDR_addr[14:0],DDR_ba[2:0],DDR_cas_n,DDR_ck_n,DDR_ck_p,DDR_cke,DDR_cs_n,DDR_dm[3:0],DDR_dq[31:0],DDR_dqs_n[3:0],DDR_dqs_p[3:0],DDR_odt,DDR_ras_n,DDR_reset_n,DDR_we_n,Enb,Enb1,Expo_Ctrl,Expo_Ctrl1,Expo_start,Expo_start1,FIXED_IO_ddr_vrn,FIXED_IO_ddr_vrp,FIXED_IO_mio[53:0],FIXED_IO_ps_clk,FIXED_IO_ps_porb,FIXED_IO_ps_srstb,Frame_done,Frame_done1,Mode[1:0],Mode1[1:0],Pod[15:0],Pod1[15:0],clk_10M,clk_10M1,ipor,ipor1,mdd,mdd1,ocompclk,ocompclk1,oisadc,oisadc1,pl_clk,sensor_out[3:0]";
begin
end;
