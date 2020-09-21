`timescale 1ns / 1ps
module Control_Unit(rsrtequ,func,
                    op,wreg,sld,wmem,aluop,regrt,aluimm,
                    sext,pcsource,shift,wz
                   );
input rsrtequ; 		//if (r=0)rsrtequ=1
input [5:0] func,op;		//func  op
output wreg; //是否是写寄存器的
output sld; //写回是内存还是ALU
output wmem; //写内存
output regrt;
output aluimm;
output sext;
output shift;
output wz;		//
output [2:0] aluop;		//ALU
output [1:0] pcsource;		//PC
reg [2:0] aluop;
reg [1:0] pcsource;
wire i_add,i_and,i_or,i_xor,i_sll,i_srl;            //
wire i_addi,i_andi,i_ori,i_xori;
wire i_lw,i_sw;		//
wire i_beq,i_bne;		//branch
wire i_j;		//jump
/////////////////////////////////////////////////////////////////////////////////////////////////////
//下面根据op和func提取 指令类型
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

and(i_lw,~op[5],~op[4],op[3],op[2],~op[1],op[0]);		//load
and(i_sw,~op[5],~op[4],op[3],op[2],op[1],~op[0]);		//store

and(i_beq,~op[5],~op[4],op[3],op[2],op[1],op[0]);		//beq
and(i_bne,~op[5],op[4],~op[3],~op[2],~op[1],~op[0]);		//bne

and(i_j,~op[5],op[4],~op[3],~op[2],op[1],~op[0]);		//jump

/////////////////////////////////////////////////////////////////////////////////////////////////////
assign wreg=i_add|i_and|i_or|i_xor|i_sll|i_srl|i_addi|i_andi|i_ori|i_xori|i_lw;		//
assign regrt=i_addi|i_andi|i_ori|i_xori|i_lw;    //regrt1rtrd
assign sld=i_lw;  //1ALU
assign shift=i_sll|i_srl;//ALUa1ALUainst[19:15]
assign aluimm=i_addi|i_andi|i_ori|i_xori|i_lw|i_sw;//ALUb1ALUb
assign sext=i_addi|i_lw|i_sw|i_beq|i_bne;//1
assign wmem=i_sw;//1
assign wz=i_beq|i_bne;

always @(rsrtequ or op or func)
case (op)
    6'b000000: begin
        aluop<=3'b000;
        pcsource<=2'b00;
    end		//+; pc=pc+4
    6'b000001:
    case (func[5:0])
        3'b000001: begin
            aluop<=3'b001;
            pcsource<=2'b00;
        end		//and; pc=pc+4
        3'b000010: begin
            aluop<=3'b010;
            pcsource<=2'b00;
        end		//or; pc=pc+4
        3'b000100: begin
            aluop<=3'b011;
            pcsource<=2'b00;
        end		//xor; pc=pc+4
        default: begin
            aluop<=3'b111;
            pcsource<=2'b11;
        end
    endcase
    6'b000010:
    case (func[5:0])
        3'b000010: begin
            aluop<=3'b100;
            pcsource<=2'b00;
        end		//srl; pc=pc+4
        3'b000011: begin
            aluop<=3'b101;
            pcsource<=2'b00;
        end		//sll; pc=pc+4
        default: begin
            aluop<=3'b111;
            pcsource<=2'b11;
        end
    endcase
    6'b000101: begin
        aluop<=3'b000;
        pcsource<=2'b00;
    end		//addi; pc=pc+4
    6'b001001: begin
        aluop<=3'b001;
        pcsource<=2'b00;
    end		//andi; pc=pc+4
    6'b001010: begin
        aluop<=3'b010;
        pcsource<=2'b00;
    end		//ori; pc=pc+4
    6'b001100: begin
        aluop<=3'b011;
        pcsource<=2'b00;
    end		//xori; pc=pc+4

    6'b001101: begin
        aluop<=3'b000;
        pcsource<=2'b00;
    end		//load; pc=pc+4
    6'b001110: begin
        aluop<=3'b000;
        pcsource<=2'b00;
    end		//store; pc=pc+4
    6'b001111: begin
        aluop<=3'b110;
        if(rsrtequ)
            pcsource<=2'b01;
        else
            pcsource<=2'b00;
    end		//beq; pc=bpc
    6'b010000: begin
        aluop<=3'b110;
        if(!rsrtequ)
            pcsource<=2'b01;
        else
            pcsource<=2'b00;
    end		//bne; pc=bpc
    6'b010010: begin
        aluop<=3'b111;
        pcsource<=2'b10;
    end		//jump; pc=jpc
    default: begin
        aluop<=3'b111;
        pcsource<=2'b11;
    end
endcase

endmodule
