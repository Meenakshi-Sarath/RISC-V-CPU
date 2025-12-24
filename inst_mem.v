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
    integer i;
    
   initial begin
       instmem[0]=32'b0000000_11001_01010_000_01010_0110011;   // add x10, x10, x25
       instmem[1]=32'b0000000_01000_01001_001_01100_1100011;  // bne x9, x24, Exit
       instmem[2]=32'b000000000000_01001_000_01001_0000011;   // lw x9, 0(x10)
    end
    
    assign instr=instmem[read_add];
    
    //initial begin
        //$readmemh("rv32i_book.hex", instr_ram);
       // $readmemh("rv32i_test.hex", instr_ram);
    //end
    
    // word-aligned memory access
    // combinational read logic
    //assign instr = instr_ram[instr_addr[31:2]];
    
endmodule
