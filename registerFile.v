`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.12.2025 17:56:23
// Design Name: 
// Module Name: registerFile
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

// reg_file.v - register file for single-cycle RISC-V CPU
//              (with 32 registers, each of 32 bits)
//              having two read ports, one write port
//              write port is synchronous, read ports are combinational
//              register 0 is hardwired to 0

module registerFile #(parameter data_width=32, addr_width=32) (clk,rst,rs1,rs2,rd,write_data,read_data1,read_data2,regWrite);
    input clk,rst;
    input [data_width-1:0] write_data;
    input [4:0] rs1,rs2,rd;
    output [data_width-1:0] read_data1, read_data2;
    input regWrite;
    
    reg [data_width-1:0] registers [31:0];
    
    integer i;
    initial begin
        for (i=0;i<data_width;i=i+1)
            registers[i]=32'd0;
    end
    
    //Synchronous write logic
    always @ (posedge clk) begin
        if (regWrite) // OR DO WE declare smthng else called w_en?
            registers[rd]<=write_data;
    end
    
    //Combinational read logic
    assign read_data1 = (rs1!=0)?registers[rs1]:0;
    assign read_data2 = (rs2!=0)?registers[rs2]:0;
    
endmodule
