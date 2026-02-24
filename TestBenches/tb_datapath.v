`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.12.2025 16:49:39
// Design Name: 
// Module Name: tb_datapath
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

//GIVEN THE CORRECT CONTROL SIGNALS- does the datapath flow correctly
module tb_datapath;

    // Clock & reset
    reg clk, rst;

    // Control signals
    reg JALRSrc, PCSrc, ALUSrc, RegWrite;
    reg [1:0] ResultSrc, ImmSrc;
    reg [3:0] ALU_ctrl;

    // Instruction & memory
    reg  [31:0] Instr;
    reg  [31:0] ReadData;

    // Outputs
    wire [31:0] PC, result, Mem_WrData, Mem_WrAddr;
    wire zero, negative, carry, overflow;

    // DUT
    datapath dut(
        clk, rst,
        JALRSrc, PCSrc, ALUSrc,
        ResultSrc, ImmSrc, RegWrite,
        Instr,
        PC, result,
        zero, negative, carry, overflow,
        ALU_ctrl,
        ReadData,
        Mem_WrData, Mem_WrAddr
    );

    // Instruction fields
    reg [6:0] opcode, funct7;
    reg [4:0] rd, rs1, rs2;
    reg [2:0] funct3;
    reg [31:0] imm;

    // Assemble instruction cleanly
    always @(*) begin
        case (opcode)
            7'b0010011, 7'b1100111: // I-type (ADDI, JALR)
                Instr = {imm[11:0], rs1, funct3, rd, opcode};

            7'b0110011: // R-type
                Instr = {funct7, rs2, rs1, funct3, rd, opcode};

            7'b0110111, 7'b0010111: // LUI / AUIPC
                Instr = {imm[31:12], rd, opcode};

            default:
                Instr = 32'b0;
        endcase
    end

    // Clock
    always #5 clk = ~clk;

    initial begin
        // ---------------- INIT ----------------
        clk = 0;
        rst = 1;

        JALRSrc  = 0;
        PCSrc    = 0;
        ALUSrc   = 0;
        RegWrite = 0;
        ResultSrc= 2'b00;
        ImmSrc   = 2'b00;
        ALU_ctrl = 4'b0000;
        ReadData = 32'b0;

        opcode = 0; funct3 = 0; funct7 = 0;
        rs1 = 0; rs2 = 0; rd = 0; imm = 0;

        #10 rst = 0;

        // =========================================================
        // TEST 1: ADDI x1 = 10
        // =========================================================
        opcode   = 7'b0010011;
        funct3   = 3'b000;
        rs1      = 5'd0;
        rd       = 5'd1;
        imm      = 32'd10;

        ALUSrc   = 1;
        ALU_ctrl = 4'b0000;
        ResultSrc= 2'b00;
        RegWrite = 1;
        #10;

        // =========================================================
        // TEST 2: ADDI x2 = 20
        // =========================================================
        rs1 = 5'd0;
        rd  = 5'd2;
        imm = 32'd20;
        #10;

        // =========================================================
        // TEST 3: ADD x3 = x1 + x2
        // =========================================================
        opcode   = 7'b0110011;
        funct7   = 7'b0000000;
        funct3   = 3'b000;
        rs1      = 5'd1;
        rs2      = 5'd2;
        rd       = 5'd3;

        ALUSrc   = 0;
        ALU_ctrl = 4'b0000;
        RegWrite = 1;
        #10;

        // =========================================================
        // TEST 4: LUI x5 = 0x12345000
        // =========================================================
        opcode    = 7'b0110111;
        rd        = 5'd5;
        imm       = 32'h12345000;

        ResultSrc = 2'b11;
        RegWrite  = 1;
        #10;

        // =========================================================
        // TEST 5: AUIPC x6 = PC + imm
        // =========================================================
        opcode    = 7'b0010111;
        rd        = 5'd6;
        imm       = 32'h00001000;

        ResultSrc = 2'b11;
        RegWrite  = 1;
        #10;

        // =========================================================
        // TEST 6: JALR x7 = PC+4, PC = x1 + imm
        // =========================================================
        opcode    = 7'b1100111;
        funct3   = 3'b000;
        rs1      = 5'd1;
        rd       = 5'd7;
        imm      = 32'd4;

        JALRSrc  = 1;
        ALUSrc   = 1;
        ResultSrc= 2'b10;
        RegWrite = 1;
        #10;

        $display("DATAPATH TESTBENCH COMPLETED");
        $finish;
    end
endmodule
