module gray2bin (
    input  wire [7:0] gray,
    output reg [7:0] bin
);
    integer i;

    always @(*) begin
        bin[7] = gray[7];

        for (i=6; i >= 0; i=i-1) begin
            bin[i] = gray[i] ^ bin[i+1];
        end
    end

endmodule
