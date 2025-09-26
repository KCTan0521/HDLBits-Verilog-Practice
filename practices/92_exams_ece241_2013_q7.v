// notes: 
// in verilog, you can set Q = Q in always or initial block
// because it means to set the old value of Q to the current Q

module top_module (
    input clk,
    input j,
    input k,
    output Q); 

    always @(posedge clk) begin
        if (j & ~k) begin
            Q <= 1'b1;
        end
        if (~j & k) begin
            Q <= 1'b0;
        end
        if (j & k) begin
            Q <= ~Q;
        end
        if (~j & ~k) begin
            Q <= Q;
        end
    end

endmodule

// sample answer
module top_module (
    input clk,
    input j,
    input k,
    output reg Q
); 
    always @(posedge clk) begin
        case ({j, k})
            2'b00: Q <= Q;        // No change
            2'b01: Q <= 1'b0;     // Reset
            2'b10: Q <= 1'b1;     // Set
            2'b11: Q <= ~Q;       // Toggle
        endcase
    end
endmodule
