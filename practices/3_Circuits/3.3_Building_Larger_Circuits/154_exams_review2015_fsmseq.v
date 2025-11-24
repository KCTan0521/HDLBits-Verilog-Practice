module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting);

    parameter A=0, B=1, C=2, D=3, FINAL=4;
    reg [2:0] state, next_state;

    always @(*) begin
        case (state)
            A: next_state = data ? B : A;
            B: next_state = data ? C : A;
            C: next_state = data ? C : D;
            D: next_state = data ? FINAL : A;
            FINAL: next_state = FINAL;
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            state <= A;
        end
        else begin
            state <= next_state;
        end
    end

    assign start_shifting = state == FINAL;

endmodule
