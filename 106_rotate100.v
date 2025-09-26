module top_module (
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q
);

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end
        else if (~ena[1] & ena[0]) begin
            q <= { q[0], q[99:1]}; 
            
            // note that after shifting it is still 100 bit
            // not becoming 99 bit
            // q <= { q[0], q >> 1}; 
        end
        else if (ena[1] & ~ena[0]) begin
            q <= { q[98:0], q[99]};
        end
    end

endmodule

// sample answer
module top_module(
	input clk,
	input load,
	input [1:0] ena,
	input [99:0] data,
	output reg [99:0] q);
	
	// This rotator has 4 modes:
	//   load
	//   rotate left
	//   rotate right
	//   do nothing
	// I used vector part-select and concatenation to express a rotation.
	// Edge-sensitive always block: Use non-blocking assignments.
	always @(posedge clk) begin
		if (load)		// Load
			q <= data;
		else if (ena == 2'h1)	// Rotate right
			q <= {q[0], q[99:1]};
		else if (ena == 2'h2)	// Rotate left
			q <= {q[98:0], q[99]};
	end
endmodule
