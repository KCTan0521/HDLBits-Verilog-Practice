// sample answer
module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

	// This circuit is a 4-bit ripple-carry adder with carry-out.
	assign sum = x+y;	// Verilog addition automatically produces the carry-out bit.

	// Verilog quirk: Even though the value of (x+y) includes the carry-out, (x+y) is still considered to be a 4-bit number (The max width of the two operands).
	// This is correct:
	// assign sum = (x+y);
	// But this is incorrect:
	// assign sum = {x+y};	// Concatenation operator: This discards the carry-out
endmodule


// kc answer
module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);

    wire [3:0] cout;

    full_adder adder0 (
        .x(x[0]),
        .y(y[0]),
        .cin(0),
        .cout(cout[0]),
        .sum(sum[0]),
    );

    full_adder adder1 (
        .x(x[1]),
        .y(y[1]),
        .cin(cout[0]),
        .cout(cout[1]),
        .sum(sum[1]),
    );
    
    full_adder adder2 (
        .x(x[2]),
        .y(y[2]),
        .cin(cout[1]),
        .cout(cout[2]),
        .sum(sum[2]),
    );
    
    full_adder adder3 (
        .x(x[3]),
        .y(y[3]),
        .cin(cout[2]),
        .cout(cout[3]),
        .sum(sum[3]),
    );

    assign sum[4] = cout[3];

endmodule

module full_adder(
    input x,y,cin,
    output cout,sum
);
    assign cout = x&y | x&cin | y&cin;
    assign sum = x ^ y ^ cin;
endmodule
