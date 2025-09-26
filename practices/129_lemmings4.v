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

    parameter LEFT=0, RIGHT=1, FALL_L=2, FALL_R=3, DIG_L=4, DIG_R=5, SPLATTER=6;
    reg[2:0] state;
    reg[2:0] next;

    // kc thinks need to use 32 bits here
    // because the falling state can be very long
    // and the clk_counter will overflow when there are too many clk cycle to add
    // then after overflow the counter will auto back to 0 and recount
    // hence using a 32 bits counter can reduce overflow issue
    reg [31:0] clk_counter;

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
            FALL_L: begin
                if (ground) begin
                    if (clk_counter > 19) begin
                        next = SPLATTER;
                    end
                    else begin
                        next = LEFT;
                    end
                end
                else begin
                    next = FALL_L;
                end
            end
            FALL_R: begin
                if (ground) begin
                    if (clk_counter > 19) begin
                        next = SPLATTER;
                    end
                    else begin
                        next = RIGHT;
                    end
                end
                else begin
                    next = FALL_R;
                end
            end
            SPLATTER: begin
                next = SPLATTER;
                // for positive areset will reset the state
                // and there are also no state to transfer after SPLATTER
            end
        endcase
    end

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
            clk_counter <= 0;
        end
        else begin
            if (state == FALL_L || state == FALL_R) begin
                clk_counter <= clk_counter + 1;
            end
            else begin
                clk_counter <= 0;
            end
            state <= next;
        end
    end

    assign walk_left = state == LEFT;
    assign walk_right = state == RIGHT;
    assign aaah = (state == FALL_L || state == FALL_R);
    assign digging = (state == DIG_L || state == DIG_R);
    
endmodule


// sample answer from GitHub
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

    parameter left=3'd0, right=3'd1, falll=3'd2, fallr=3'd3, digl=3'd4, digr=3'd5, splat=3'd6;
    reg [2:0] state, next_state;
    reg [31:0] count;

    always@(posedge clk or posedge areset) begin
        if(areset)
            state <= left;
        else if(state == falll || state == fallr) begin
            state <= next_state;
            count <= count + 1;
        end
        else begin
            state <= next_state;
            count <= 0;
        end
    end

    always@(*) begin
        case(state)
            left: begin
                if(~ground)         next_state = falll;
                else if(dig)        next_state = digl;
                else if(bump_left)  next_state = right;
                else                next_state = left;
            end
            right: begin
                if(~ground)         next_state = fallr;
                else if(dig)        next_state = digr;
                else if(bump_right) next_state = left;
                else                next_state = right;
            end
            falll: begin
                if(ground) begin
                    if(count>19)    next_state = splat;
                    else            next_state = left;
                end
                else                next_state = falll;
            end
            fallr: begin
                if(ground) begin
                    if(count>19)    next_state = splat;
                    else            next_state = right;
                end
                else                next_state = fallr;
            end
            digl: begin
                if(ground)  next_state = digl;
                else        next_state = falll;
            end
            digr: begin
                if(ground)  next_state = digr;
                else        next_state = fallr;
            end
            splat: begin
                next_state = splat;
            end
        endcase
    end

    assign  walk_left = (state == left);
    assign  walk_right = (state == right);
    assign  aaah = (state == falll || state == fallr);
    assign  digging = (state == digl || state == digr);

endmodule