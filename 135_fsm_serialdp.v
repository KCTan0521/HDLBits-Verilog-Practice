// kc answer
module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); 

    parameter S1=0, S2=1, S3=2, S4=3, S5=4, S6=5, S7=6, S8=7;
    parameter IDLE=8, START=9, STOP=10, ERROR=11, CHECK=12;
    reg [3:0] state, next;
    reg [7:0] data;
    wire odd, reset_p;
    reg done_reg;

    always @(*) begin
        case (state)
            IDLE: next = in ? IDLE : START;
            START: next = S1;
            S1: next = S2;
            S2: next = S3;
            S3: next = S4;
            S4: next = S5;
            S5: next = S6;
            S6: next = S7;
            S7: next = S8;
            S8: next = CHECK;
            CHECK: next = in ? IDLE : ERROR;
            ERROR: next = in ? IDLE : ERROR;
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end
        else begin
            state <= next;
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            data <= 8'd0;
            reset_p <= 1'b1;
            done_reg <= 1'b0;
        end
        else begin
            case (next)
                S1, S2, S3, S4, S5, S6, S7, S8: begin
                    data <= {in, data[7:1]};  // shift right, LSB first
                end
                START: begin
                    data <= 8'd0;
                    reset_p <= 1'b0;
                    done_reg <= 1'b0;
                end
                IDLE: begin
                    done_reg <= odd;
                end
                CHECK: begin
                    reset_p <= 1'b1;
                end
            endcase
        end
    end

    assign done = done_reg;
    assign out_byte = (done) ? data : 8'd0; 
    parity par_mod(clk, reset | reset_p, in, odd);

endmodule


// provided by question
module parity (
    input clk,
    input reset,
    input in,
    output reg odd);

    always @(posedge clk)
        if (reset) odd <= 0;
        else if (in) odd <= ~odd;

endmodule


// sample answer from GitHub
module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    // Modify FSM and datapath from Fsm_serialdata
    parameter idle = 4'd0, start = 4'd1, trans0 = 4'd2,trans1 = 4'd3, trans2 = 4'd4, trans3 = 4'd5;
    parameter trans4 = 4'd6, trans5 = 4'd7, trans6 = 4'd8, trans7 = 4'd9, stop = 4'd10, err = 4'd11, pari = 4'd12;
    reg [3:0] state, next_state;
    reg [7:0] data;
    wire odd, reset_p;
    reg done_reg;

    always @(*) begin
        case (state)
            idle:   next_state <= in ? idle : start;
            start:  next_state <= trans0;
            trans0: next_state <= trans1;
            trans1: next_state <= trans2;
            trans2: next_state <= trans3;
            trans3: next_state <= trans4;
            trans4: next_state <= trans5;
            trans5: next_state <= trans6;
            trans6: next_state <= trans7;
            trans7: next_state <= pari;
            pari:   next_state <= in ? idle : err;
            err:    next_state <= in ? idle : err;
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            state <= idle;
        end
        else begin
            state <= next_state;
        end
    end

    // New: Add parity checking.
    always @(posedge clk) begin
        if (reset) begin
            data <= 8'd0;
            reset_p <= 1'b1;
            done_reg <= 1'b0;
        end
        else begin
            if (next_state == trans0 || next_state == trans1 || next_state == trans2 || next_state == trans3 || next_state == trans4 || next_state == trans5 || next_state == trans6 || next_state == trans7) begin
                data <= {in, data[7:1]};
            end
            else if (next_state == start) begin
                data <= 8'd0;
                reset_p <= 1'b0;
                done_reg <= 1'b0;
            end
            else if (next_state == idle) begin
                done_reg <= odd;
            end
            else if (next_state == pari) begin
                reset_p <= 1'b1;
            end
        end
    end

    assign done = done_reg;
    assign out_byte = done ? data : 8'd0;
    parity par_mod(clk, reset | reset_p, in, odd);

endmodule