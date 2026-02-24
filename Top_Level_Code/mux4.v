`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.12.2025 17:47:09
// Design Name: 
// Module Name: mux4
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


// mux4.v - logic for 4-to-1 multiplexer

module mux4 #(parameter WIDTH = 8) (
    input       [WIDTH-1:0] a, b, c, d,
    input       [1:0] sel,
    output    reg  [WIDTH-1:0] out
);

    always @(*) begin
        case (sel)
            2'b00: out = a;  // ALU_out
            2'b01: out = b;  // ReadData
            2'b10: out = c;  // PCplus4
            2'b11: out = d;  // LUI/AUIPC
            default: out = a;
        endcase
    end

endmodule

