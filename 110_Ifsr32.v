module top_module (
    input clk,
    input reset, // Active-high synchronous reset to 32'h1
    output [31:0] q
);

    reg [31:0] q_temp;
    integer i;

    always @(*) begin
        q_temp[31] = 1'b0 ^ q[0];

        for (i=30; i >= 0; i=i-1) begin
            // need to minus 1 for bit position
            if (i == 21 || i == 1 || i == 0 ) begin
                q_temp[i] = q[i+1] ^ q[0];
            end
            else begin
                q_temp[i] = q[i+1];
            end
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            q <= 32'h1;
        end
        else begin
            q <= q_temp;
        end
    end

endmodule