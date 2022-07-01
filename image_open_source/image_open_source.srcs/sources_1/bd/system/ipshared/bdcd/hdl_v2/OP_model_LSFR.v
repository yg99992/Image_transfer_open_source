`timescale 1ns/1ns

module OP_model_LSFR(Clk,Compclk,rst_n,word1,word2,word3,word4);
	
	input Clk;
	input Compclk;
	input rst_n;
	
	output [31:0] word1;
    output [31:0] word2;
    output [31:0] word3;
    output [31:0] word4;
	
	//LFSR
	reg [31:0] data1, data2, data3, data4;
	
	wire bit_in1 = data1[3]^data1[7]^data1[28]^data1[10];
	wire[31:0] data_next1 = {data1[30:0],bit_in1};
	
    wire bit_in2 = data2[17]^data2[7]^data2[21]^data2[10];
    wire[31:0] data_next2 = {data2[30:0],bit_in2};
    
    wire bit_in3 = data3[3]^data3[7]^data3[21]^data3[30];
    wire[31:0] data_next3 = {data3[30:0],bit_in3};
    
    wire bit_in4 = data4[3]^data4[19]^data4[21]^data4[10];
    wire[31:0] data_next4 = {data4[30:0],bit_in4};
    
    assign {word1,word2,word3,word4} = {data1,data2,data3,data4};

	always @(negedge Clk or negedge rst_n) begin
		if(!rst_n) begin
			data1       <= 'hC54A4A212C51;  //random seed
            data2       <= 'hC5C214A54A21;  //random seed
            data3       <= 'hC4A21254AC51;  //random seed
            data4       <= 'hCC544A2A2151;  //random seed
		end
		else begin
			data1       <= data_next1;
            data2       <= data_next2;
            data3       <= data_next3;
            data4       <= data_next4;
		end
	end
	
	

endmodule