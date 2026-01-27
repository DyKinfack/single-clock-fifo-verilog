`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dylann Kinfack
// 
// Create Date: 27.01.2026 18:14:54
// Design Name: Single FIFO
// Module Name: FIFO
// Project Name: Single Clock FIFO Verilog
// Target Devices: Spartan-7
// Tool Versions: Vivado 2020.2
// Description: The FIFO module implements a 64×8 memory buffer with:
// Ports
// Signal	Direction	Description
// clk	input	System clock
// reset	input	Active-low synchronous reset
// buf_in[7:0]	input	Data input
// wr_en	input	Write enable
// rd_en	input	Read enable
// buf_out[7:0]	output	Data output
// buf_empty	output	FIFO empty flag
// buf_full	output	FIFO full flag
// fifo_counter[6:0]	output	Number of stored elements 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module FIFO(
    input clk,
    input reset,
    input [7:0] buf_in,
    input wr_en,
    input rd_en,
    output  buf_empty,
    output  buf_full,
    output reg [6:0] fifo_counter,
    output reg [7:0] buf_out
    );
 
    reg [7:0] ram [0:63];
    reg [6:0] rd_ptr, wr_ptr;
    
 
     assign buf_empty = ( fifo_counter == 0);
     assign buf_full = ( fifo_counter == 64);
 
    // counter logic
    always @(posedge clk)
     begin
        if(!reset)
            fifo_counter <=0;
        else if( (!buf_full && wr_en) && (!buf_empty && rd_en))
            fifo_counter <= fifo_counter;
        else if ( !buf_full && wr_en)
            fifo_counter <= fifo_counter +1;
        else if (!buf_empty && rd_en)
            fifo_counter <= fifo_counter - 1;
        else
            fifo_counter <= fifo_counter;
        
    end
    
    // read Operation
    always @(posedge clk) begin
        if(!reset)
            buf_out <=0;
        else begin
            if(!buf_empty && rd_en)
                buf_out <= ram[rd_ptr];
        end
    end
    
    // write Operation
    always @(posedge clk)
        if(!buf_full && wr_en)
            ram[wr_ptr] <= buf_in;      
    
    // read pointer operation
    always @(posedge clk)
        if(!reset)
            rd_ptr <=0;
        else begin
            if(!buf_empty && rd_en)
                if(rd_ptr == 63)
                    rd_ptr <= 0;
                    
                else
                    rd_ptr <= rd_ptr +1;
            else 
                rd_ptr <= rd_ptr;
        end
    
    // write pointer operation
    always @(posedge clk)
        if(!reset)
            wr_ptr <=0;
        else begin
            if(!buf_full && wr_en)
                if( wr_ptr == 63)
                     wr_ptr <=0;
                else
                    wr_ptr <= wr_ptr +1; 
                     
            else
             wr_ptr <= wr_ptr;
        end
                
    
endmodule
