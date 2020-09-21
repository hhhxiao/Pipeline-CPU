`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:08:12 05/22/2019 
// Design Name: 
// Module Name:    PC 
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
module program_counter(
    clk,
    clrn,
    write_en,
    npc,
    pc
    );
	 input clk, clrn,write_en;
	 input [31:0] npc;		//
	 output [31:0] pc;		//

 	 dff32 program_counter(npc,clk,clrn,pc,write_en);   //
endmodule
