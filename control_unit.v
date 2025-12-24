`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.12.2025 08:36:13
// Design Name: 
// Module Name: control_unit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module control_unit(ALU_ctrl,funct3,funct7b5,opcode,ResultSrc,MemWrite,ALUSrc,ImmSrc,RegWrite,Jump,PCSrc,zero,negative,carry_out,overflow);
    input zero,negative,carry_out,overflow; // comes from ALU
    input [6:0] opcode; // These come from inst mem
    input funct7b5;
    input [2:0] funct3;
    output [1:0] ResultSrc, ImmSrc;
    output MemWrite,PCSrc, ALUSrc, RegWrite, Jump;
    output [3:0] ALU_ctrl;
    
    wire [1:0] ALU_op;
    wire Branch;
    reg branchCondition;
    
    main_decoder md (opcode, ALU_op,,ResultSrc,MemWrite,ALUSrc,ImmSrc,Branch,RegWrite,Jump);
    ALU_decoder ad (ALU_ctrl,ALU_op,funct3,funct7b5,opcode[5]);
    
    always @(*) begin
        branchCondition=0;
        if (Branch) // if branch flag is true
            case(funct3)// based on operation of branch we assign corresponding op to branchCondition
                3'b000: branchCondition = zero; //beq
                3'b001: branchCondition = ~zero; //bne
                3'b100: branchCondition = negative ^ overflow; // blt
                3'b101: branchCondition = ~(negative ^ overflow); // bge
                3'b110: branchCondition = negative;// bltu - just check if result negative
                3'b111: branchCondition = ~negative | zero;//bgeu - branch if greater than or equal to
                default: branchCondition = 0;
            endcase
    end
    
    assign PCSrc= (Branch && branchCondition) | Jump;
endmodule
