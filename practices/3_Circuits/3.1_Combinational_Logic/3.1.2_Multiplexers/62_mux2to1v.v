module top_module( 
    input [99:0] a, b,
    input sel,
    output [99:0] out );

    assign out = sel ? b : a;

    // The following doesn't work. Why?
	// assign out = (sel & b) | (~sel & a);
    // The real issue is that you're trying to apply a 1-bit signal (sel) to a 100-bit vector (a or b) using bitwise operators (&, |), 
    // which results in width mismatch or unexpected replication behavior.
    // it will become sel & b  → {100{sel}} & b

endmodule