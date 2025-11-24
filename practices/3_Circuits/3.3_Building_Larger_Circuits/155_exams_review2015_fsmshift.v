module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);

    reg [2:0] counter = 3'b0;

    always @(posedge clk) begin
        if (reset) begin
            counter <= 3'b0;
        end
        else begin
            if (counter < 3'd4) begin
                counter <= counter + 1'b1;
            end
            else begin
                counter <= counter;
            end
        end
    end

    assign shift_ena = counter < 3'd4;

endmodule
