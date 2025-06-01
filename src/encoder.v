module encoder (
    input wire [7:0] data_in,
    input wire [7:0] prev_data,
    output reg [7:0] data_out,
    output reg invert
);
    integer i;
    reg [3:0] hamming_distance;

    always @(*) begin
        hamming_distance = 0;
        for (i = 0; i < 8; i = i + 1) begin
            if (data_in[i] != prev_data[i])
                hamming_distance = hamming_distance + 1;
        end

        if (hamming_distance > 4) begin
            data_out = ~data_in;
            invert = 1;
        end else begin
            data_out = data_in;
            invert = 0;
        end
    end
endmodule
