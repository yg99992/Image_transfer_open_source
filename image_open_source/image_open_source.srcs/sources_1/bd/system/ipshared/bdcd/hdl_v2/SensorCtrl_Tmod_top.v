module SensorCtrl_Tmod_top(
	sys_clk,  // AXI clock, high speed
	
	Rst_n,
	start_up,
	test_mod,   // 1: test mode
	
	switch0,
	switch1,
	switch2,
	switch3,
	switch4,
	switch5,
	
	Expo_T_SW,	//æ›?å…‰æ—¶é—´
	//Time_Framedone_Cstart, //é—´éš”æ—¶é—´T = Time_Framedone_Cstart*100ns,æœ?å¤§ä¸Šé™?æ˜¯131053ï¼Œå?³çº?13ms
	Expo_T_SW_out,
	
	iclk,  //Sensor clk, 10Mhz
	ocompclk_chip,
	oisadc_chip,
	Pod_chip,
	Out_chip,
	
	Frame_done,
	Expo_start,
	iclk_r,
	ipor,
	ipor_r,
	Cstart,
	Cstart_r,
	Mode,
	Mode_r,
	mdd,
	mdd_r,
	Expo_Ctrl,
	Expo_Ctrl_r,
	Enb,
	Enb_r,
	
	ocompclk_r,
	oisadc_r,
	Pod_r,
	Out_r,


	word1,
	word2,
	word3,
	word4,
	En_Data_Pod,
	
	out_word1, 
	out_word2, 
	out_word3, 
	out_word4, 
	out_word5, 
	out_word6, 
	out_word7, 
	out_word8,
	En_Data_Out,
	En_Data_Out_O,
	
	out_pod_w1, 
	out_pod_w2, 
	out_pod_w3, 
	out_pod_w4, 
	out_pod_w5, 
	out_pod_w6, 
	out_pod_w7, 
	out_pod_w8,
	En_out_Pod
);

	input sys_clk;  // AXI clock
	(*mark_debug="true"*) input iclk;  //10Mhz
	input test_mod;
	
	(*mark_debug="true"*) input Rst_n;
	(*mark_debug="true"*) input start_up;
	
	
	input switch0;//Mode(0),default = 0
	input switch1;//Mode(1),default = 0
	input switch2;//mdd,default = 0
	input switch3;//Enb,default = 1
	input switch4;
	input switch5;
	
	input [9:0] Expo_T_SW;// Exposure time adjustment from 1ms to 1024ms;
	//input [16:0] Time_Framedone_Cstart; //The delay time from 'Framedone' to "Cstart" pluse, max is 131053.
	input [9:0] Expo_T_SW_out;// Exposure time adjustment from 1ms to 1024ms for motion mode;
	
	(*mark_debug="true"*) input ocompclk_chip;
	(*mark_debug="true"*) input oisadc_chip;
	input [15:0] Pod_chip;
	input [3:0] Out_chip;
	
	
	output Frame_done;
	(*mark_debug="true"*) output Expo_start;
	output iclk_r;
	(*mark_debug="true"*) output ipor;
	output ipor_r;
	(*mark_debug="true"*) output Cstart;
	output Cstart_r;
	output [1:0] Mode;
	output [1:0] Mode_r;
	output mdd;
	output mdd_r;
	(*mark_debug="true"*) output Expo_Ctrl;
	output Expo_Ctrl_r;
	output Enb;
	output Enb_r;
	
	output ocompclk_r;
	output oisadc_r;
	output [15:0] Pod_r;
	output [3:0] Out_r;
	
	output En_Data_Pod;
	output [31 : 0] word1, word2, word3, word4;
	
	output En_Data_Out;
	output En_Data_Out_O;
	output [31 : 0] out_word1, out_word2, out_word3, out_word4, out_word5, out_word6, out_word7, out_word8;
	
	output [31 : 0] out_pod_w1, out_pod_w2, out_pod_w3, out_pod_w4, out_pod_w5, out_pod_w6, out_pod_w7, out_pod_w8;
	output En_out_Pod;
	
	wire Clk_50M = sys_clk;
	
	wire ocompclk;
	wire oisadc;
	wire [15:0] Pod;
	wire [3:0] Out;
	
	
	wire [62:0] OutR;
	wire [62:0] OutL;
	wire [63:0] OutU;
	wire [63:0] OutD;
	
    reg [62:0] OutR_r;
    reg [62:0] OutL_r;
    reg [63:0] OutU_r;
    reg [63:0] OutD_r;
    reg En_Data_Out_r;
    reg En_Data_Out_O_r;
    
    wire En_Data_Out_w;
    wire En_Data_Out_O_w;
	
	wire [11:0] Z;
	
	wire ocompclk_in 	= test_mod ? ocompclk : ocompclk_chip;
	wire oisadc_in		= test_mod ? oisadc	  : oisadc_chip;
	wire [15:0] Pod_in	= test_mod ? Pod	  : Pod_chip;
	wire [3:0] Out_in	= test_mod ? Out	  : Out_chip;
	
	wire [15:0] Out_Pod0_M0;
	wire [15:0] Out_Pod1_M0;
	wire [15:0] Out_Pod2_M0;
	wire [15:0] Out_Pod3_M0;
	wire [15:0] Out_Pod4_M0;
    wire [15:0] Out_Pod5_M0;
    wire [15:0] Out_Pod6_M0;
    wire [15:0] Out_Pod7_M0;
    wire [15:0] Out_Pod8_M0;
    wire [15:0] Out_Pod9_M0;
    wire [15:0] Out_Pod10_M0;
    wire [15:0] Out_Pod11_M0;	
    wire [15:0] Out_Pod12_M0;
    wire [15:0] Out_Pod13_M0;
    wire [15:0] Out_Pod14_M0;
    wire [15:0] Out_Pod15_M0;
			

    assign 	En_Data_Out = En_Data_Out_r;
    assign 	En_Data_Out_O = En_Data_Out_r;
    
    
    assign  En_out_Pod  = En_Data_Out_r;
    assign  En_Data_Pod = En_Data_Out_r;
	
	
	OP_model_LSFR OP_model1(
	.Clk(iclk),
    .rst_n(Rst_n),
	.Compclk(ocompclk),
	.word1(word1),
    .word2(word2),
    .word3(word3),
    .word4(word4)
	);
	

	always@(posedge iclk or negedge Rst_n)begin
	   if(!Rst_n) begin
           OutR_r       <= 'd0;
           OutL_r       <= 'd0;
           OutU_r       <= 'd0;
           OutD_r       <= 'd0;
           En_Data_Out_r<= 'd0;
	   end
	   else begin
          En_Data_Out_r     <= !En_Data_Out_r;
	   end
	end
	
endmodule



