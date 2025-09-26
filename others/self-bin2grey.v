
module bin2gray (
    input  wire [7:0] in,
    output wire [7:0] out
);

    assign out = in ^ (in >> 1);

endmodule

module bin2gray (
    input  wire [7:0] in,
    output reg  [7:0] out
);

    integer i;

    always @(*) begin
        // note that in unsigned binary, MSB means the leftmost bit
        out[7] = in[7];  // MSB stays the same
        for (i = 6; i >= 0; i = i - 1) begin
            out[i] = in[i+1] ^ in[i];
        end
    end

endmodule
