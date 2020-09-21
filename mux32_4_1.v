`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:00:28 05/15/2019 
// Design Name: 
// Module Name:    mux32_4_1 
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
module mux32_4_1(a0,a1,a2,a3,s,y
    );
	 input [31:0] a0,a1,a2,a3;
	 input [1:0] s;
	 output [31:0] y;
	 
	 reg [31:0] y;
	 always @ (*)
		begin
			case(s)
				2'b00: y=a0;
				2'b01: y=a1;
				2'b10: y=a2;
				2'b11: y=a3;
				default: y=2'bx; 
			endcase
		end
endmodule