`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:01:40 05/22/2019 
// Design Name: 
// Module Name:    id_exe_register 
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
module id_exe_register(clk,clrn, //时钟信号
		id_aluop,  //id级翻译出来的alu控制�
		id_a, // id 操作数a
		id_b, // id 操作数b
		id_imm, //id 立即
		id_rd,  //id目的寄存
		id_a_ctrl,  //id a控制
		id_b_ctrl, //id b控制
		//下面4个等下再
		id_wz,	
		id_wreg,
		id_m2reg,
		id_wmem,
		write_en,
//下面是输
		
		//上面7个传给exe
		exe_aluop,
		exe_a,
		exe_b,
		exe_imm,
		exe_rd,
		exe_a_ctrl,
		exe_b_ctrl,
		//下面四个直接传给exe_mem
		exe_wz,
		exe_wreg,
		exe_m2reg,
		exe_wmem
    );
	 input [31:0] id_a,id_b,id_imm;
	 input [4:0] id_rd;
	 input [2:0] id_aluop;
	 input id_wreg,id_m2reg,id_wmem,id_wz;
	 input [1:0] id_b_ctrl,id_a_ctrl;
	 input clk,clrn,write_en;
	 
	 output [31:0] exe_a,exe_b,exe_imm;
	 reg [31:0] exe_a,exe_b,exe_imm;
	 output [4:0] exe_rd;
	 reg  [4:0] exe_rd;
	 output [2:0] exe_aluop;
	 reg [2:0] exe_aluop;
	 output exe_wreg,exe_m2reg,exe_wmem,exe_wz;
	reg exe_wreg,exe_m2reg,exe_wmem,exe_wz;
	output [1:0] exe_b_ctrl,exe_a_ctrl;
	reg [1:0] exe_b_ctrl,exe_a_ctrl;
	
	 //////////////////////////////////////////////////////////////////////////////	 always @(posedge clk or negedge clrn)
		always @(posedge clk or negedge clrn)
		if(clrn == 0)
			begin
				exe_aluop <= 3'b0;
				exe_a <= 32'b0;
				exe_b <= 32'b0;
				exe_imm <= 32'b0;
				exe_rd <= 5'b0;
				exe_a_ctrl<= 2'b0;
				exe_b_ctrl<= 2'b0;

				exe_wz<= 0;
				exe_wreg <= 0;
				exe_m2reg<= 0;
				exe_wmem <= 0;
			end
		else
			begin
				exe_aluop <= id_aluop;
				exe_a <= id_a;
				exe_b <= id_b;
				exe_imm <= id_imm;
				exe_rd <= id_rd;
				exe_a_ctrl<= id_a_ctrl;
				exe_b_ctrl<= id_b_ctrl;
				exe_m2reg<= id_m2reg;
				if(write_en)
				begin
					exe_wz<=id_wz;
                    exe_wreg <= id_wreg;
                    exe_wmem <= id_wmem;
				end
			end
			endmodule
