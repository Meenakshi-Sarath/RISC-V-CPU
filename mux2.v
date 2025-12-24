`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.12.2025 17:41:36
// Design Name: 
// Module Name: mux2
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

//8 bit 2:1 mux
module mux2 #(parameter width=8)(sel,a,b,out);
    input sel;
    input [width-1:0] a,b;
    output [width-1:0] out;
    
    assign out = sel? b : a;
endmodule
