module top_module (
    input x,
    input y,
    output z
);
	// The simulation waveforms gives you a truth table:
	// y x   z
	// 0 0   1
	// 0 1   0
	// 1 0   0
	// 1 1   1   
	// Two minterms: 
	// assign z = (~x & ~y) | (x & y);

	// Or: Notice this is an XNOR.
    assign z = ~(x ^ y);
endmodule