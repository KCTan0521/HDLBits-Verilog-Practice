`default_nettype none     // Disable implicit nets. Reduces some types of bugs.
module top_module( 
    input wire [15:0] in,
    output wire [7:0] out_hi,
    output wire [7:0] out_lo );

    assign out_hi = in[15:8];
    assign out_lo = in[7:0];

endmodule

// sample answer
// module top_module (
// 	input [15:0] in,
// 	output [7:0] out_hi,
// 	output [7:0] out_lo
// );
	
// 	assign out_hi = in[15:8];
// 	assign out_lo = in[7:0];
	
// 	// Concatenation operator also works: assign {out_hi, out_lo} = in;
	
// endmodule

/*

litte-endian  input wire [15:0] in, (this method is preferred)
big-endian  input wire [0:15] in,

wire [7:0] a = 8'b10101110;
wire [0:7] b = 8'b10101110;

(counting from back)
a[0] is 0
a[1] is 1
a[2] is 1

(couting from front)
b[0] is 1
b[1] is 0
b[2] is 1

input [3:-2] a is allowed, but need to use negative number to access the index

What are nets?

Nets (like wire) represent connections between hardware elements.

They can only be driven by continuous assignments or module outputs.

What are implicit nets?

In older Verilog versions, if you used a signal in your code without declaring it, the compiler/simulator implicitly created it as a wire by default.


Visual difference:
Type	Declaration Syntax	Storage Concept	Example Usage
Packed	wire [7:0] data;	Bits packed in one variable	Bit vectors, buses
Unpacked	reg [7:0] mem [0:255];	Array of variables, each is packed	Memories, arrays of registers

Packed array - bit level - similar to 1D array
- assign result = mem[3]

Unpacked array - array-level - similar to 2D array
- assign result = mem[3][1]
*/