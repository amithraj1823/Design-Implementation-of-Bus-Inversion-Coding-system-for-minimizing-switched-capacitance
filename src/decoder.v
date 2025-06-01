module decoder (
    input wire [7:0] data_in,
    input wire invert,
    output wire [7:0] data_out
);
    assign data_out = invert ? ~data_in : data_in;
endmodule
