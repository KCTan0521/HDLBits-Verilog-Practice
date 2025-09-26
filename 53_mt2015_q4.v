module top_module (input x, input y, output z);

	wire ra1, ra2, ra3, ra4, rb1, rb2;

	module_a ia1 (
		.x(x),
		.y(y),
		.z(ra1)
	);
	
	module_b ib1 (
		.x(x),
		.y(y),
		.z(ra2)
	);

	module_a ia2 (
		.x(x),
		.y(y),
		.z(ra3)
	);

	module_b ib2 (
		.x(x),
		.y(y),
		.z(ra4)
	);
	
	assign rb1 = ra1 | ra2;
	assign rb2 = ra1 & ra2;

	assign z = rb1 ^ rb2;

endmodule


module module_a  (input x, input y, output z);
    assign z = (x^y) & x;
endmodule


module module_b (
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


// sample answer
// module top_module(
// 	input x,
// 	input y,
// 	output z);

// 	wire o1, o2, o3, o4;
	
// 	A ia1 (x, y, o1);
// 	B ib1 (x, y, o2);
// 	A ia2 (x, y, o3);
// 	B ib2 (x, y, o4);
	
// 	assign z = (o1 | o2) ^ (o3 & o4);

// 	// Or you could simplify the circuit including the sub-modules:
// 	// assign z = x|~y;
	
// endmodule

// module A (
// 	input x,
// 	input y,
// 	output z);

// 	assign z = (x^y) & x;
	
// endmodule

// module B (
// 	input x,
// 	input y,
// 	output z);

// 	assign z = ~(x^y);

// endmodule
