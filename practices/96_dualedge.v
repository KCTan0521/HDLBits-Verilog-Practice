// sample answer
module top_module(
	input clk,
	input d,
	output q);
	
	reg p, n;
	
	// A positive-edge triggered flip-flop
    always @(posedge clk)
        p <= d ^ n;
        
    // A negative-edge triggered flip-flop
    always @(negedge clk)
        n <= d ^ p;
    
    // Why does this work? 
    // After posedge clk, p changes to d^n. Thus q = (p^n) = (d^n^n) = d.
    // After negedge clk, n changes to d^p. Thus q = (p^n) = (p^d^p) = d.
    // At each (positive or negative) clock edge, p and n FFs alternately
    // load a value that will cancel out the other and cause the new value of d to remain.
    assign q = p ^ n;
    
    
	// Can't synthesize this.
	/*always @(posedge clk, negedge clk) begin
		q <= d;
	end*/
    
    
endmodule

// improved kc answer based on sample answer
module top_module(
    input clk,
    input d,
    output q
);
    reg pos_q, neg_q;

  
    always @(posedge clk) begin
        neg_q <= d ^ pos_q;
    end

    always @(negedge clk) begin
        pos_q <= d ^ neg_q;
    end
    
    always @(*) begin
        q = pos_q ^ neg_q;
    end
endmodule

// kc answer (but not synthesizable)
module top_module(
    input clk,
    input d,
    output q
);
    reg pos_q, neg_q;

    always @(*) begin
        if (clk) begin 
            q = neg_q;
        end
        else begin
            q = pos_q;
        end

    end
    always @(posedge clk) begin
        neg_q <= d;
    end

    always @(negedge clk) begin
        pos_q <= d;
    end

endmodule