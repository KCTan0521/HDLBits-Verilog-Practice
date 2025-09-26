module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); 

    parameter S1=0, S2=1, S3=2, S4=3, S5=4, S6=5, S7=6, S8=7, START=8, STOP=9, ERROR=10;
    reg [3:0] state, next;
    reg [7:0] data;

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


    always @(posedge clk) begin
        if (reset) begin
            data <= '0;
        end
        else begin
            case (state)
                S1, S2, S3, S4, S5, S6, S7, S8: begin
                    data <= {in, data[7:1]};  // shift right, LSB first
                end
            endcase
        end
    end

    assign out_byte = (done) ? data : 7'd0; 

endmodule
