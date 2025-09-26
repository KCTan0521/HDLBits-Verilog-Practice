module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);
    // Hint: 
    // Logic equations for one-hot state transition logic can be derived 
    // by looking at in-edges of the state transition diagram.
    assign Y1 = y[0] && w;
    assign Y3 = (y[1] && ~w) || (y[2] && ~w) || (y[4] && ~w) || (y[5] && ~w);

endmodule
