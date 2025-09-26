module top_module (
    input in,
    input clk,
    // NOTE: resetn is an active-low signal
    // resetn = 1, mean do not reset;
    // resetn = 0, mean reset
    input resetn, // synchronous reset
    output out
);

    reg [3:0] dff;

    assign out = dff[3];

    always @(posedge clk) begin
        if (!resetn) begin
            dff <= 4'b0;
        end
        else begin
            dff[0] <= in;
            dff[1] <= dff[0];
            dff[2] <= dff[1];
            dff[3] <= dff[2];
        end
    end

endmodule


// sample answer
module top_module (
	input clk,
	input resetn,
	input in,
	output out
);

	reg [3:0] sr;
	
	// Create a shift register named sr. It shifts in "in".
	always @(posedge clk) begin
		if (~resetn)		// Synchronous active-low reset
			sr <= 0;
		else 
			sr <= {sr[2:0], in};
	end
	
	assign out = sr[3];		// Output the final bit (sr[3])

endmodule


// note that in this way the code cannot work
// module top_module (
//     input in,
//     input clk,
//     input resetn, // synchronous reset
//     output out
// );

//     reg [3:0] dff;

//     always @(posedge clk) begin
//         if (!resetn) begin
//             dff <= 4'b0;
//             out <= 1'b0; 
//         end
//         else begin
//             dff[0] <= in;
//             dff[1] <= dff[0];
//             dff[2] <= dff[1];
//             dff[3] <= dff[2];
//             out <= dff[3];
//         end
//     end

// endmodule