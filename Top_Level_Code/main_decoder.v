`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.12.2025 11:44:27
// Design Name: 
// Module Name: main_decoder
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

module main_decoder(
    input  [6:0] opcode,
    output [1:0] ALU_op,
    output [1:0] ImmSrc,
    output [1:0] ResultSrc,
    output Branch,
    output RegWrite,
    output MemWrite,
    output Jump,
    output ALUSrc
);

    reg [10:0] controls;

    always @(*) begin
        casez(opcode)
            //That 11-bit number is your design's control vector, not the opcode itself.
            // RegWrite_ImmSrc_ALUSrc_MemWrite_ResultSrc_Branch_ALUOp_Jump           
            7'b0000011: controls = 11'b1_00_1_0_01_0_00_0; // LW
            7'b0100011: controls = 11'b0_01_1_1_00_0_00_0; // SW
            7'b0110011: controls = 11'b1_00_0_0_00_0_10_0; // R-type
            7'b0010011: controls = 11'b1_00_1_0_00_0_10_0; // ADDI
            7'b1100011: controls = 11'b0_10_0_0_00_1_01_0; // BEQ
            7'b1101111: controls = 11'b1_11_0_0_10_0_00_1; // JAL
            7'b1100111: controls = 11'b1_00_1_0_10_0_00_1; // JALR
            7'b0110111: controls = 11'b1_11_1_0_11_0_00_0; // LUI
            7'b0010111: controls = 11'b1_11_1_0_00_0_00_0; // AUIPC
            default:    controls = 11'b0_00_0_0_00_0_00_0;
        endcase
    end

    assign {RegWrite,ImmSrc,ALUSrc,MemWrite,ResultSrc,Branch,ALU_op,Jump} = controls;

endmodule
