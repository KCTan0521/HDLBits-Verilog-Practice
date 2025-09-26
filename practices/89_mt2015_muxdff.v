// note that the question is asking us to do the sub-module
// not to create 3 instance of the sub-module

module top_module (
	input clk,
	input L,
	input r_in,
	input q_in,
	output reg Q
);
    always @(posedge clk) begin
        Q <= L ? r_in : q_in ;
    end
endmodule