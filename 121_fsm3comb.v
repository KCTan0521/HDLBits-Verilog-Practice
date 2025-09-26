// kc answer
module top_module(
    input in,
    input [1:0] state,
    output [1:0] next_state,
    output out); //

    parameter A=0, B=1, C=2, D=3;

    // State transition logic: next_state = f(state, in)
    always @(*) begin
        case (state)
            2'b00: next_state = in ? B:A;
            2'b01: next_state = in ? B:C;
            2'b10: next_state = in ? D:A;
            2'b11: next_state = in ? B:C;
        endcase
    end

    // Output logic:  out = f(state) for a Moore state machine
    assign out = state == D;

endmodule
