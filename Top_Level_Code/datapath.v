`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.12.2025 17:51:25
// Design Name: 
// Module Name: datapath
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

//inputs are coming from control unit

module datapath(
    input clk,rst,
    input JALRSrc, PCSrc, ALUSrc,
    input [1:0] ResultSrc,ImmSrc,
    input RegWrite, 
    input [31:0] Instr,
    output [31:0] PC,result, //this result is of final 4:1 mux from data memory
    output zero,negative,carry_out,overflow,
    input [3:0] ALU_ctrl,
    input [31:0] ReadData, //output of data memory 
    output [31:0] Mem_WrData, Mem_WrAddr,
    input isLUI
);

    //wires- interconnects within datapath- adders/mux/alus
    wire [31:0] PCnext, PCplus4, PCtarget;
    wire [31:0] PCbeforeJALR; //JALR: Jump and link register
    wire [31:0] ALU_out,ImmExt,SrcA,SrcB,RegData2; //SrcA and SrcB are inputs to the ALU
    wire [31:0] AuiPC, LUIorAUIPC;
    
    //Next PC logic
    reset #(32) rt (.d(PCnext),.q(PC),.clk(clk),.rst(rst));
    adder pcnextadder(.a(PC),.b(32'd4),.sum(PCplus4));
    adder pcbranch(.a(PC),.b(ImmExt),.sum(PCtarget));
    mux2 #32 Before_uncond_mux(.sel(PCSrc),.a(PCplus4),.b(PCtarget),.out(PCbeforeJALR));
    mux2 #32 with_uncond_mux(.sel(JALRSrc),.a(PCbeforeJALR),.b(ALU_out),.out(PCnext));
    
    //register file logic 
    registerFile rf (.clk(clk),.rst(rst),.write_data(result),.rs1(Instr[19:15]),.rs2(Instr[24:20]),
    .rd(Instr[11:7]),.read_data1(SrcA),.read_data2(RegData2),.regWrite(RegWrite));
    
    //Immediate generation
     immediate_generator im (.inst(Instr[31:7]),.imm_inst(ImmExt),.immsrc(ImmSrc));
     
     //ALU logic 
     mux2 #32 bmux (.a(RegData2),.b(ImmExt),.sel(ALUSrc),.out(SrcB));
     ALU mainalu (.zero(zero),.negative(negative),.carry_out(carry_out),.overflow(overflow),
     .ALU_out(ALU_out),.ALU_ctrl(ALU_ctrl),.a(SrcA),.b(SrcB));
     
     //Now Auipc and LUI logic
     // add upper immediate to pc- used for relative addressing
     adder #32 auipcadder(.a(PC),.b({Instr[31:12],12'b0}),.sum(AuiPC));
     // second parameter is LUI: load upper immediate for loading large CONSTANTS
     mux2 #32 LorAUmux(.sel(isLUI),.a(AuiPC),.b({Instr[31:12],12'b0}),.out(LUIorAUIPC));
     mux4 #32 resultmux(.sel(ResultSrc),.out(result),.a(ALU_out),.b(ReadData),.c(PCplus4),.d(LUIorAUIPC));
     
     assign Mem_WrData = RegData2;
     assign Mem_WrAddr = ALU_out; 
     
endmodule
