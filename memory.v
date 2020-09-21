`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:52:03 05/15/2019 
// Design Name: 
// Module Name:    MEM_STAGE 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module memory(write_enable,addr,datain,clk,dataout
    );
	 input [31:0] datain;
	 input [4:0] addr;
	 input clk,write_enable;
	 output [31:0] dataout;
	 reg [31:0] ram [0:31];
	 assign dataout=ram[addr];		//
	 always @(posedge clk)begin
	 if(write_enable)ram[addr]=datain;
	 end
	 
	 integer i;
	 initial begin		//
	 for(i=0;i<32;i=i+1)		
	    ram[i]=0; 
	 	ram[5'h01]=32'h00000001;
		ram[5'h02]=32'h00000002;
		ram[5'h03]=32'h00000003;
		ram[5'h04]=32'h00000004;
		ram[5'h05]=32'h00000005;
		ram[5'h06]=32'h00000006;
		ram[5'h07]=32'h00000007;
		ram[5'h08]=32'h00000008;
	 end
endmodule
