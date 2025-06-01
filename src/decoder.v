module decoder (
    input wire in7, in6, in5, in4, in3, in2, in1, in0,
    input wire invert,
    output wire out7, out6, out5, out4, out3, out2, out1, out0
);
    wire [7:0] data_in = {in7, in6, in5, in4, in3, in2, in1, in0};
    wire [7:0] data_out = invert ? ~data_in : data_in;

    assign {out7, out6, out5, out4, out3, out2, out1, out0} = data_out;
endmodule
