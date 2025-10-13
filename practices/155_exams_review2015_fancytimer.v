// kc dk how to combine, just reference the sample answer from GitHub
module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack );

    parameter A=0, B=1, C=2, D=3, DELAY1=4, DELAY2=5, DELAY3=6, DELAY4=7, COUNTING=8, DONE=9;
    reg [3:0] state, next_state;
    reg [9:0] counter;

    // fsm
    always @(*) begin
        case (state) 
            A: next_state = data ? B : A;
            B: next_state = data ? C : A;
            C: next_state = data ? C : D;
            D: next_state = data ? DELAY1 : A;
            DELAY1: next_state = DELAY2;
            DELAY2: next_state = DELAY3;
            DELAY3: next_state = DELAY4;
            DELAY4: next_state = COUNTING;
            COUNTING: next_state = (count == 0 && counter == 999) ? DONE : COUNTING;
            DONE: next_state = ack ? A : DONE;
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            count <= 0;
            counter <= 0;
        end
        else begin
            case (state) 
                DELAY1: count[3] <= data;
                DELAY2: count[2] <= data;
                DELAY3: count[1] <= data;
                DELAY4: count[0] <= data;
                COUNTING: begin
                    if (count >= 0) begin
                        if (counter < 999) begin
                            counter <= counter + 1;
                        end
                        else begin
                            count <= count - 1;
                            counter <= 0;
                        end
                    end
                end                
                default: counter <= 0;
            endcase
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            state <= A;
        end
        else begin
            state <= next_state; 
        end
    end

    assign counting = state == COUNTING;
    assign done = state == DONE;

endmodule
