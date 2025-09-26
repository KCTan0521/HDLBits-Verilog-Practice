module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //

    // FSM from fsm_ps2
    parameter B1=0, B2=1, B3=2, DONE=3;
    reg [3:0] state, next;
    reg [24:0] data;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            B1: next = in[3] ? B2 : B1;
            B2: next = B3;
            B3: next = DONE;
            DONE: next = in[3] ? B2 : B1;
        endcase
    end

    // State flip-flops (sequential)
    always @(posedge clk) begin
        if (reset) begin
            state <= B1;
            data <= '0;
        end
        else begin
            state <= next;
            data[23:16] <= data[15:8];
            data[15:8] <= data[7:0];
            data[7:0] <= in;            
        end
    end

    // Output logic
    assign done = state == DONE;
    assign out_bytes = (done) ? data : 24'd0; 

endmodule
