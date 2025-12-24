`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.12.2025 13:38:23
// Design Name: 
// Module Name: data_mem
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


module data_mem #(parameter data_width=32, mem_size=64, addr_width=32)(funct3,clk,w_en,rd_data,wr_data,wr_addr);
    input [data_width-1:0] wr_data;
    input [addr_width-1:0] wr_addr;
    output reg [data_width-1:0] rd_data;
    input clk,w_en;
    input [2:0] funct3;
    
    reg [data_width-1:0] dataram [mem_size-1:0];
    
    wire [data_width-1:0] word_address;
    //%64 is done to avoid any mishaps makes sure number stays between 0-63
    assign word_address=wr_addr[data_width-1:2]%64; // word_address = wr_addr/4 because byte addressable
    
    //Combinational read logic
    always @ (*) begin
        case(funct3)
            3'b000:begin //lb- load byte sign extended
                case(wr_addr[1:0])// offset value 
                    2'b00: rd_data= {{24{dataram[word_address][7]}},dataram[word_address][7:0]};
                    2'b01: rd_data= {{24{dataram[word_address][15]}},dataram[word_address][15:8]};
                    2'b10: rd_data= {{24{dataram[word_address][23]}},dataram[word_address][23:9]};
                    2'b11: rd_data= {{24{dataram[word_address][31]}},dataram[word_address][31:24]};
                    default: rd_data=32'd0;
                endcase
                
            end
            
            3'b001:begin //lh- load half word signed
                case(wr_addr[1])
                    1'b0: rd_data= {{16{dataram[word_address][15]}},dataram[word_address][15:0]};
                    1'b1: rd_data= {{16{dataram[word_address][31]}},dataram[word_address][31:16]};
                endcase
            end
            
            3'b010:begin //lw - load word signed
                rd_data= dataram[word_address];
            end
            
            3'b100:begin //lbu- load byte unsigned
                case(wr_addr[1:0])// offset value 
                    2'b00: rd_data= {{24'b0},dataram[word_address][7:0]};
                    2'b01: rd_data= {{24'b0},dataram[word_address][15:8]};
                    2'b10: rd_data= {{24'b0},dataram[word_address][23:9]};
                    2'b11: rd_data= {{24'b0},dataram[word_address][31:24]};
                    default: rd_data=32'd0;
                endcase
            end
            3'b101:begin //lhu -load half word unsigned
                case(wr_addr[1])
                    1'b0: rd_data= {16'b0,dataram[word_address][15:0]};
                    1'b1: rd_data= {16'b0,dataram[word_address][31:16]};
                endcase
            end
            
            default:rd_data= dataram[word_address]; // default to word
        endcase
    end
    
    //Sequential Write Logic
    always @ (posedge clk) begin
        case(funct3)
            3'b000:begin //sb -store byte 
                case(wr_addr[1:0])
                    2'b00: dataram[word_address][7:0]<=wr_data[7:0];
                    2'b01: dataram[word_address][15:8]<=wr_data[7:0];
                    2'b10: dataram[word_address][23:16]<=wr_data[7:0];
                    2'b11: dataram[word_address][31:23]<=wr_data[7:0];
                endcase
            end
            
            3'b001:begin // sh - store half word
                case(wr_addr[1])
                    1'b0: dataram[word_address][15:0]  <= wr_data[15:0];
                    1'b1: dataram[word_address][31:16] <= wr_data[15:0];
                endcase
            end
            
            3'b010:begin // sw - store word
            dataram[word_address]<=wr_data;
            end 
            
            default:begin // default to word store
                dataram[word_address] <= wr_data;
            end
        endcase
    end

endmodule