module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);

    reg [7:0] prev_in;
    integer i;

    always @(posedge clk) begin
        for (i=0; i < $bits(in); i=i+1) begin
            anyedge[i] <= prev_in[i] ^ in[i];
        end

        prev_in <= in;
    end

endmodule