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

    input wire invert_in, // used during decode

    output wire out7,
    output wire out6,
    output wire out5,
    output wire out4,
    output wire out3,
    output wire out2,
    output wire out1,
    output wire out0,

    output wire invert_out // valid only in encode mode
);

    wire [7:0] encoder_out, decoder_out;
    wire encoder_invert;

    // Internal encoder instance
    encoder enc (
        .clk(clk),
        .rst(rst),
        .in7(in7), .in6(in6), .in5(in5), .in4(in4),
        .in3(in3), .in2(in2), .in1(in1), .in0(in0),
        .out7(encoder_out[7]), .out6(encoder_out[6]),
        .out5(encoder_out[5]), .out4(encoder_out[4]),
        .out3(encoder_out[3]), .out2(encoder_out[2]),
        .out1(encoder_out[1]), .out0(encoder_out[0]),
        .invert(encoder_invert)
    );

    // Internal decoder instance
    decoder dec (
        .in7(in7), .in6(in6), .in5(in5), .in4(in4),
        .in3(in3), .in2(in2), .in1(in1), .in0(in0),
        .invert(invert_in),
        .out7(decoder_out[7]), .out6(decoder_out[6]),
        .out5(decoder_out[5]), .out4(decoder_out[4]),
        .out3(decoder_out[3]), .out2(decoder_out[2]),
        .out1(decoder_out[1]), .out0(decoder_out[0])
    );

    assign {out7, out6, out5, out4, out3, out2, out1, out0} = (select == 0) ? encoder_out : decoder_out;
    assign invert_out = (select == 0) ? encoder_invert : 1'b0;

endmodule
