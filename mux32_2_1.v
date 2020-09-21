`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:25:59 05/15/2019 
// Design Name: 
// Module Name:    mux32_2_1 
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
module mux32_2_1(a0,a1,s,y
    );
	 input [31:0] a0,a1;
	 input s;
	 output [31:0] y;
	 
	 reg [31:0] y;
	 always @ (*)
		begin
			case(s)
				1'b0: y=a0;
				1'b1: y=a1;
				default: y=32'hxxxxxxxx; 
			endcase
		end
endmodule