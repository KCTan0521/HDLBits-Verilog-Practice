module top_module (
    input clk,
    input a,
    output q );

    always @(posedge clk) begin
        if (a) begin
            q <= 1'b0;
        end
        else begin
            q <= 1'b1;
        end
    end

endmodule
