`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    14:40:51 05/22/2019
// Design Name:
// Module Name:    instruction_register
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
module instruction_register(if_pc4,if_inst,clk,clrn,id_pc4,id_inst,write_en
                           );
input [31:0] if_pc4, if_inst;
input write_en;
input clk, clrn;
output [31:0] id_pc4,id_inst;

reg [31:0] id_pc4,id_inst;

//请在下方补充代码以完成流水线寄存�
//////////////////////////////////////////////////////////////////////////////
always @(posedge clk or negedge clrn)
    if(clrn == 0) begin
        id_pc4 <= 32'b0;
        id_inst <= 32'b0;
    end
    else if(write_en)
    begin
        id_pc4 <= if_pc4;
        id_inst <= if_inst;
    end
endmodule
