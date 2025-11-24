module top_module (
    input clk,
    input a,
    output [3:0] q );

    reg [3:0] counter;

    always @(posedge clk) begin
        if (a) begin
            counter <= 4'd4;
        end
        else begin
            if (counter < 4'd6) begin
                counter <= counter + 4'd1;
            end
            else begin
                counter <= 4'd0;
            end
        end
    end

    assign q = counter;

endmodule
