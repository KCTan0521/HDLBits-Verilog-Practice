// paramter it is similar to a compile-time constant
// Use localparam instead if you don't want others to override the value during instantiation.

// kc answer
module top_module(
    input clk,
    input areset, // Asynchronous reset to OFF
    input j,
    input k,
    output out);

    parameter OFF=0, ON=1; 

    reg state, next;

    always @(*) begin
        if (out == OFF && j == 0) begin
            next = OFF;
        end
        else if (out == OFF && j == 1) begin
            next = ON;
        end
        else if (out == ON && k == 0) begin
            next = ON;
        end
        else if (out == ON && k == 1) begin
            next = OFF;
        end
    end

    always @(posedge clk, posedge areset) begin    // This is a sequential always block
        // State flip-flops with asynchronous reset
        if (areset) begin
            state <= OFF;
        end
        else begin
            state <= next;
        end
    end

    assign out = state;

endmodule


// sample answer
module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);
	parameter A=0, B=1;
	reg state;
	reg next;
    
    always_comb begin
		case (state)
			A: next = j ? B : A;
			B: next = k ? A : B;
		endcase
    end
    
    always @(posedge clk, posedge areset) begin
		if (areset) state <= A;
        else state <= next;
	end
		
	assign out = (state==B);

	
endmodule