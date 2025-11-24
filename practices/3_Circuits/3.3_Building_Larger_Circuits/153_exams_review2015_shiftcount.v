module top_module (
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output [3:0] q);

    reg [3:0] temp_data;

    always @(posedge clk) begin
        temp_data <= temp_data;

        if (shift_ena) begin
            temp_data <= (temp_data << 1) + data;
        end

        if (count_ena) begin
            temp_data <= temp_data - 1'b1;
        end
        
    end

    assign q = temp_data;

endmodule
