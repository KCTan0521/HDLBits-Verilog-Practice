// kc answer
module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 

    parameter S1=0, S2=1, S3=2;
    reg [1:0] state, next;
    
    always @(*) begin
        case (state) 
            S1: next = x ? S2 : S1;
            S2: next = x ? S2 : S3;
            S3: next = x ? S2: S1;
        endcase
    end

    always @(posedge clk or negedge aresetn) begin
        if (!aresetn) begin
            state <= S1;
        end
        else begin
            state <= next;
        end
    end

    assign z = (state == S3) && x;

endmodule


// sample answer
module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// Give state names and assignments. I'm lazy, so I like to use decimal numbers.
	// It doesn't really matter what assignment is used, as long as they're unique.
	parameter S=0, S1=1, S10=2;
	reg[1:0] state, next;		// Make sure state and next are big enough to hold the state encodings.
	
	
	
	// Edge-triggered always block (DFFs) for state flip-flops. Asynchronous reset.			
	always@(posedge clk, negedge aresetn)
		if (!aresetn)
			state <= S;
		else
			state <= next;
			
	

    // Combinational always block for state transition logic. Given the current state and inputs,
    // what should be next state be?
    // Combinational always block: Use blocking assignments.    
	always@(*) begin
		case (state)
			S: next = x ? S1 : S;
			S1: next = x ? S1 : S10;
			S10: next = x ? S1 : S;
			default: next = 'x;
		endcase
	end
	
	
	
	// Combinational output logic. I used a combinational always block.
	// In a Mealy state machine, the output depends on the current state *and*
	// the inputs.
	always@(*) begin
		case (state)
			S: z = 0;
			S1: z = 0;
			S10: z = x;		// This is a Mealy state machine: The output can depend (combinational) on the input.
			default: z = 1'bx;
		endcase
	end
	
endmodule


// sample answer from GitHub
module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 

    parameter start = 0, mid = 1, ends = 2;
    reg [2:0] state, next_state;

    always @(*) begin
        case (state)
            start: next_state = x ? mid : start;
            mid: next_state = x ? mid : ends;
            ends: next_state = x ? mid : start;
        endcase
    end

    always @(posedge clk or negedge aresetn) begin
        if (!aresetn) begin
            state <= start;
        end
        else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case (state)
            start: z = 0;
            mid: z = 0;
            ends: z = x;
        endcase
    end

endmodule


// kc wrong answer
// seems like this is a moore fsm
// not mealy fsm
module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 

    reg [2:0] data;

    always @(posedge clk or negedge aresetn) begin
        if (!aresetn) begin
            data <= 3'b0;
        end
        else begin
            data <= { data[1:0], x };
        end
    end

    assign z = data == 3'b101;
    // always @(negedge aresetn) begin
       
    // end

endmodule
