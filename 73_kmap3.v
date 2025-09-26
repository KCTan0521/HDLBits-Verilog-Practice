module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  ); 

    // assign out = ~b&c | a&c | a&~c&~d | a&~c&d ;
    assign out = ~b&c | a&c | a&~c ;

    // UPDATE : d is refer to don't care, which means any value are accepted
endmodule
