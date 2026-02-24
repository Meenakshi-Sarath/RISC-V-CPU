`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.12.2025 09:09:28
// Design Name: 
// Module Name: ALU
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


module ALU #(parameter data_width=32) (zero,negative,carry_out,overflow,ALU_out,ALU_ctrl,a,b);
    input signed [data_width-1:0] a,b;
    input [3:0] ALU_ctrl;
    output reg [data_width-1:0] ALU_out;
    output zero,negative,carry_out,overflow;
    
    reg carry;
    
    always @ (a,b,ALU_ctrl) begin
        carry=0;
        case (ALU_ctrl)
            4'b0000: ALU_out=a+b; //ADD
            4'b0001: ALU_out=a-b; //SUB
            4'b0010: ALU_out=a&b; //AND
            4'b0011: ALU_out=a|b; //OR
            4'b0100: ALU_out=a^b; //XOR
            4'b0101: begin //SLT - signed
                         if (a[31]!=b[31])
                            ALU_out=a[31]?1:0;
                         else
                            ALU_out= a<b?1:0;
                     end
            4'b0110: ALU_out=a>>b; //SRL
            4'b0111: ALU_out= a >>> b;  //  SRA
            4'b1000: ALU_out= a < b ? 1 : 0; // SLTU - for unsigned   
            4'b1001: ALU_out= a << b[4:0]; // SLL
            default: ALU_out= 0;
        endcase
    end
    
    assign zero = ALU_out==0;
    assign overflow=(a[31]==b[31]) && (ALU_out[31]!=a[31]);
    assign negative= ALU_out[31];
    assign carry_out=carry;
endmodule
