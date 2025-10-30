module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output [1:0] state
);
    parameter SNT = 0, WNT = 1, WT = 2, ST = 3;
    reg [1:0] state_t;
    reg [1:0] next;

    always @(*) begin
        if (train_valid) begin
            case (state_t) 
                SNT: next = train_taken ? WNT : SNT;
                WNT: next = train_taken ? WT : SNT;
                WT: next = train_taken ? ST : WNT;
                ST: next = train_taken ? ST : WT;
            endcase
        end
        else begin
            next = state_t;
            // NOT next = next
            // because will create latches and cause result to be wrong
        end
    end

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state_t <= WNT;
        end
        else begin
            state_t <= next;
        end
    end

    assign state = state_t;


endmodule
