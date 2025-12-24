`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.12.2025 15:21:40
// Design Name: 
// Module Name: riscv_cpu
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



// riscv_cpu.v - single-cycle RISC-V CPU Processor

module riscv_cpu (
    input         clk, reset,
    output [31:0] PC,
    input  [31:0] Instr,
    output        MemWrite,
    output [31:0] Mem_WrAddr, Mem_WrData,
    input  [31:0] ReadData,
    output [31:0] Result
);

    wire        ALUSrc, RegWrite, Jump, Zero, Negative, CarryOut, Overflow, PCSrc, JALRSrc;
    wire [1:0]  ResultSrc, ImmSrc;
    wire [3:0]  ALUControl;
    assign JALRSrc = (Instr[6:0] == 7'b1100111); //Opcode for Jump and link register
    
    control_unit c (.ALU_ctrl(ALUControl),.opcode(Instr[6:0]),.funct3(Instr[14:12]), 
    .funct7b5(Instr[30]),.zero(Zero),.negative(Negative),.carry_out(CarryOut)
    ,.overflow(Overflow),.ResultSrc(ResultSrc), .MemWrite(MemWrite), .PCSrc(PCSrc)
    ,.ALUSrc(ALUSrc),.RegWrite(RegWrite),.Jump(Jump),.ImmSrc(ImmSrc));
    
    datapath dp (.clk(clk),.rst(reset),.ResultSrc(ResultSrc),.PCSrc(PCSrc),
    .JALRSrc(JALRSrc),.ALUSrc(ALUSrc),.RegWrite(RegWrite),.ImmSrc(ImmSrc),
    .ALU_ctrl(ALUControl),.zero(Zero),.negative(Negative),.carry(CarryOut),
    .overflow(Overflow),.PC(PC),.Instr(Instr),.Mem_WrAddr(Mem_WrAddr),.Mem_WrData(Mem_WrData)
    ,.ReadData(ReadData),.result(Result));
    
endmodule


