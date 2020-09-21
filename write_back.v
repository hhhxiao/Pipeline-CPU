`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:43:26 05/16/2019 
// Design Name: 
// Module Name:    WB_STAGE 
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
//写回级(就是一个2-1复用器)
module write_back(resut_alu,mem_output,sld,wb_data_output
    );
	 input [31:0] resut_alu;
	 input [31:0] mem_output;
	 input sld;
	 output [31:0] wb_data_output;
	 mux32_2_1 wb_stage (resut_alu, mem_output, sld, wb_data_output);

endmodule
