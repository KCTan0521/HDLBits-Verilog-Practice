module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 

    parameter LEFT=0, RIGHT=1, FALL_L=2, FALL_R=3 ;
    reg[1:0] state;
    reg[1:0] next;
    
    always @(*) begin
        case (state)
            LEFT: next = ground ? (bump_left ? RIGHT : LEFT) : FALL_L;
            RIGHT: next = ground ? (bump_right ? LEFT : RIGHT) : FALL_R;
            FALL_L: next = ground ? LEFT: FALL_L;
            FALL_R: next = ground ? RIGHT: FALL_R;
        endcase
    end

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
        end
        else begin
            state <= next;
        end
    end

    assign walk_left = state == LEFT;
    assign walk_right = state == RIGHT;
    assign aaah = state == FALL_L || state == FALL_R;

endmodule
