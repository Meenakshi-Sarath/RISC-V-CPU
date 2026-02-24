`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.12.2025 11:04:45
// Design Name: 
// Module Name: ALU_decoder
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


module ALU_decoder(ALU_ctrl,ALU_op,funct3,funct7b5,opb5);
    input [1:0] ALU_op;
    input [2:0] funct3;
    //funct7b5 of 6 if set 1 is what distinguishes R type ADD (when 0) AND SUB (1)
    //But I type ADDI has no funct7- how to distinguish bw R and I type so that
    // ADDI is not mistaken for SUB?
    //opb5 of 0-6 : when 1 with funct7b5=1: R type sub, when opb5=0: ADDI/ADD
    input funct7b5,opb5; 
    output reg [3:0] ALU_ctrl;
    
    always @ (*) begin
        case (ALU_op)
            2'b00: ALU_ctrl=4'b0000; //add- lw/sw
            2'b01: ALU_ctrl=4'b0001; //subtract- branch
            default:
                    case (funct3)
                        3'b000: //R type of I type ALU
                            begin
                                if (funct7b5 && opb5)
                                    ALU_ctrl=4'b0001; //true for R type SUB
                                else
                                    ALU_ctrl=4'b0000; //ADD or ADDI
                            end
                        3'b001: ALU_ctrl=4'b1001; //SLL
                        3'b010: ALU_ctrl=4'b0101; //SLT
                        3'b011: ALU_ctrl=4'b1000; //SLTU
                        3'b100: ALU_ctrl=4'b0100; //XOR
                        3'b101: begin
                                    if (funct7b5)
                                        ALU_ctrl= 4'b0111;//SRA
                                    else
                                        ALU_ctrl=4'b0110; //SRL
                                end
                        3'b110: ALU_ctrl=4'b0011; //OR
                        3'b111: ALU_ctrl=4'b0010; //AND
                        default: ALU_ctrl=4'bxxxx; //undefined
                    endcase
        endcase
    end
endmodule
