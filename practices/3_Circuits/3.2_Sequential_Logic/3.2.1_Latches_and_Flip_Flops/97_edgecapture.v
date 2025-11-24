module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);

    reg [31:0] prev_in;
    integer i;
    
    always @(posedge clk) begin
        for (i=0; i < $bits(in); i=i+1) begin
            if (prev_in[i] & ~in[i]) begin
                out[i] <= 1;
            end
        end

        if (reset) begin
            out <= 32'b0;
        end
        
        prev_in <= in;
    end

endmodule
