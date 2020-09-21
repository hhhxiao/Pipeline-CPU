`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:34:26 05/14/2019 
// Design Name: 
// Module Name:    IF_STAGE 
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
module instruction_fetch(pcsource,pc,bpc,jpc,pc4,npc,inst
    );
	 input [1:0] pcsource;
	 input [31:0] pc, bpc, jpc;		//pc
	 
	 output [31:0] pc4, npc, inst;		//pc4-pc+4

	 add32 pc_plus4(pc,32'h4,pc4);		//32λ
	 mux32_4_1 next_pc(pc4,bpc,jpc,32'h0,pcsource,npc);
	 Inst_ROM inst_mem(pc[7:2],inst);		//����
	 
endmodule
