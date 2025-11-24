// kc answer version 2
module top_module(
    input clk,
    input areset, // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

    parameter LEFT=0, RIGHT=1;
    reg state, next_state;

    always @(*) begin
         // State transition logic
        case (state)
            LEFT: next_state = bump_left ? RIGHT : LEFT;
            RIGHT: next_state = bump_right ? LEFT : RIGHT;
        endcase
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if (areset) begin
            state <= LEFT;
        end
        else begin
            state <= next_state;
        end
    end
    
    // Output logic
    assign walk_left = state == LEFT;
    assign walk_right = state == RIGHT;

endmodule


// kc answer version 1
module top_module(
    input clk,
    input areset, // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

    parameter LEFT=0, RIGHT=1;
    reg state, next_state;

    always @(*) begin
        // State transition logic 
        next_state = state; // Default: stay in current state
        if (bump_left && bump_right) next_state = !state;
        else if (bump_left) next_state = RIGHT;
        else if (bump_right) next_state = LEFT;
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if (areset) begin
            state <= LEFT;
        end
        else begin
            state <= next_state;
        end
    end
    
    // Output logic
    assign walk_left = state == LEFT;
    assign walk_right = state == RIGHT;

endmodule