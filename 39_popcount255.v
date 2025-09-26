module top_module(
    input [254:0] in,
    // add a reg to output
    output reg [7:0] out
);
    integer i;
    always @(*) begin
        out = 8'b0; // assign a default value to out inside the always
        for (i=0; i < $bits(in); i=i+1) begin
            if (in[i]) begin
                out = out + 1'b1;
            end
        end
    end

endmodule
