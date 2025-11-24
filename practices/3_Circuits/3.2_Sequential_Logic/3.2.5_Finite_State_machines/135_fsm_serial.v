module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 

    parameter S1=0, S2=1, S3=2, S4=3, S5=4, S6=5, S7=6, S8=7, START=8, STOP=9, ERROR=10;
    reg [3:0] state, next;
    // reg [7:0] data;

    always @(*) begin
        case (state)
            START: next = in ? START : S1;
            S1: next = S2;
            S2: next = S3;
            S3: next = S4;
            S4: next = S5;
            S5: next = S6;
            S6: next = S7;
            S7: next = S8;
            S8: next = STOP;
            STOP: next = in ? START : ERROR;
            ERROR: next = in ? START : ERROR;
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            state <= START;
        end
        else begin
            state <= next;
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            done <= 0;
        end
        else begin
            done <= state == STOP && in == 1;
        end
    end

endmodule


// sample answer from ChatGPT
module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output reg done
);

    // State encoding using localparam
    localparam IDLE  = 4'd0;
    localparam DATA0 = 4'd1;
    localparam DATA1 = 4'd2;
    localparam DATA2 = 4'd3;
    localparam DATA3 = 4'd4;
    localparam DATA4 = 4'd5;
    localparam DATA5 = 4'd6;
    localparam DATA6 = 4'd7;
    localparam DATA7 = 4'd8;
    localparam STOP  = 4'd9;
    localparam ERROR = 4'd10;

    reg [3:0] state, next_state;

    // FSM next state logic
    always @(*) begin
        case (state)
            IDLE:   next_state = (in == 0) ? DATA0 : IDLE;
            DATA0:  next_state = DATA1;
            DATA1:  next_state = DATA2;
            DATA2:  next_state = DATA3;
            DATA3:  next_state = DATA4;
            DATA4:  next_state = DATA5;
            DATA5:  next_state = DATA6;
            DATA6:  next_state = DATA7;
            DATA7:  next_state = STOP;
            STOP:   next_state = (in == 1) ? IDLE : ERROR;
            ERROR:  next_state = (in == 1) ? IDLE : ERROR;
            default: next_state = IDLE;
        endcase
    end

    // FSM state register
    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Output logic: done is high for one cycle when valid byte received
    always @(posedge clk) begin
        if (reset)
            done <= 0;
        else
            done <= (state == STOP) && (in == 1);
    end

endmodule


// sample answer from GitHub
module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 

    reg [3:0] i;
    parameter rc = 0, dn = 1, rd = 2, err = 3;
    reg [2:0] state, next_state;

    always @(*) begin
        case (state)
            rd: next_state <= in ? rd : rc;
            rc: begin
                if ((i == 8) & in) begin
                    next_state <= dn;
                end
                else if ((i == 8) & (~in)) begin
                    next_state <= err;
                end
                else begin
                    next_state <= rc;
                end
            end
            dn: next_state <= in ? rd : rc;
            err: next_state <= in ? rd : err;
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            state <= rd;
            i <= 0;
        end
        else begin
            if ((state == rc) && (i != 8)) begin
                i <= i + 1;
            end
            else if (state == err) begin
                i <= 0;
            end
            else if (state == dn) begin
                i <= 0;
            end
            state <= next_state;
        end
    end

    assign done = (state == dn);

endmodule