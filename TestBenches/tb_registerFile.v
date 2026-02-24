`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.12.2025 13:01:01
// Design Name: 
// Module Name: tb_registerFile
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


module tb_registerFile;
    
    reg clk,rst;
    reg [4:0] rs1,rs2,rd;
    reg [31:0] write_data;
    reg regWrite;
    wire [31:0] read_data1,read_data2;
    
    registerFile#(32,32) dut(clk,rst,rs1,rs2,rd,write_data,read_data1,
                            read_data2,regWrite);
    //Clock
    always #5 clk=~clk;
    
    //Testcases
    initial begin
        clk = 0;
        rst = 0;
        regWrite = 0;
        rs1 = 0;
        rs2 = 0;
        rd  = 0;
        write_data = 0;
        
        //Write data to x5;
        #10;
        regWrite = 1;
        rd = 5;
        write_data = 32'hDEADBEEF;

        #10; // posedge happens here
        regWrite = 0;
        
        // Read x5
        rs1 = 5;
        #2;
        
        //Attempt to write to x0
        #10;
        regWrite = 1;
        rd = 0;
        write_data = 32'hFFFFFFFF;

        #10;
        regWrite = 0;

        // Read x0
        rs1 = 0;
        #2;

        #20;
        $finish; 
    end
                            
endmodule
