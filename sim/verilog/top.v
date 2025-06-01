`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.06.2025 10:26:08
// Design Name: 
// Module Name: top
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


module top (
    input wire clk,
    input wire rst,
    input wire select, // 0 = encode, 1 = decode
    input wire [7:0] data_in,
    input wire [7:0] prev_data,
    input wire invert_in,           // for decode mode
    output reg [7:0] data_out,
    output reg invert               // valid in encode mode
);

    wire [7:0] encoded_data;
    wire encoder_invert;
    wire [7:0] decoded_data;

    encoder enc (
        .data_in(data_in),
        .prev_data(prev_data),
        .data_out(encoded_data),
        .invert(encoder_invert)
    );

    decoder dec (
        .data_in(data_in),
        .invert(invert_in),
        .data_out(decoded_data)
    );

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            data_out <= 8'b0;
            invert <= 0;
        end else begin
            if (select == 0) begin // encode
                data_out <= encoded_data;
                invert <= encoder_invert;
            end else begin // decode
                data_out <= decoded_data;
                invert <= 0;
            end
        end
    end
endmodule

