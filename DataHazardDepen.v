`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    20:34:05 09/06/2020
// Design Name:
// Module Name:    DataHazardDepen
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
module DataHazardDepen(
           input[31:0] ID_instruction,
           input [4:0]EXE_rd,
           input EXE_wreg,
           input EXE_sld,
           input[4:0] MEM_rd,
           input MEM_Wreg,
           output [3:0] DEPEN,
           output LOAD_DEPEN
       );
wire[5:0] op,func;
wire i_add,i_and,i_or,i_xor;
wire i_addi,i_andi,i_xori,i_ori;
wire i_load,i_store;
wire i_sll,i_srl;
wire ID_rs1ISReg,ID_rs2ISReg;
wire [4:0] ID_rs1,ID_rs2;
wire [4:0]ID_rd;
wire ID_is_imm_ins;
wire EXE_ADEPEN,EXE_BDEPEN;
wire MEM_ADEPEN,MEM_BDEPEN;
wire LOAD_A_DEPEN,LOAD_B_DEPEN;
assign op  = ID_instruction[31:26];
assign func =ID_instruction[25:20];
assign ID_rs1 = ID_instruction[9:5];
assign ID_rs2 = ID_instruction[4:0];
and(i_add,~op[5],~op[4],~op[3],~op[2],~op[1],~op[0],~func[2],~func[1],func[0]);		//add
and(i_and,~op[5],~op[4],~op[3],~op[2],~op[1],op[0],~func[2],~func[1],func[0]);		//and
and(i_or,~op[5],~op[4],~op[3],~op[2],~op[1],op[0],~func[2],func[1],~func[0]);		//or
and(i_xor,~op[5],~op[4],~op[3],~op[2],~op[1],op[0],func[2],~func[1],~func[0]);		//xor

and(i_srl,~op[5],~op[4],~op[3],~op[2],op[1],~op[0],~func[2],func[1],~func[0]);		//srl
and(i_sll,~op[5],~op[4],~op[3],~op[2],op[1],~op[0],~func[2],func[1],func[0]);		//sll


and(i_addi,~op[5],~op[4],~op[3],op[2],~op[1],op[0]);		//addi
and(i_andi,~op[5],~op[4],op[3],~op[2],~op[1],op[0]);		//andi
and(i_ori,~op[5],~op[4],op[3],~op[2],op[1],~op[0]);		//ori
and(i_xori,~op[5],~op[4],op[3],op[2],~op[1],~op[0]);		//xori

and(i_load,~op[5],~op[4],op[3],op[2],~op[1],op[0]);		//load
and(i_store,~op[5],~op[4],op[3],op[2],op[1],~op[0]);

assign ID_is_imm_ins = i_addi | i_ori | i_xori | i_andi | i_sll | i_srl;
assign ID_rd = ID_is_imm_ins?ID_instruction[4:0]:ID_instruction[14:10];

//下面几条指令的[9:5]是源寄存器
or(ID_rs1ISReg,
   i_add,i_and,i_xor,i_or,
   i_addi,i_andi,i_xori,i_ori,
   i_load,i_store
  );

assign LOAD_A_DEPEN = (ID_rs1 == EXE_rd) && EXE_sld && ID_rs1ISReg;
assign LOAD_B_DEPEN = (ID_rs2 == EXE_rd) && EXE_sld && ID_rs2ISReg;
//下面几个寄存器的[4:0]是目的寄存器
or(ID_rs2ISReg,i_and,i_or,i_add,i_xor,i_sll,i_srl);
assign EXE_ADEPEN = (ID_rs1 == EXE_rd) && EXE_wreg  &&ID_rs1ISReg ;
assign EXE_BDEPEN = ((ID_rs2 == EXE_rd) && EXE_wreg && ID_rs2ISReg == 1) || ((ID_rd == EXE_rd) &&EXE_wreg &&i_store);

assign MEM_ADEPEN = (ID_rs1 == MEM_rd)&&MEM_Wreg  && ID_rs1ISReg ;
assign MEM_BDEPEN = (ID_rs2 == MEM_Wreg) && MEM_Wreg  && ID_rs2ISReg ;
assign DEPEN =  {EXE_ADEPEN ,EXE_BDEPEN , MEM_ADEPEN ,MEM_BDEPEN};
assign LOAD_DEPEN = ~(LOAD_A_DEPEN || LOAD_B_DEPEN);
//assign LOAD_DEPEN  = ~EXE_sld;
endmodule
