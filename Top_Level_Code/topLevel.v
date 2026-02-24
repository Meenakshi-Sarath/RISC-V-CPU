`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.12.2025 10:53:21
// Design Name: 
// Module Name: topLevel
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

//This module connects CPU core, data and instruction memory, and external testbench signals
//The testbench signals serve as inputs
//Outputs are what the testbench will need to observe
//Wires neither coming from nor exposed outside

module topLevel(
    input clk,rst,
    input Ext_MemWrite,
    input  [31:0] Ext_WriteData, Ext_DataAdr,
    output MemWrite, //modified with external control then goes to data mem 
    output [31:0] ReadData,Result,
    output [31:0] WriteData, DataAdr
    );
    
    //Wires
    wire [31:0] Instr, DataAdr_rv32, WriteData_rv32;
    wire MemWrite_rv32; //Raw signal coming from control unit
    wire [2:0] funct3;
    wire [31:0] PC = 32'd0;
    
    //Instantiate processor and memories
    riscv_cpu rv (.clk(clk),.reset(rst),.PC(PC),.Instr(Instr),.MemWrite(MemWrite_rv32),
    .Mem_WrAddr(DataAdr_rv32),.Mem_WrData(WriteData_rv32),.ReadData(ReadData),.Result(Result));
    inst_mem im (.read_add(PC),.inst_out(Instr));
    data_mem dm (.clk(clk),.funct3(funct3),.w_en(MemWrite),.rd_data(ReadData),
    .wr_data(WriteData),.wr_addr(DataAdr));
    
    assign funct3 = rst?3'b010:Instr[14:12]; //010: force word mode
    assign MemWrite = (Ext_MemWrite && rst)?1:MemWrite_rv32;
    assign DataAdr = rst?Ext_DataAdr:DataAdr_rv32;
    assign WriteData = (Ext_MemWrite && rst)?Ext_WriteData:WriteData_rv32;
    
endmodule
