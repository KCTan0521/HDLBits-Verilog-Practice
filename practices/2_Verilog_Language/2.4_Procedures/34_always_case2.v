// sample answer
module top_module (
	input [3:0] in,
	output reg [1:0] pos
);

	always @(*) begin			// Combinational always block
		case (in)
			4'h0: pos = 2'h0;	// I like hexadecimal because it saves typing.
			4'h1: pos = 2'h0;
			4'h2: pos = 2'h1;
			4'h3: pos = 2'h0;
			4'h4: pos = 2'h2;
			4'h5: pos = 2'h0;
			4'h6: pos = 2'h1;
			4'h7: pos = 2'h0;
			4'h8: pos = 2'h3;
			4'h9: pos = 2'h0;
			4'ha: pos = 2'h1;
			4'hb: pos = 2'h0;
			4'hc: pos = 2'h2;
			4'hd: pos = 2'h0;
			4'he: pos = 2'h1;
			4'hf: pos = 2'h0;
			default: pos = 2'b0;	// Default case is not strictly necessary because all 16 combinations are covered.
		endcase
	end
	
	// There is an easier way to code this. See the next problem (always_casez).
	
endmodule

// extra
// the question is to find the first bit from right to left
// solve the problem using loop
module top_module (
    input [3:0] in,
    output reg [1:0] pos  );
    
    integer i;
    reg found;

    always @(*) begin
        pos = 0;
        found = 0;
        for (i = 0; i < 4; i = i + 1) begin
            if (!found && in[i]) begin
                pos = i[1:0];
                found = 1;
            end
        end
    end
endmodule

// note that the disable for_loop, just disable only the current cycle of loop
// but it does not terminate the for loop, it terminate the current cycle of loop only
// You may have expected disable for_loop; to behave like break; in C, which exits the whole loop.
// But in Verilog, it only exits the named block of that specific iteration.
// disable for_loop; only disables the current iteration's named block. 
// It does not terminate the entire for loop — the loop will continue to 
// the next iteration unless additional logic (like a flag) is used
// in other word it is slightly similar continue keyword in programming
// note that disable only can be used in for loop
// continue is loop control, disable is block control (for explanation go chatgpt)
module top_module (
    input [3:0] in,
    output reg [1:0] pos  );
    
    integer i;
    // this method can is because pos is overwritten until the last 1 bit
    // so technically it is correct despite it scan from left to right
    always @(*) begin
        pos = 2'd0; // Default assignment to avoid latch

        // Scan from MSB to LSB (priority to higher bits)
        for (i = 3; i >= 0; i = i - 1) begin: for_loop
            if (in[i]) begin
                pos = i[1:0];
                disable for_loop;
            end
        end
    end
endmodule

// for scanning from right to left in the same way is cannot
// because pos is overwritten until the leftest 1 bit position
// this method still can unless using a variable to explicitly stop when pos is written once
module top_module (
    input [3:0] in,
    output reg [1:0] pos  );
    
    integer i;

    always @(*) begin
        pos = 2'd0; // Default assignment to avoid latch

        // Scan from MSB to LSB (priority to higher bits)
        for (i = 0; i <= 3; i = i + 1) begin: for_loop
            if (in[i]) begin
                pos = i[1:0];
                disable for_loop;
            end
        end
    end
endmodule