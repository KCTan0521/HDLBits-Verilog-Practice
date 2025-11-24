module top_module ( input [1:0] A, input [1:0] B, output z ); 
    assign z = A == B;
endmodule

// sample answer
module top_module(
	input [1:0] A,
	input [1:0] B,
	output z);

	assign z = (A[1:0]==B[1:0]);	// Comparisons produce a 1 or 0 result.
	
	// Another option is to use a 16-entry truth table ( {A,B} is 4 bits, with 16 combinations ).
	// There are 4 rows with a 1 result.  0000, 0101, 1010, and 1111.

endmodule

// sample answer from chatgpt
// using logic gates
module top_module (
    input [1:0] A,
    input [1:0] B,
    output z
);

    wire eq1, eq0;

    assign eq1 = (A[1] & B[1]) | (~A[1] & ~B[1]); // XNOR A[1] == B[1]
    assign eq0 = (A[0] & B[0]) | (~A[0] & ~B[0]); // XNOR A[0] == B[0]
    assign z = eq1 & eq0; // z = 1 if both bits are equal

endmodule
