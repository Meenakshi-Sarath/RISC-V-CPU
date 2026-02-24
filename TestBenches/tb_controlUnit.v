`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.12.2025 13:10:20
// Design Name: 
// Module Name: tb_controlUnit
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


module tb_controlUnit;
    
    reg zero,negative,carry_out,overflow,funct7b5;
    reg [6:0] opcode;
    reg [2:0] funct3;
    
    wire MemWrite,PCSrc, ALUSrc, RegWrite, Jump;
    wire [1:0] ResultSrc, ImmSrc;
    wire [3:0] ALU_ctrl;
    
    control_unit dut(ALU_ctrl,funct3,funct7b5,opcode,ResultSrc,MemWrite,
    ALUSrc,ImmSrc,RegWrite,Jump,PCSrc,zero,negative,carry_out,overflow);
    
    //Task to check each and every control signal that is produced 
    //following each instruction
    task check;
        input cond;
        input [200:0] msg;
        begin
            if(!cond)
                $display("FAIL %s",msg);
            else
                $display("PASS %s",msg);
        end
    endtask
    
    //Testcases
    initial begin
        //Default values
        zero=0;negative=0;overflow=0;funct7b5=0;
        carry_out=0;
        
        //-------------------------
        // TEST 1: ADD (R-type)
        //-------------------------
        opcode = 7'b0110011;
        funct3 = 3'b000;
        funct7b5 = 0;
        #1;
        
        check(ALUSrc==0,"ADD:ALUSrc");
        check(RegWrite==1,"ADD:RegWrite");
        check(PCSrc==0,"ADD:PCSrc");
        check(MemWrite== 0, "ADD: MemWrite");
        check(Jump    == 0, "ADD: Jump");
        check(ResultSrc == 2'b00, "ADD: ResultSrc");
        check(ImmSrc==0,"ADD: ImmSrc");
        
         //-------------------------
        // TEST 2: ADDI
        //-------------------------
        opcode = 7'b0010011;
        funct3 = 3'b000;
        #1;
        
        check(RegWrite == 1, "ADDI: RegWrite");
        check(ALUSrc  == 1, "ADDI: ALUSrc");
        check(ImmSrc  == 2'b00, "ADDI: ImmSrc");

        //-------------------------
        // TEST 3: LW
        //-------------------------
        opcode = 7'b0000011;
        funct3 = 3'b010;
        #1;

        check(RegWrite == 1, "LW: RegWrite");
        check(ResultSrc == 2'b01, "LW: ResultSrc");
        check(ALUSrc == 1, "LW: ALUSrc");

        //-------------------------
        // TEST 4: SW
        //-------------------------
        opcode = 7'b0100011;
        funct3 = 3'b010;
        #1;

        check(MemWrite == 1, "SW: MemWrite");
        check(RegWrite == 0, "SW: RegWrite");

        //-------------------------
        // TEST 5: BEQ (taken)
        //-------------------------
        opcode = 7'b1100011;
        funct3 = 3'b000; // BEQ
        zero   = 1;
        #1;

        check(PCSrc == 1, "BEQ taken");

        //-------------------------
        // TEST 6: BEQ (not taken)
        //-------------------------
        zero = 0;
        #1;

        check(PCSrc == 0, "BEQ not taken");

        //-------------------------
        // TEST 7: JAL
        //-------------------------
        opcode = 7'b1101111;
        #1;

        check(Jump == 1, "JAL: Jump");
        check(PCSrc == 1, "JAL: PCSrc");
        check(RegWrite == 1, "JAL: RegWrite");

        //-------------------------
        // TEST 8: JALR
        //-------------------------
        opcode = 7'b1100111;
        funct3 = 3'b000;
        #1;

        check(Jump == 1, "JALR: Jump");
        check(ALUSrc == 1, "JALR: ALUSrc");
        check(PCSrc == 1, "JALR: PCSrc");

        //-------------------------
        // TEST 9: LUI
        //-------------------------
        opcode = 7'b0110111;
        #1;

        check(RegWrite == 1, "LUI: RegWrite");
        check(ResultSrc == 2'b11, "LUI: ResultSrc");

        //-------------------------
        // TEST 10: AUIPC
        //-------------------------
        opcode = 7'b0010111;
        #1;

        check(RegWrite == 1, "AUIPC: RegWrite");
        check(ResultSrc == 2'b11, "AUIPC: ResultSrc");

        $display("\nCONTROL UNIT VERIFICATION PASSED");
        $finish;


        
        
    end
endmodule
