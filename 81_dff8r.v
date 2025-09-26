module top_module (
    input clk,
    input reset,         // Synchronous active high reset
    input [7:0] d,
    output reg [7:0] q
);

    always @(posedge clk) begin
        if (reset)
            q <= 8'b0;      // Reset all flip-flops to 0 synchronously
        else
            q <= d;         // Load input d into q on clock edge
    end

endmodule
