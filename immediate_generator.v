`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.12.2025 18:19:59
// Design Name: 
// Module Name: immediate_generator
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


module immediate_generator #(parameter data_width=32) (inst,imm_inst,immsrc);
    //Because last 7 bits[6:0] is opcode and never comes in use,imm is never present here
    input [data_width-7:0] inst; 
    output reg [data_width-1:0] imm_inst;
    input [1:0] immsrc; //Select line for instruction type
    
    always @ (*) begin
        case(immsrc)
            //I type
            2'b00: imm_inst={{20{inst[31]}},inst[31:20]}; 
            //S type (storage)
            2'b01: imm_inst={{20{inst[31]}},inst[31:25],inst[11:7]}; 
            //B type 
            2'b10: imm_inst={{20{inst[31]}},inst[31],inst[7],inst[30:25],inst[11:8],1'b0}; 
            //J type 
            2'b11: imm_inst={{12{inst[31]}}, inst[19:12], inst[20], inst[30:21], 1'b0};
            default: imm_inst=32'bx;
        endcase
    end
endmodule
