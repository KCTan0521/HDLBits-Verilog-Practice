module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 

    parameter LEFT=0, RIGHT=1, FALL_L=2, FALL_R=3, DIG_L=4, DIG_R=5 ;
    reg[2:0] state;
    reg[2:0] next;
    
    always @(*) begin
        next = state;

        // assign 'x to next also correct
        // next = 'x;
        
        case (state)
            LEFT: begin
                if (ground) begin 
                    if (dig) begin
                        next = DIG_L;
                    end
                    else if (bump_left) begin
                        next = RIGHT;
                    end
                    else begin // bump_left = 0
                        next = LEFT;
                    end
                end
                else begin
                    next = FALL_L;
                end 
            end
            RIGHT: begin
                if (ground) begin 
                    if (dig) begin
                        next = DIG_R;
                    end
                    else if (bump_right) begin
                        next = LEFT;
                    end
                    else begin // bump_right = 0
                        next = RIGHT;
                    end
                end
                else begin
                    next = FALL_R;
                end 
            end
            DIG_L: begin
                if (ground) begin
                    if (dig) begin
                        next = DIG_L;
                    end
                end
                else begin
                    next = FALL_L;
                end
            end
            DIG_R: begin
                if (ground) begin
                    if (dig) begin
                        next = DIG_R;
                    end
                end
                else begin
                    next = FALL_R;
                end
            end
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
    assign digging = state == DIG_L || state == DIG_R;

endmodule
