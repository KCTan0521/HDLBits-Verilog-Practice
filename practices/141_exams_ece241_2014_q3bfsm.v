module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output z
);

    reg[2:0] state, next; // represent y

    always @(*) begin
        case (state)
            3'b000: next = x ? 3'b001 : 3'b000;
            3'b001: next = x ? 3'b100 : 3'b001;
            3'b010: next = x ? 3'b001 : 3'b010;
            3'b011: next = x ? 3'b010 : 3'b001;
            3'b100: next = x ? 3'b100 : 3'b011;
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b000;
        end
        else begin
            state <= next;
        end
    end

    assign z = (state == 3'b011 || state == 3'b100);

endmodule
