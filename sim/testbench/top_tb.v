`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.06.2025 10:26:28
// Design Name: 
// Module Name: top_tb
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


module top_tb;

    reg clk, rst;
    reg select;
    reg [7:0] data_in, prev_data;
    reg invert_in;
    wire [7:0] data_out;
    wire invert;

    top uut (
        .clk(clk),
        .rst(rst),
        .select(select),
        .data_in(data_in),
        .prev_data(prev_data),
        .invert_in(invert_in),
        .data_out(data_out),
        .invert(invert)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin

        clk = 0;
        rst = 1;
        select = 0;
        data_in = 8'b0;
        prev_data = 8'b0;
        invert_in = 0;

        #10;
        rst = 0;

        // ENCODE: Few transitions (no inversion expected)
        prev_data = 8'b00000000;
        data_in = 8'b00001111;
        select = 0; // Encode
        #10;

        // ENCODE: Many transitions (inversion expected)
        prev_data = data_in;
        data_in = 8'b11110000;
        #10;

        // Capture output to feed into decoder
        invert_in = invert;
        data_in = data_out;  // encoded data
        select = 1; // Decode
        #10;

        // Decode again with different invert bit
        invert_in = 0;
        #10;

        $finish;
    end
endmodule

