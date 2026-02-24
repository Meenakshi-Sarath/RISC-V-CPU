`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.12.2025 09:25:55
// Design Name: 
// Module Name: tb_alu
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


module tb_alu;

    wire zero,negative,carry_out,overflow;
    wire signed [31:0] ALU_out;
    reg signed [31:0] a,b;
    reg [3:0] ALU_ctrl;
    //Instantiate module 
    ALU #(32) dut (zero,negative,carry_out,overflow,ALU_out,ALU_ctrl,a,b);
    
    //Define a task 
    task apply_test;
        input signed [31:0] ta,tb;
        input  [3:0] tALU_ctrl;
        begin
            a=ta;
            b=tb;
            ALU_ctrl=tALU_ctrl;
            #10;
        $display("CTRL=%b | a=%0d b=%0d | out=%0d | Z=%b N=%b O=%b",
          ALU_ctrl, a, b, ALU_out, zero, negative, overflow);        
        end
    endtask
    
    //Testcases
    initial begin
        $display("---- ALU TEST START ----");

        // ADD
        apply_test(10, 20, 4'b0000);
        apply_test(32'h7fffffff, 1, 4'b0000); // overflow

        // SUB
        apply_test(20, 10, 4'b0001);
        apply_test(10, 20, 4'b0001);

        // AND
        apply_test(32'hF0F0, 32'h0FF0, 4'b0010);

        // OR
        apply_test(32'hF0F0, 32'h0FF0, 4'b0011);

        // XOR
        apply_test(32'hAAAA, 32'h5555, 4'b0100);

        // SLT (signed)
        apply_test(-5, 3, 4'b0101);
        apply_test(5, -3, 4'b0101);

        // SRL
        apply_test(32'h10, 2, 4'b0110);

        // SRA
        apply_test(-32, 2, 4'b0111);

        // SLTU
        apply_test(32'h00000001, 32'hFFFFFFFF, 4'b1000);

        // SLL
        apply_test(1, 5, 4'b1001);

        // ZERO check
        apply_test(10, 10, 4'b0001);

        $display("---- ALU TEST END ----");
        $stop;
    end
endmodule
