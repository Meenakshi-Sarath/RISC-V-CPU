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
module reset #( parameter width =8)(d,q,clk,rst);
    input clk,rst;
    input [width-1:0] d;
    output reg [width-1:0] q;
    
    always @ (posedge clk) begin
        if (rst)
            q<=8'b0;
        else
            q<=d;
    end
endmodule
