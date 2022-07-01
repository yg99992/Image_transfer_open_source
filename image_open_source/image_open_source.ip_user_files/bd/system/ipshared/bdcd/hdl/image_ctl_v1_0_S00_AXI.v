
`timescale 1 ns / 1 ps

	module image_ctl_v1_0_S00_AXI #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line

		// Width of S_AXI data bus
		parameter integer C_S_AXI_DATA_WIDTH	= 32,
		// Width of S_AXI address bus
		parameter integer C_S_AXI_ADDR_WIDTH	= 7
	)
	(
		// Users to add ports here

		// User ports ends
		// Do not modify the ports beyond this line

		// Global Clock Signal
		(*mark_debug="true"*) input wire  S_AXI_ACLK,
		// Global Reset Signal. This Signal is Active LOW
		input wire  S_AXI_ARESETN,
		// Write address (issued by master, acceped by Slave)
		(*mark_debug="true"*) input wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_AWADDR,
		// Write channel Protection type. This signal indicates the
    		// privilege and security level of the transaction, and whether
    		// the transaction is a data access or an instruction access.
		input wire [2 : 0] S_AXI_AWPROT,
		// Write address valid. This signal indicates that the master signaling
    		// valid write address and control information.
		input wire  S_AXI_AWVALID,
		// Write address ready. This signal indicates that the slave is ready
    		// to accept an address and associated control signals.
		output wire  S_AXI_AWREADY,
		// Write data (issued by master, acceped by Slave) 
		(*mark_debug="true"*) input wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_WDATA,
		// Write strobes. This signal indicates which byte lanes hold
    		// valid data. There is one write strobe bit for each eight
    		// bits of the write data bus.    
		input wire [(C_S_AXI_DATA_WIDTH/8)-1 : 0] S_AXI_WSTRB,
		// Write valid. This signal indicates that valid write
    		// data and strobes are available.
		input wire  S_AXI_WVALID,
		// Write ready. This signal indicates that the slave
    		// can accept the write data.
		output wire  S_AXI_WREADY,
		// Write response. This signal indicates the status
    		// of the write transaction.
		output wire [1 : 0] S_AXI_BRESP,
		// Write response valid. This signal indicates that the channel
    		// is signaling a valid write response.
		output wire  S_AXI_BVALID,
		// Response ready. This signal indicates that the master
    		// can accept a write response.
		input wire  S_AXI_BREADY,
		// Read address (issued by master, acceped by Slave)
		(*mark_debug="true"*) input wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_ARADDR,
		// Protection type. This signal indicates the privilege
    		// and security level of the transaction, and whether the
    		// transaction is a data access or an instruction access.
		input wire [2 : 0] S_AXI_ARPROT,
		// Read address valid. This signal indicates that the channel
    		// is signaling valid read address and control information.
		input wire  S_AXI_ARVALID,
		// Read address ready. This signal indicates that the slave is
    		// ready to accept an address and associated control signals.
		output wire  S_AXI_ARREADY,
		// Read data (issued by slave)
		(*mark_debug="true"*) output wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_RDATA,
		// Read response. This signal indicates the status of the
    		// read transfer.
		output wire [1 : 0] S_AXI_RRESP,
		// Read valid. This signal indicates that the channel is
    		// signaling the required read data.
		output wire  S_AXI_RVALID,
		// Read ready. This signal indicates that the master can
    		// accept the read data and response information.
		input wire  S_AXI_RREADY,

		//User ports
		input wire iclk,
		input wire ocompclk,
		input wire oisadc,
		input wire [15:0] Pod,
		input wire [3:0] Out,
	
		(*mark_debug="true"*) output wire Frame_done,
		output wire Expo_start,
		output wire ipor,
		output wire ipor_r,
		(*mark_debug="true"*) output wire Cstart,
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

	// AXI4LITE signals
	reg [C_S_AXI_ADDR_WIDTH-1 : 0] 	axi_awaddr;
	reg  	axi_awready;
	reg  	axi_wready;
	reg [1 : 0] 	axi_bresp;
	reg  	axi_bvalid;
	reg [C_S_AXI_ADDR_WIDTH-1 : 0] 	axi_araddr;
	reg  	axi_arready;
	reg [C_S_AXI_DATA_WIDTH-1 : 0] 	axi_rdata;
	reg [1 : 0] 	axi_rresp;
	reg  	axi_rvalid;

	// Example-specific design signals
	// local parameter for addressing 32 bit / 64 bit C_S_AXI_DATA_WIDTH
	// ADDR_LSB is used for addressing 32/64 bit registers/memories
	// ADDR_LSB = 2 for 32 bits (n downto 2)
	// ADDR_LSB = 3 for 64 bits (n downto 3)
	localparam integer ADDR_LSB = (C_S_AXI_DATA_WIDTH/32) + 1;
	localparam integer OPT_MEM_ADDR_BITS = 4;
	//----------------------------------------------
	//-- Signals for user logic register space example
	//------------------------------------------------
	//-- Number of Slave Registers 20
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg0;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg1;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg2;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg3;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg4;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg5;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg6;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg7;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg8;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg9;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg10;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg11;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg12;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg13;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg14;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg15;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg16;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg17;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg18;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg19;
	wire	 slv_reg_rden;
	wire	 slv_reg_wren;
	reg [C_S_AXI_DATA_WIDTH-1:0]	 reg_data_out;
	integer	 byte_index;
	reg	 aw_en;

	//User registers and wires
	(*mark_debug="true"*)wire word_en;
	(*mark_debug="true"*)wire [31 : 0] word1, word2, word3, word4;
	(*mark_debug="true"*)reg software_flag; // data flag, software read this data to sure if the data is ready
	reg word_en_d1, word_en_d2;
	wire word_en_pos = ({word_en_d2, word_en_d1} == 2'b01);
	
    
	reg frame_done_d1, frame_done_d2;
	(*mark_debug="true"*)reg software_frame_done;
	wire frame_done_pos = ((!frame_done_d2) & frame_done_d1);
	
	reg Cstart_d1, Cstart_d2;
	(*mark_debug="true"*)reg software_Cstart;
	wire Cstart_pos = ((!Cstart_d2) & Cstart_d1);
	
    (*mark_debug="true"*)wire En_Data_Out;
    (*mark_debug="true"*)wire En_Data_Out_O;
    (*mark_debug="true"*)wire [31 : 0] out_word1, out_word2, out_word3, out_word4, out_word5, out_word6, out_word7, out_word8;
    (*mark_debug="true"*)reg software_En_Data_Out;
    (*mark_debug="true"*)reg software_En_Data_Out_O;
    reg En_Data_Out_d1, En_Data_Out_d2;
    reg En_Data_Out_O_d1, En_Data_Out_O_d2;
    wire En_Data_Out_pos   = ({En_Data_Out_d2,   En_Data_Out_d1}   == 2'b01);
    wire En_Data_Out_O_pos = ({En_Data_Out_O_d2, En_Data_Out_O_d1} == 2'b01);
    
    (*mark_debug="true"*)wire [31 : 0] out_pod_w1, out_pod_w2, out_pod_w3, out_pod_w4, out_pod_w5, out_pod_w6, out_pod_w7, out_pod_w8;
    (*mark_debug="true"*)wire En_out_Pod;
    (*mark_debug="true"*)reg software_En_out_Pod;
    reg En_out_Pod_d1, En_out_Pod_d2;
    wire En_out_Pod_pos = ((!En_out_Pod_d2) & En_out_Pod_d1);
    
    
	//reading data could clear the flag signal
	//wire software_flag_clear     = slv_reg_rden & ( | axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB+2] );
	wire software_flag_clear       = slv_reg_rden & ( axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == 5'h04 );

    wire software_frame_done_clear = slv_reg_rden & ( axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == 5'h08 );
                     
    wire software_Cstart_clear     = slv_reg_rden & ( axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == 5'h09 );
                     
    wire software_En_Data_clear    = slv_reg_rden & ( axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == 5'h0A ); 
    
    wire software_En_out_Pod_clear = slv_reg_rden & ( axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == 5'h13 );
	// I/O Connections assignments

	assign S_AXI_AWREADY	= axi_awready;
	assign S_AXI_WREADY	= axi_wready;
	assign S_AXI_BRESP	= axi_bresp;
	assign S_AXI_BVALID	= axi_bvalid;
	assign S_AXI_ARREADY	= axi_arready;
	assign S_AXI_RDATA	= axi_rdata;
	assign S_AXI_RRESP	= axi_rresp;
	assign S_AXI_RVALID	= axi_rvalid;
	// Implement axi_awready generation
	// axi_awready is asserted for one S_AXI_ACLK clock cycle when both
	// S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_awready is
	// de-asserted when reset is low.

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_awready <= 1'b0;
	      aw_en <= 1'b1;
	    end 
	  else
	    begin    
	      if (~axi_awready && S_AXI_AWVALID && S_AXI_WVALID && aw_en)
	        begin
	          // slave is ready to accept write address when 
	          // there is a valid write address and write data
	          // on the write address and data bus. This design 
	          // expects no outstanding transactions. 
	          axi_awready <= 1'b1;
	          aw_en <= 1'b0;
	        end
	        else if (S_AXI_BREADY && axi_bvalid)
	            begin
	              aw_en <= 1'b1;
	              axi_awready <= 1'b0;
	            end
	      else           
	        begin
	          axi_awready <= 1'b0;
	        end
	    end 
	end       

	// Implement axi_awaddr latching
	// This process is used to latch the address when both 
	// S_AXI_AWVALID and S_AXI_WVALID are valid. 

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_awaddr <= 0;
	    end 
	  else
	    begin    
	      if (~axi_awready && S_AXI_AWVALID && S_AXI_WVALID && aw_en)
	        begin
	          // Write Address latching 
	          axi_awaddr <= S_AXI_AWADDR;
	        end
	    end 
	end       

	// Implement axi_wready generation
	// axi_wready is asserted for one S_AXI_ACLK clock cycle when both
	// S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_wready is 
	// de-asserted when reset is low. 

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_wready <= 1'b0;
	    end 
	  else
	    begin    
	      if (~axi_wready && S_AXI_WVALID && S_AXI_AWVALID && aw_en )
	        begin
	          // slave is ready to accept write data when 
	          // there is a valid write address and write data
	          // on the write address and data bus. This design 
	          // expects no outstanding transactions. 
	          axi_wready <= 1'b1;
	        end
	      else
	        begin
	          axi_wready <= 1'b0;
	        end
	    end 
	end       

	// Implement memory mapped register select and write logic generation
	// The write data is accepted and written to memory mapped registers when
	// axi_awready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted. Write strobes are used to
	// select byte enables of slave registers while writing.
	// These registers are cleared when reset (active low) is applied.
	// Slave register write enable is asserted when valid address and data are available
	// and the slave is ready to accept the write address and write data.
	assign slv_reg_wren = axi_wready && S_AXI_WVALID && axi_awready && S_AXI_AWVALID;

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      slv_reg0 <= 0;
	      slv_reg1 <= 0;
	      slv_reg2 <= 0;
	      slv_reg3 <= 0;
	      slv_reg4 <= 0;
	      slv_reg5 <= 0;
	      slv_reg6 <= 0;
	      slv_reg7 <= 0;
	      slv_reg8 <= 0;
	      slv_reg9 <= 0;
	      slv_reg10 <= 0;
	      slv_reg11 <= 0;
	      slv_reg12 <= 0;
	      slv_reg13 <= 0;
	      slv_reg14 <= 0;
	      slv_reg15 <= 0;
	      slv_reg16 <= 0;
	      slv_reg17 <= 0;
	      slv_reg18 <= 0;
	      slv_reg19 <= 0;
	    end 
	  else begin
	    if (slv_reg_wren)
	      begin
	        case ( axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] )
	          5'h00:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 0
	                slv_reg0[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h01:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 1
	                slv_reg1[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h02:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 2
	                slv_reg2[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h03:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 3
	                slv_reg3[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h04:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 4
	                slv_reg4[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h05:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 5
	                slv_reg5[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h06:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 6
	                slv_reg6[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h07:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 7
	                slv_reg7[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h08:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 8
	                slv_reg8[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h09:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 9
	                slv_reg9[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h0A:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 10
	                slv_reg10[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h0B:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 11
	                slv_reg11[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h0C:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 12
	                slv_reg12[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h0D:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 13
	                slv_reg13[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h0E:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 14
	                slv_reg14[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h0F:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 15
	                slv_reg15[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h10:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 16
	                slv_reg16[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h11:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 17
	                slv_reg17[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h12:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 18
	                slv_reg18[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h13:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 19
	                slv_reg19[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          default : begin
	                      slv_reg0 <= slv_reg0;
	                      slv_reg1 <= slv_reg1;
	                      slv_reg2 <= slv_reg2;
	                      slv_reg3 <= slv_reg3;
	                      slv_reg4 <= slv_reg4;
	                      slv_reg5 <= slv_reg5;
	                      slv_reg6 <= slv_reg6;
	                      slv_reg7 <= slv_reg7;
	                      slv_reg8 <= slv_reg8;
	                      slv_reg9 <= slv_reg9;
	                      slv_reg10 <= slv_reg10;
	                      slv_reg11 <= slv_reg11;
	                      slv_reg12 <= slv_reg12;
	                      slv_reg13 <= slv_reg13;
	                      slv_reg14 <= slv_reg14;
	                      slv_reg15 <= slv_reg15;
	                      slv_reg16 <= slv_reg16;
	                      slv_reg17 <= slv_reg17;
	                      slv_reg18 <= slv_reg18;
	                      slv_reg19 <= slv_reg19;
	                    end
	        endcase
	      end
	  end
	end    

	// Implement write response logic generation
	// The write response and response valid signals are asserted by the slave 
	// when axi_wready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted.  
	// This marks the acceptance of address and indicates the status of 
	// write transaction.

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_bvalid  <= 0;
	      axi_bresp   <= 2'b0;
	    end 
	  else
	    begin    
	      if (axi_awready && S_AXI_AWVALID && ~axi_bvalid && axi_wready && S_AXI_WVALID)
	        begin
	          // indicates a valid write response is available
	          axi_bvalid <= 1'b1;
	          axi_bresp  <= 2'b0; // 'OKAY' response 
	        end                   // work error responses in future
	      else
	        begin
	          if (S_AXI_BREADY && axi_bvalid) 
	            //check if bready is asserted while bvalid is high) 
	            //(there is a possibility that bready is always asserted high)   
	            begin
	              axi_bvalid <= 1'b0; 
	            end  
	        end
	    end
	end   

	// Implement axi_arready generation
	// axi_arready is asserted for one S_AXI_ACLK clock cycle when
	// S_AXI_ARVALID is asserted. axi_awready is 
	// de-asserted when reset (active low) is asserted. 
	// The read address is also latched when S_AXI_ARVALID is 
	// asserted. axi_araddr is reset to zero on reset assertion.

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_arready <= 1'b0;
	      axi_araddr  <= 32'b0;
	    end 
	  else
	    begin    
	      if (~axi_arready && S_AXI_ARVALID)
	        begin
	          // indicates that the slave has acceped the valid read address
	          axi_arready <= 1'b1;
	          // Read address latching
	          axi_araddr  <= S_AXI_ARADDR;
	        end
	      else
	        begin
	          axi_arready <= 1'b0;
	        end
	    end 
	end       

	// Implement axi_arvalid generation
	// axi_rvalid is asserted for one S_AXI_ACLK clock cycle when both 
	// S_AXI_ARVALID and axi_arready are asserted. The slave registers 
	// data are available on the axi_rdata bus at this instance. The 
	// assertion of axi_rvalid marks the validity of read data on the 
	// bus and axi_rresp indicates the status of read transaction.axi_rvalid 
	// is deasserted on reset (active low). axi_rresp and axi_rdata are 
	// cleared to zero on reset (active low).  
	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_rvalid <= 0;
	      axi_rresp  <= 0;
	    end 
	  else
	    begin    
	      if (axi_arready && S_AXI_ARVALID && ~axi_rvalid)
	        begin
	          // Valid read data is available at the read data bus
	          axi_rvalid <= 1'b1;
	          axi_rresp  <= 2'b0; // 'OKAY' response
	        end   
	      else if (axi_rvalid && S_AXI_RREADY)
	        begin
	          // Read data is accepted by the master
	          axi_rvalid <= 1'b0;
	        end                
	    end
	end    

	// Implement memory mapped register select and read logic generation
	// Slave register read enable is asserted when valid address is available
	// and the slave is ready to accept the read address.
	assign slv_reg_rden = axi_arready & S_AXI_ARVALID & ~axi_rvalid;
	always @(*)
	begin
	      // Address decoding for reading registers
	      case ( axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] )
	        5'h00   : reg_data_out <= {15'b0, software_flag, slv_reg0[15:0]};  // control
	        5'h01   : reg_data_out <= slv_reg1;  // Expose time
	        5'h02   : reg_data_out <= slv_reg2;  // Delay from frame_down to Cstart
	        5'h03   : reg_data_out <= slv_reg3;  // reserve
	        5'h04   : reg_data_out <= word1;     // data {pod3,  pod2,  pod1,  pod0}
	        5'h05   : reg_data_out <= word2;     // data {pod7,  pod6,  pod5,  pod4} 
	        5'h06   : reg_data_out <= word3;     // data {pod11, pod10, pod9,  pod8}
	        5'h07   : reg_data_out <= word4;     // data {pod15, pod14, pod13, pod12}
	        5'h08   : reg_data_out <= {31'b0, software_frame_done};
	        5'h09   : reg_data_out <= {31'b0, software_Cstart};
	        5'h0A   : reg_data_out <= out_word1;
	        5'h0B   : reg_data_out <= out_word2;
	        5'h0C   : reg_data_out <= out_word3;
	        5'h0D   : reg_data_out <= out_word4;
	        5'h0E   : reg_data_out <= out_word5;
	        5'h0F   : reg_data_out <= out_word6;
	        5'h10   : reg_data_out <= out_word7;
	        5'h11   : reg_data_out <= out_word8;
	        5'h12   : reg_data_out <= {29'b0,software_En_out_Pod, software_En_Data_Out, software_En_Data_Out_O};
	        5'h13   : reg_data_out <= out_pod_w1;
            5'h14   : reg_data_out <= out_pod_w2;
            5'h15   : reg_data_out <= out_pod_w3;
            5'h16   : reg_data_out <= out_pod_w4;
            5'h17   : reg_data_out <= out_pod_w5;
            5'h18   : reg_data_out <= out_pod_w6;
            5'h19   : reg_data_out <= out_pod_w7;
            5'h1A   : reg_data_out <= out_pod_w8;
	        default : reg_data_out <= 0;
	      endcase
	end

	// Output register or memory read data
	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_rdata  <= 0;
	    end 
	  else
	    begin    
	      // When there is a valid read address (S_AXI_ARVALID) with 
	      // acceptance of read address by the slave (axi_arready), 
	      // output the read dada 
	      if (slv_reg_rden)
	        begin
	          axi_rdata <= reg_data_out;     // register read data
	        end   
	    end
	end    

	// Add user logic here

SensorCtrl_Tmod_top SensorCtrl_top(
	.sys_clk(S_AXI_ACLK),  // AXI clock, high speed
	
	.Rst_n	(S_AXI_ARESETN),
	.start_up	(slv_reg0[0]),   // 0: start_up
	.test_mod	(slv_reg0[1]),   // 1: test mode
	
	.switch0		(slv_reg0[2]),
	.switch1		(slv_reg0[3]),
	.switch2		(slv_reg0[4]),
	.switch3		(slv_reg0[5]),
    .switch4        (slv_reg0[6]),
    .switch5        (slv_reg0[7]),
	
	.Expo_T_SW	    (slv_reg1[9:0]       ),
	//.Time_Framedone_Cstart(slv_reg2[16:0]), //
	.Expo_T_SW_out  (slv_reg3[9:0]       ),
	
	.iclk		        (iclk		),//Sensor clk, 10Mhz
	.ocompclk_chip	    (ocompclk	),
	.oisadc_chip		(oisadc		),
	.Pod_chip			(Pod		),
	.Out_chip			(Out		),
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
	.Enb_r(Enb_r),

	.word1(word1),
	.word2(word2),
	.word3(word3),
	.word4(word4),
	.En_Data_Pod(word_en),
	
    .out_word1(out_word1),
    .out_word2(out_word2),
    .out_word3(out_word3),
    .out_word4(out_word4),
    .out_word5(out_word5),
    .out_word6(out_word6),
    .out_word7(out_word7),
    .out_word8(out_word8),
    .En_Data_Out(En_Data_Out),
    .En_Data_Out_O(En_Data_Out_O),
    
    
    .out_pod_w1(out_pod_w1), 
    .out_pod_w2(out_pod_w2), 
    .out_pod_w3(out_pod_w3), 
    .out_pod_w4(out_pod_w4), 
    .out_pod_w5(out_pod_w5), 
    .out_pod_w6(out_pod_w6), 
    .out_pod_w7(out_pod_w7), 
    .out_pod_w8(out_pod_w8),
    .En_out_Pod(En_out_Pod)    
);

// As the hardware-signal only exist 1 clk cycle, here we denfine a software-signal
// to hold the hardware signal, and then the software could read it. Once the software
// read the software-signal, it will be cleared.
	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      software_flag  <= 1'd0;
		  word_en_d1	 <= 1'd0;
		  word_en_d2	 <= 1'd0;
	    end 
	  else begin    
		  word_en_d1	 <= word_en;
		  word_en_d2	 <= word_en_d1;
		  if(word_en_pos) begin
			  software_flag  <= 1'b1;
		  end
		  else if(software_flag_clear) begin
			  software_flag  <= 1'b0;
		  end
		  else begin
			  software_flag  <= software_flag;
		  end
	    end
	end    

    always @( posedge S_AXI_ACLK )
    begin
      if ( S_AXI_ARESETN == 1'b0 )
        begin 
          software_frame_done <= 1'd0;
          frame_done_d1       <= 1'd0;
          frame_done_d2       <= 1'd0;
        end 
      else begin   
          frame_done_d1       <= Frame_done;
          frame_done_d2       <= frame_done_d1;
          if(frame_done_pos) begin
              software_frame_done     <= 1'b1;
          end
          else if(software_frame_done_clear) begin
              software_frame_done     <= 1'b0;
          end
          else begin
              software_frame_done     <= software_frame_done;
          end
        end
    end    

    always @( posedge S_AXI_ACLK )
    begin
      if ( S_AXI_ARESETN == 1'b0 )
        begin 
          software_Cstart <= 1'd0;
          Cstart_d1       <= 1'd0;
          Cstart_d2       <= 1'd0;
        end 
      else begin   
          Cstart_d1       <= Cstart;
          Cstart_d2       <= Cstart_d1;
          if(Cstart_pos) begin
              software_Cstart     <= 1'b1;
          end
          else if(software_Cstart_clear) begin
              software_Cstart     <= 1'b0;
          end
          else begin
              software_Cstart     <= software_Cstart;
          end
        end
    end     

    always @( posedge S_AXI_ACLK )
    begin
      if ( S_AXI_ARESETN == 1'b0 )
        begin 
          software_En_Data_Out <= 1'd0;
          En_Data_Out_d1       <= 1'd0;
          En_Data_Out_d2       <= 1'd0;
        end 
      else begin   
          En_Data_Out_d1       <= En_Data_Out;
          En_Data_Out_d2       <= En_Data_Out_d1;
          if(En_Data_Out_pos) begin
              software_En_Data_Out     <= 1'b1;
          end
          else if(software_En_Data_clear) begin
              software_En_Data_Out     <= 1'b0;
          end
          else begin
              software_En_Data_Out     <= software_En_Data_Out;
          end
        end
    end         
 
    always @( posedge S_AXI_ACLK )
    begin
      if ( S_AXI_ARESETN == 1'b0 )
        begin 
          software_En_Data_Out_O <= 1'd0;
          En_Data_Out_O_d1       <= 1'd0;
          En_Data_Out_O_d2       <= 1'd0;
        end 
      else begin   
          En_Data_Out_O_d1       <= En_Data_Out_O;
          En_Data_Out_O_d2       <= En_Data_Out_O_d1;
          if(En_Data_Out_O_pos) begin
              software_En_Data_Out_O     <= 1'b1;
          end
          else if(software_En_Data_clear) begin
              software_En_Data_Out_O     <= 1'b0;
          end
          else begin
              software_En_Data_Out_O     <= software_En_Data_Out_O;
          end
        end
    end          
    

    always @( posedge S_AXI_ACLK )
    begin
      if ( S_AXI_ARESETN == 1'b0 )
        begin 
          software_En_out_Pod <= 1'd0;
          En_out_Pod_d1       <= 1'd0;
          En_out_Pod_d2       <= 1'd0;
        end 
      else begin   
          En_out_Pod_d1       <= En_out_Pod;
          En_out_Pod_d2       <= En_out_Pod_d1;
          if(En_out_Pod_pos) begin
              software_En_out_Pod     <= 1'b1;
          end
          else if(software_En_out_Pod_clear) begin
              software_En_out_Pod     <= 1'b0;
          end
          else begin
              software_En_out_Pod     <= software_En_out_Pod;
          end
        end
    end         
	// User logic ends       
 endmodule