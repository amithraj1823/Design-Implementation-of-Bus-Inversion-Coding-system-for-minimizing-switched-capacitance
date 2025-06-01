`include "encoder.v"
`include "decoder.v"

module top (
    input wire clk,
    input wire rst,
    input wire select, // 0 = encode, 1 = decode

    input wire in7,
    input wire in6,
    input wire in5,
    input wire in4,
    input wire in3,
    input wire in2,
    input wire in1,
    input wire in0,

    input wire [7:0] prev_data,
    input wire invert_in, // for decode mode

    output wire out7,
    output wire out6,
    output wire out5,
    output wire out4,
    output wire out3,
    output wire out2,
    output wire out1,
    output wire out0,

    output reg invert // valid in encode mode
);

    wire [7:0] data_in;
    wire [7:0] encoded_data;
    wire encoder_invert;
    wire [7:0] decoded_data;
    reg  [7:0] data_out;

    // Combine individual input bits into a byte
    assign data_in = {in7, in6, in5, in4, in3, in2, in1, in0};

    // Split output byte into individual bits
    assign out7 = data_out[7];
    assign out6 = data_out[6];
    assign out5 = data_out[5];
    assign out4 = data_out[4];
    assign out3 = data_out[3];
    assign out2 = data_out[2];
    assign out1 = data_out[1];
    assign out0 = data_out[0];

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
