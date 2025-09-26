module top_module(
    input clk,
    input [7:0] d,
    input [1:0] sel,
    output [7:0] q
);

    wire [7:0] flop1Result, flop2Result, flop3Result;

    my_dff8 flop1 (
        .clk(clk),
        .d(d),
        .q(flop1Result)
    );

    my_dff8 flop2 (
        .clk(clk),
        .d(flop1Result),
        .q(flop2Result)
    );

    my_dff8 flop3 (
        .clk(clk),
        .d(flop2Result),
        .q(flop3Result)
    );
    
    always @(*) begin
        case (sel)
            2'b00: q = d;
            2'b01: q = flop1Result;
            2'b10: q = flop2Result;
            2'b11: q = flop3Result;
        endcase
    end

endmodule

// provide in question
module my_dff8 ( input clk, input [7:0] d, output [7:0] q );
endmodule