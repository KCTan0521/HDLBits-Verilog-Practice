module top_module (
    input clk,
    input slowena,
    input reset,
    output [3:0] q
);
    always @(posedge clk) begin
        if (slowena) begin
            q = q + 1'b1;
        end
        if (reset || q == 4'd10) begin
            q = 4'b0;
        end
    end

endmodule