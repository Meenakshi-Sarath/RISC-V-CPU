`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.12.2025 17:38:45
// Design Name: 
// Module Name: reset
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

//8 bit resettable d ff
module reset #(parameter WIDTH = 32)(
    input  clk,
    input  rst,
    input  [WIDTH-1:0] d,
    output reg [WIDTH-1:0] q
    );
    always @(posedge clk or posedge rst) begin
        if (rst)
            q <= {WIDTH{1'b0}};
        else
            q <= d;
    end
endmodule