module top_module (input clk, input d, output q);
    
    wire flop1Result;
    wire flop2Result;
    
    my_dff flop1 (
        .clk(clk),
        .d(d),
        .q(flop1Result)
    );
    
    my_dff flop2 (
        .clk(clk),
        .d(flop1Result),
        .q(flop2Result)
    );

    my_dff flop3 (
        .clk(clk),
        .d(flop2Result),
        .q(q)
    );

endmodule

// provided by question
// module my_dff ( input clk, input d, output q );
// endmodule

// sample answer
// module top_module (
// 	input clk,
// 	input d,
// 	output q
// );

// 	wire a, b;	// Create two wires. I called them a and b.

// 	// Create three instances of my_dff, with three different instance names (d1, d2, and d3).
// 	// Connect ports by position: ( input clk, input d, output q)
// 	my_dff d1 ( clk, d, a );
// 	my_dff d2 ( clk, a, b );
// 	my_dff d3 ( clk, b, q );

// endmodule
