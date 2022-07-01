
`timescale 1 ns / 1 ps

	module image_ctl_v1_0 #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Slave Bus Interface S00_AXI
		parameter integer C_S00_AXI_DATA_WIDTH	= 32,
		parameter integer C_S00_AXI_ADDR_WIDTH	= 7
	)
	(
		// Users to add ports here

		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Slave Bus Interface S00_AXI
		input wire  s00_axi_aclk,
		input wire  s00_axi_aresetn,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_awaddr,
		input wire [2 : 0] s00_axi_awprot,
		input wire  s00_axi_awvalid,
		output wire  s00_axi_awready,
		input wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata,
		input wire [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s00_axi_wstrb,
		input wire  s00_axi_wvalid,
		output wire  s00_axi_wready,
		output wire [1 : 0] s00_axi_bresp,
		output wire  s00_axi_bvalid,
		input wire  s00_axi_bready,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_araddr,
		input wire [2 : 0] s00_axi_arprot,
		input wire  s00_axi_arvalid,
		output wire  s00_axi_arready,
		output wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_rdata,
		output wire [1 : 0] s00_axi_rresp,
		output wire  s00_axi_rvalid,
		input wire  s00_axi_rready,

		//User ports
		input wire iclk,
		input wire ocompclk,
		input wire oisadc,
		input wire [15:0] Sensor_Pod,
		input wire [3:0] Sensor_Out,
	
		output wire Frame_done,
		output wire Expo_start,
		output wire ipor,
		output wire ipor_r,
		output wire Cstart,
		output wire Cstart_r,
		output wire [1:0] Mode,
		output wire [1:0] Mode_r,
		output wire mdd,
		output wire mdd_r,
		output wire Expo_Ctrl,
		output wire Expo_Ctrl_r,
		output wire Enb,
		output wire Enb_r
	);
// Instantiation of Axi Bus Interface S00_AXI
	image_ctl_v1_0_S00_AXI # ( 
		.C_S_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH)
	) image_ctl_v1_0_S00_AXI_inst (
		.S_AXI_ACLK(s00_axi_aclk),
		.S_AXI_ARESETN(s00_axi_aresetn),
		.S_AXI_AWADDR(s00_axi_awaddr),
		.S_AXI_AWPROT(s00_axi_awprot),
		.S_AXI_AWVALID(s00_axi_awvalid),
		.S_AXI_AWREADY(s00_axi_awready),
		.S_AXI_WDATA(s00_axi_wdata),
		.S_AXI_WSTRB(s00_axi_wstrb),
		.S_AXI_WVALID(s00_axi_wvalid),
		.S_AXI_WREADY(s00_axi_wready),
		.S_AXI_BRESP(s00_axi_bresp),
		.S_AXI_BVALID(s00_axi_bvalid),
		.S_AXI_BREADY(s00_axi_bready),
		.S_AXI_ARADDR(s00_axi_araddr),
		.S_AXI_ARPROT(s00_axi_arprot),
		.S_AXI_ARVALID(s00_axi_arvalid),
		.S_AXI_ARREADY(s00_axi_arready),
		.S_AXI_RDATA(s00_axi_rdata),
		.S_AXI_RRESP(s00_axi_rresp),
		.S_AXI_RVALID(s00_axi_rvalid),
		.S_AXI_RREADY(s00_axi_rready),

		.iclk		(iclk		),//Sensor clk, 10Mhz
		.ocompclk	(ocompclk	),
		.oisadc		(oisadc		),
		.Pod			(Sensor_Pod		),
		.Out			(Sensor_Out		),
	//iclk_r(iclk_r),
	
		.Frame_done	(Frame_done),
		.Expo_start	(Expo_start),
		.ipor		(ipor),
		.ipor_r(ipor_r),
		.Cstart(Cstart),
		.Cstart_r(Cstart_r),
		.Mode(Mode),
		.Mode_r(Mode_r),
		.mdd(mdd),
		.mdd_r(mdd_r),
		.Expo_Ctrl(Expo_Ctrl),
		.Expo_Ctrl_r(Expo_Ctrl_r),
		.Enb(Enb),
		.Enb_r(Enb_r)
	);

	// Add user logic here

	// User logic ends

	endmodule
