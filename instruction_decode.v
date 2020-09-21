`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:26:48 05/15/2019 
// Design Name: 
// Module Name:    ID_STAGE 
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
module instruction_decode(
				clk,
				clrn,
				pc4,
				inst,
              	wb_data_in,
              	rsrtequ,
				wb_wreg,
                wb_rn,
                depen,
				//输出
				bpc,
				jpc,
				pcsource,
				sld,
				wmem,
				aluop,
				b_ctrl,
				a,
				b,
				imm,
				a_ctrl,
				id_wreg,
				id_rd,
				id_wz
    );
	 input [31:0] pc4,inst,wb_data_in;		//pc4
	 input clk,clrn;		//clk
	 input rsrtequ;		//branch
	 input wb_wreg;		//WB
	 input [4:0] wb_rn;		//WB
	 input [3:0] depen;

	 output [31:0] bpc,jpc,a,b,imm;		//bpc-branch
	 output [2:0] aluop;		//ALU
	 output [1:0] pcsource;		//
	 output [4:0] id_rd;
	 output sld,wmem,id_wreg;
	 output [1:0] a_ctrl,b_ctrl;
	 output id_wz;

	 wire shift,aluimm;
	 wire [5:0] op,func;
	 wire [4:0] rs,rt,rd;
	 wire [31:0] qa,qb,br_offset;
	 wire [15:0] ext16;
	 wire regrt,sext,e;
	 
	 assign func=inst[25:20];  
	 assign op=inst[31:26];
	 assign rs=inst[9:5];
	 assign rt=inst[4:0];
	 assign rd=inst[14:10];
	 Control_Unit cu(
	 .rsrtequ(rsrtequ),
	 .func(func),
	 .op(op),
	 .wreg(id_wreg),
	 .sld(sld),
	 .wmem(wmem),
	 .aluop(aluop),
	 .regrt(regrt),
	 .aluimm(aluimm),
	 .sext(sext),
	 .pcsource(pcsource),
	 .shift(shift),
	 .wz(id_wz)
	 );


	 Regfile rf (rs,rt,wb_data_in,wb_rn,wb_wreg,~clk,clrn,qa,qb);		//
	 mux5_2_1 des_reg_num (rd,rt,regrt,id_rd); //	


	ForwardDecoder	 forward_decoder(
	.depen(depen),
	.shift(shift),
	.aluimm(aluimm),
	.EXE_A_CTRL(a_ctrl),
	.EXE_B_CTRL(b_ctrl)
	);

	 assign a=qa;
	 assign b=qb;

	 assign e=sext&inst[25];//
	 assign ext16={16{e}};//
	 assign imm={ext16,inst[25:10]};		//立即数生成

	 assign br_offset={imm[29:0],2'b00};		//
	 add32 br_addr (pc4,br_offset,bpc);		//beq,
	 assign jpc={pc4[31:28],inst[25:0],2'b00};		//jump
	 
endmodule
