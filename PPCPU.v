`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: 
// 
// Create Date:    18:33:59 05/14/2019 
// Design Name: 
// Module Name:    PPCPU 
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
module PPCPU(Clock, reset, PC, IF_Inst, ID_Inst, EXE_Alu, MEM_Alu, WB_Alu,DEPEN,
    LOAD_DEPEN
    );
	 input Clock, reset;
	 output [31:0] PC, IF_Inst, ID_Inst;
	 output [31:0] EXE_Alu, MEM_Alu, WB_Alu;
	 output DEPEN;
	 output LOAD_DEPEN;
	 wire [31:0]new_pc;
	 wire [1:0] pcsource;
	 wire [31:0] branch_pc, jump_pc4, if_pc4, id_pc4; 
	 
	 wire [31:0] wb_data;
	 wire id_m2reg, exe_m2reg, mem_m2reg, wb_m2reg;
	 wire id_wmem, exe_wmem, mem_wmem;
	 wire [2:0] id_aluc, exe_aluop;
	 wire[1:0] id_b_ctrl, exe_b_ctrl;
	 wire [31:0] id_a, exe_a;
	 wire [31:0] id_b, exe_b, mem_b;
	 wire [31:0] id_imm, exe_imm;
	 wire[1:0] id_a_ctrl, exe_a_ctrl;
	 wire exe_z, mem_z;		//exe_z
 	 wire id_wz, exe_wz;
	 wire id_wreg, exe_wreg, mem_wreg, wb_wreg;
	 wire [4:0] id_rn, exe_rn, mem_rn, wb_rn;
	 wire [31:0] mem_mo, wb_mo;
	 wire [3:0]DEPEN;
	 wire LOAD_DEPEN;
	// wire stall_rst;

 // assign stall_rst = reset && LOAD_DEPEN;
 //   assign stall_rst = reset;
//程序计数
	 program_counter PCR (
	 .clk(Clock),
      .clrn(reset),
      .npc(new_pc),
      .pc(PC),
      .write_en(LOAD_DEPEN)
	 );


//取指令级
	 instruction_fetch IF_STAGE (
	    .pcsource(pcsource),
	    .pc(PC),
	    .jpc(jump_pc4),
	    .bpc(branch_pc),
	    .inst(IF_Inst),
	    .pc4(if_pc4),
	    .npc(new_pc)
	 );


	 //指令寄存器IR
	 instruction_register IR(
	 .if_pc4(if_pc4),
	 .if_inst(IF_Inst),
	 .clk(Clock),
	 .clrn(reset),
	 .id_inst(ID_Inst),
	 .id_pc4(id_pc4),
	 .write_en(LOAD_DEPEN)
	 );

	 //ID
	 instruction_decode ID_STAGE (
	  .clk(Clock),
	  .clrn(reset),
	  .pc4(id_pc4),
	  .inst(ID_Inst),
	  .wb_data_in(wb_data),
	  .rsrtequ(mem_z),
	  .wb_wreg(wb_wreg),
	  .wb_rn(wb_rn),
       .depen(DEPEN),

	    //输出
	  .bpc(branch_pc),
	  .jpc(jump_pc4),
	  .pcsource(pcsource),
       .sld(id_m2reg),
       .wmem(id_wmem),
       .aluop(id_aluc),
       .b_ctrl(id_b_ctrl),
       .a(id_a),
       .b(id_b),
       .imm(id_imm),
       .a_ctrl(id_a_ctrl),
	   .id_wz(id_wz),
       .id_rd(id_rn),
       .id_wreg(id_wreg)
       );

	  DataHazardDepen hazaed (
	 		.ID_instruction(ID_Inst),
	 		.EXE_rd(exe_rn),
	 		.EXE_wreg(exe_wreg),
	 		.EXE_sld(exe_m2reg),
	 		.MEM_rd(mem_rn),
	  		.MEM_Wreg(mem_wreg),
	 		.DEPEN(DEPEN),
	 		.LOAD_DEPEN(LOAD_DEPEN)
	 );


	 id_exe_register ID_EXE (
		 	.clk(Clock), .clrn(reset), //两个时钟控制信号
            .id_aluop (id_aluc),
            .id_a(id_a),
            .id_b(id_b),
            .id_imm(id_imm),
            .id_rd(id_rn),
            .id_a_ctrl(id_a_ctrl),
            .id_b_ctrl(id_b_ctrl),
            .id_wz(id_wz),
            .id_wreg(id_wreg),
            .id_m2reg(id_m2reg),
            .id_wmem(id_wmem),
            .write_en(LOAD_DEPEN),

             .exe_aluop(exe_aluop),
             .exe_a(exe_a),
             .exe_b(exe_b),
             .exe_imm(exe_imm),
             .exe_rd(exe_rn),
             .exe_a_ctrl(exe_a_ctrl),
             .exe_b_ctrl(exe_b_ctrl),
             .exe_wz(exe_wz),
             .exe_wreg(exe_wreg),
             .exe_m2reg(exe_m2reg),
             .exe_wmem(exe_wmem)
             );
									 
	 execute EXE_STAGE (
		 .aluop(exe_aluop),
		 .exe_a(exe_a),
		 .exe_b(exe_b),
		 .imm(exe_imm),
		 .exe_data_forward(MEM_Alu),
		 .mem_data_forward(WB_Alu),
		 .a_ctrl(exe_a_ctrl),
		 .b_ctrl(exe_b_ctrl),
		 .exe_output(EXE_Alu),
		 .zero_flag(exe_z));
	 
	 exe_mem_register_withWZ EXE_MEM (
		.clk(Clock),
	 	.clrn(reset), 
		.exe_z(exe_z),
		.exe_wz(exe_wz), 
		.exe_wreg(exe_wreg),
		.exe_m2reg(exe_m2reg),
		.exe_wmem(exe_wmem),
		.exe_alu(EXE_Alu),
		.exe_b(exe_b),
		.exe_rn(exe_rn), 
		.mem_wreg(mem_wreg),
		.mem_m2reg(mem_m2reg),
		.mem_wmem(mem_wmem),
		.mem_alu(MEM_Alu),
		.mem_b(mem_b),
		.mem_rn(mem_rn),
		.mem_z(mem_z));
	 
	 memory MEM_STAGE (
		mem_wmem,
		MEM_Alu[4:0],
		mem_b, 
		Clock,
		mem_mo);		//
	 
	 mem_wb_register MEM_WB (
		mem_wreg,
		mem_m2reg, 
		mem_mo,
		MEM_Alu,
		mem_rn,
		Clock,
		reset,
		wb_wreg,
		wb_m2reg,
		wb_mo,
		WB_Alu, 
		wb_rn);
	 
	 write_back WB_STAGE (
		 .resut_alu(WB_Alu),
		 .mem_output(wb_mo),
		 .sld(wb_m2reg),
		 .wb_data_output(wb_data)
		 );

endmodule
