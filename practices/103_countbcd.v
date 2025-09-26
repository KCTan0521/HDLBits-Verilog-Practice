module top_module(
    input clk,
    input reset,
    output [3:1] ena,   // Enables for digits 2,3,4
    output [15:0] q     // Concatenated 4 BCD digits
);

    reg [3:0] c1, c2, c3, c4;

    // Enable signals: upper digits enabled when lower digits reach 9
    assign ena[1] = (c1 == 4'd9);
    assign ena[2] = (c1 == 4'd9) && (c2 == 4'd9);
    assign ena[3] = (c1 == 4'd9) && (c2 == 4'd9) && (c3 == 4'd9);

    // Concatenate digits to output q
    assign q = {c4, c3, c2, c1};

    always @(posedge clk) begin
        if (reset) begin
            c1 <= 4'd0;
            c2 <= 4'd0;
            c3 <= 4'd0;
            c4 <= 4'd0;
        end else begin
            if (c1 == 4'd9) begin
                c1 <= 4'd0;
                if (c2 == 4'd9) begin
                    c2 <= 4'd0;
                    if (c3 == 4'd9) begin
                        c3 <= 4'd0;
                        if (c4 == 4'd9) begin
                            // When 9999 reached, reset all digits to 0
                            c4 <= 4'd0;
                        end
                        else begin
                            c4 <= c4 + 1;
                        end
                    end else begin
                        c3 <= c3 + 1;
                    end
                end else begin
                    c2 <= c2 + 1;
                end
            end else begin
                c1 <= c1 + 1;
            end
        end
    end

endmodule


// simplified answer from chatgpt
module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output [15:0] q
);

    reg [3:0] c1, c2, c3, c4;

    assign ena[1] = (c1 == 9);
    assign ena[2] = (c1 == 9) && (c2 == 9);
    assign ena[3] = (c1 == 9) && (c2 == 9) && (c3 == 9);

    assign q = {c4, c3, c2, c1};

    always @(posedge clk) begin
        if (reset) begin
            c1 <= 0; c2 <= 0; c3 <= 0; c4 <= 0;
        end else if (c1 == 9) begin
            c1 <= 0;
            if (c2 == 9) begin
                c2 <= 0;
                if (c3 == 9) begin
                    c3 <= 0;
                    if (c4 == 9) begin
                        c4 <= 0;  // reset after 9999
                    end else begin
                        c4 <= c4 + 1;
                    end
                end else begin
                    c3 <= c3 + 1;
                end
            end else begin
                c2 <= c2 + 1;
            end
        end else begin
            c1 <= c1 + 1;
        end
    end

endmodule
