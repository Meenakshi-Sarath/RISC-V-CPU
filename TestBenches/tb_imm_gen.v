`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.12.2025 13:20:41
// Design Name: 
// Module Name: tb_imm_gen
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


module tb_imm_gen;
    reg [31:7] inst;
    reg [1:0] immsrc;
    wire [31:0] imm_inst;
    
    immediate_generator #(32) dut(inst,imm_inst,immsrc);
    
    initial begin
        
        //I type 
        // imm_inst = 0xFFFFFFFC
        // -------------------------
        inst = 32'b111111111100_00010_000_00001_0010011;
        immsrc = 2'b00;
        #5;

        // -------------------------
        // S-TYPE (SW x3, 8(x4))
        // imm_inst = 8
        // -------------------------
        inst = 32'b0000000_00011_00100_010_01000_0100011;
        immsrc = 2'b01;
        #5;

        // -------------------------
        // B-TYPE (BEQ x1, x2, 16)
        // imm_inst = 16
        // -------------------------
        inst = 32'b0_000001_00010_00001_000_0100_0_1100011;
        immsrc = 2'b10;
        #5;

        // -------------------------
        // J-TYPE (JAL x1, 2048)
        // imm_inst = 2048
        // -------------------------
        inst = 32'b0_00000010_0_0000000001_00001_1101111;
        immsrc = 2'b11;
        #5;

        $finish;
        #10;
        
    end
    
endmodule
