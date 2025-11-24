module top_module (input a,b, output out);
    assign out = ~(a | b);
    // assign out = ~a & ~b; // logical equipvalent
endmodule