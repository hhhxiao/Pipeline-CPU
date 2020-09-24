`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:19:14 09/20/2020 
// Design Name: 
// Module Name:    ForwardDecoder 
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
module ForwardDecoder(
	input [3:0] depen,
	input shift,
	input aluimm,
	output [1:0] EXE_A_CTRL,
	output [1:0] EXE_B_CTRL
	 );
	 
	 //ouput exe_a_ctrl
	 wire a_higt_1,a_hight_2;
	 and(a_higt_1,~depen[3],depen[1],~shift);
	 and(a_higt_2,depen[3],~depen[1],~shift);
	 assign EXE_A_CTRL[1] = a_higt_1 | a_higt_2;
	 wire a_low_1,a_low_2;
	 assign  a_low_1 = shift;
	 and(a_low_2,~depen[3],depen[1],~shift);
	 assign EXE_A_CTRL[0] = a_low_1 | a_low_2;
	 
	  //ouput exe_b_ctrl
	  wire b_higt_1,b_hight_2;
	 and(b_higt_1,~depen[2],depen[0],~aluimm);
	 and(b_higt_2,depen[2],~depen[0],~aluimm);
	 assign EXE_B_CTRL[1] = b_higt_1 | b_higt_2;
	 wire b_low_1,b_low_2;
	 assign  b_low_1 = aluimm;
	 and(b_low_2,~depen[2],depen[0],~aluimm);
	 assign EXE_B_CTRL[0] = b_low_1 | b_low_2;
endmodule





