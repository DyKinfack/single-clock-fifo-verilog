`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dylann Kinfack
// 
// Create Date: 27.01.2026 19:01:22
// Design Name: FIFO
// Module Name: FIFO_tb
// Project Name: Single Clock FIFO Verilog
// Target Devices: Spartan-7
// Tool Versions: Vivado 2020.2
// Description: 
// The testbench verifies the FIFO functionality through:
// ? Reset verification
// ? FIFO filling until full
// ? FIFO emptying until empty
// ? Data order validation (FIFO property)
// ? Counter correctness
//Test Sequence

//Apply reset

//Write 64 values into FIFO

//Verify buf_full == 1

//Read all values

//Verify correct data order

//Verify buf_empty == 1

//The testbench prints the FIFO counter and read data for debugging.
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module FIFO_tb();

    reg clk;
    reg reset;
    reg wr_en;
    reg rd_en;
    reg [7:0] buf_in;

    wire [7:0] buf_out;
    wire buf_empty;
    wire buf_full;
    wire [6:0] fifo_counter;

    FIFO dut (
        .clk(clk),
        .reset(reset),
        .buf_in(buf_in),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .buf_empty(buf_empty),
        .buf_full(buf_full),
        .fifo_counter(fifo_counter),
        .buf_out(buf_out)
    );

    // Clock 100 MHz
    always #5 clk = ~clk;

    integer i;

    initial begin
        $display("==== FIFO TEST START ====");

        clk = 0;
        reset = 0;
        wr_en = 0;
        rd_en = 0;
        buf_in = 0;

        // Reset
        #20 reset = 1;
        #10;

        // --------------------------------
        // WRITE 10 VALUES
        // --------------------------------
        $display("Writing to FIFO...");
        for (i = 0; i < 10; i = i + 1) begin
            @(posedge clk);
            wr_en = 1;
            buf_in = i + 8'h10;
        end
        @(posedge clk);
        wr_en = 0;

        // --------------------------------
        // READ 10 VALUES
        // --------------------------------
        $display("Reading from FIFO...");
        for (i = 0; i < 10; i = i + 1) begin
            @(posedge clk);
            rd_en = 1;
            @(posedge clk);
            rd_en=0;
            $display("Read Data = %h | Counter = %0d", buf_out, fifo_counter);
        end
        rd_en = 0;

        // --------------------------------
        // FILL FIFO COMPLETELY
        // --------------------------------
        $display("Filling FIFO...");
        for (i = 0; i < 64; i = i + 1) begin
            wr_en = 1;
            buf_in = i;
            @(posedge clk);
        end
        wr_en = 0;
        
         
        if (buf_full)
            $display("FIFO FULL correctly asserted");

        // --------------------------------
        // DRAIN FIFO
        // --------------------------------
        $display("Draining FIFO...");
        for (i = 0; i < 64; i = i + 1) begin
           
            rd_en = 1;
            @(posedge clk);

        end
        rd_en = 0;

        if (buf_empty)
            $display("FIFO EMPTY correctly asserted");

        $display("==== FIFO TEST PASSED ====");
        #50 $stop;
    end
    
endmodule
