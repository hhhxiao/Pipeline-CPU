`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:27:17 05/15/2019 
// Design Name: 
// Module Name:    alu 
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
module alu(alua,alub,aluop,alu_output,z
    );
	 input [31:0] alua,alub;
	 input [2:0] aluop;
	 output [31:0] alu_output;
	 output z;
    assign alu_output = (aluop == 3'b000) ? alua + alub :
	               (aluop == 3'b001) ? alua & alub :
	               (aluop == 3'b010) ? alua | alub :
	               (aluop == 3'b011) ? alua ^ alub :
	               (aluop == 3'b100) ? alub >> alua :
	               (aluop == 3'b101) ? alub << alua :
	               (aluop == 3'b110) ? alua - alub :					
	    				32'hxxxxxxxx;	
	 assign z = ~|alu_output;
	 always@(alua or alub)
	 begin
	  //$display("op: %d, a: %h, b: %h, o: %h",aluop,alua,alub,alu_output);
	 end
endmodule
