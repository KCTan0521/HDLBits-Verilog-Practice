module top_module(
    input a,b,c,
    output out
);
    assign out = a | ~a & b | ~a & ~b & c ;

    // sample answer
    // assign out = a | ~a & b | ~a & ~b & c ;
endmodule