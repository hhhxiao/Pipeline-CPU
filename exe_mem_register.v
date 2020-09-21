`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    21:46:17 05/22/2019
// Design Name:
// Module Name:    exe_mem_register
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
module exe_mem_register(clk,clrn,
                        exe_wreg,exe_m2reg,exe_wmem,exe_alu,exe_b,exe_rn,
                        mem_wreg,mem_m2reg,mem_wmem,mem_alu,mem_b,mem_rn
                       );
input [31:0] exe_alu,exe_b;		//
input [4:0] exe_rn;
input exe_wreg,exe_m2reg,exe_wmem;
input clk,clrn;
output  [31:0] mem_alu,mem_b;
reg  [31:0] mem_alu,mem_b;
output [4:0] mem_rn;
reg  [4:0] mem_rn;
output mem_wreg,mem_m2reg,mem_wmem;		//mem
reg mem_wreg,mem_m2reg,mem_wmem;

//////////////////////////////////////////////////////////////////////////////

always @(posedge clk or negedge clrn)
    if(clrn == 0) begin
        mem_alu <=32'b0;
        mem_b <=32'b0;
        mem_rn <= 5'b0;
        mem_wreg <= 0;
        mem_m2reg <=0;
        mem_wmem <=0;

    end
    else begin
        mem_alu <=exe_alu;
        mem_b <=exe_b;
        mem_rn <=exe_rn;
        mem_wreg <=exe_wreg;
        mem_m2reg <=exe_m2reg;
        mem_wmem <=exe_wmem;
    end

endmodule
