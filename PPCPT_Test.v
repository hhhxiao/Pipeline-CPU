`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   09:31:01 09/20/2020
// Design Name:   PPCPU
// Module Name:   C:/Xilinx/NEWPPCPU/PPCPT_Test.v
// Project Name:  NEWPPCPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: PPCPU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module PPCPT_Test;

	// Inputs
	reg Clock;
	reg Resetn;

	// Outputs
	wire [31:0] PC;
	wire [31:0] IF_Inst;
	wire [31:0] ID_Inst;
	wire [31:0] EXE_Alu;
	wire [31:0] MEM_Alu;
	wire [31:0] WB_Alu;
	wire [3:0]DEPEN;

	// Instantiate the Unit Under Test (UUT)
	PPCPU uut (
		.Clock(Clock), 
		.Resetn(Resetn), 
		.PC(PC), 
		.IF_Inst(IF_Inst), 
		.ID_Inst(ID_Inst), 
		.EXE_Alu(EXE_Alu), 
		.MEM_Alu(MEM_Alu), 
		.WB_Alu(WB_Alu),
		.DEPEN(DEPEN)
	);

	initial begin
		// Initialize Inputs
		Clock = 0;
		Resetn = 0;

		// Wait 100 ns for global reset to finish
		#20;
		Resetn = 1;
        
		// Add stimulus here

	end
	always #50 Clock = ~Clock;
      
endmodule

