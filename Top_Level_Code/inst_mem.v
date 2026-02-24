`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.12.2025 10:30:19
// Design Name: 
// Module Name: inst_mem
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


module inst_mem #(parameter addr_width=32, data_width=32, mem_size=64) (read_add,inst_out);
    input [addr_width-1:0] read_add;
    output reg [data_width-1:0] inst_out;
    //ROM stores 64 instructions of 32 bits each
    reg [data_width-1:0] instmem [mem_size-1:0]; 
    wire [5:0] word_addr;

    // Word-aligned addressing (PC / 4)
    assign word_addr = read_add[7:2];
        
   integer i;
    initial begin
        for (i = 0; i < mem_size; i = i + 1)
            instmem[i] = 32'h00000013; // NOP = addi x0, x0, 0
    
        instmem[0] = 32'h01950533; // add x10, x10, x25
        instmem[1] = 32'h00941463; // bne x8, x9, +8 (example)
        instmem[2] = 32'h00052483; // lw x9, 0(x10)
    end
    
    always @(*) begin
        inst_out = instmem[word_addr];
    end
    
    //initial begin
        //$readmemh("rv32i_book.hex", instr_ram);
       // $readmemh("rv32i_test.hex", instr_ram);
    //end
    
    // word-aligned memory access
    // combinational read logic
    //assign instr = instr_ram[instr_addr[31:2]];
    
endmodule
