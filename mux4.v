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
    output      [WIDTH-1:0] out
);

assign out = sel[1] ? (sel[0] ? d : c) : (sel[0] ? b : a);

endmodule

