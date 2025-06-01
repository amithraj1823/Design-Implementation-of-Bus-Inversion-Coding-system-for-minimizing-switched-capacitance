module encoder (
    input wire clk,
    input wire rst,
    input wire in7, in6, in5, in4, in3, in2, in1, in0,
    output wire out7, out6, out5, out4, out3, out2, out1, out0,
    output reg invert
);
    reg [7:0] prev_data;
    wire [7:0] data_in = {in7, in6, in5, in4, in3, in2, in1, in0};
    reg [7:0] data_out;

    assign {out7, out6, out5, out4, out3, out2, out1, out0} = data_out;

    integer i;
    integer hamming_distance;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            prev_data <= 8'b0;
            data_out <= 8'b0;
            invert <= 0;
        end else begin
            hamming_distance = 0;
            for (i = 0; i < 8; i = i + 1)
                if (data_in[i] != prev_data[i])
                    hamming_distance = hamming_distance + 1;

            if (hamming_distance > 4) begin
                data_out <= ~data_in;
                invert <= 1;
            end else begin
                data_out <= data_in;
                invert <= 0;
            end

            prev_data <= data_in;
        end
    end
endmodule
