`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:19:13 05/15/2019 
// Design Name: 
// Module Name:    EXE_STAGE 
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
module execute(
	aluop, //运算控制位
	exe_a,	//ID_EXE寄存器送入的qa
	exe_b, 	//ID_EXE寄存器送入的qb
	imm, //ID_EXE寄存器送入的立即数
	exe_data_forward, //执行级的forarding数据
	mem_data_forward,  //访存即的forwarding数据
	a_ctrl,	  		//ALU输入口a的控制信号
	b_ctrl, 		//ALU输入口b的控制信号
	exe_output,   //执行级输出
	zero_flag    //0标志位
    );
	 input [31:0] exe_a,exe_b,imm;		//ea
	 input [2:0] aluop;		//ALU
	 input [1:0]b_ctrl,a_ctrl;		//ALU
	 input [31:0] exe_data_forward,mem_data_forward;
	 output [31:0] exe_output;		//alu
	 output zero_flag;
	 
	 wire [31:0] alu_in_a,alu_in_b,shift_num;

	 assign shift_num={27'b0,imm[9:5]};//

	 mux32_4_1 alu_ina (exe_a,shift_num,exe_data_forward,mem_data_forward,  a_ctrl,alu_in_a);//
	 mux32_4_1 alu_inb (exe_b,imm,      exe_data_forward,mem_data_forward,  b_ctrl,alu_in_b);//
 	 alu al_unit (alu_in_a,alu_in_b,aluop,exe_output,zero_flag);//ALU
endmodule