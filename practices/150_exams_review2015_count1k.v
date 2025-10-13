// kc answer 
module top_module (
    input clk,
    input reset,
    output [9:0] q
);
    reg [9:0] counter;

    always @(posedge clk) begin
        if (reset || counter == 12'd999) begin
            counter <= 0;
        end
        else begin
            counter <= counter + 1'd1;
        end
    end

    assign q = counter;

endmodule