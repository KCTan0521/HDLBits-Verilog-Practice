module top_module(
	input [2:0] a, 
	input [2:0] b, 
	output [2:0] out_or_bitwise,
	output out_or_logical,
	output [5:0] out_not
);
	
	assign out_or_bitwise = a | b;
	assign out_or_logical = a || b;

	assign out_not[2:0] = ~a;	// Part-select on left side is o.
	assign out_not[5:3] = ~b;	//Assigning to [5:3] does not conflict with [2:0]
	
endmodule

// corrected version from my answer
// module top_module( 
//     input [2:0] a,
//     input [2:0] b,
//     output [2:0] out_or_bitwise,
//     output out_or_logical,
//     output [5:0] out_not
// );

//     assign out_or_bitwise[2:0] = {a[2] | b[2], a[1] | b[1], a[0] | b[0]};
//     assign out_or_logical = a || b;
//     assign out_not[2:0] = {~a[2], ~a[1],~a[0]};
//     assign out_not[5:3] = {~b[2], ~b[1], ~b[0]};

// endmodule


// wrong answer
// module top_module( 
//     input [2:0] a,
//     input [2:0] b,
//     output [2:0] out_or_bitwise,
//     output out_or_logical,
//     output [5:0] out_not
// );

//     assign out_or_bitwise[2:0] = {a[2] | b[2], a[1] | b[1], a[0] | b[0]};
//     assign out_or_logical = a || b;
//     assign out_not[2:0] = {~a[2], ~a[1],~a[0]};
//     assign out_not[5:3] = {~b[5], ~b[4], ~b[3]};

// endmodule