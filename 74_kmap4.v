module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  ); 
    
    // for those that cannot fit into 2,4,8,... in kmap
    // just need to list down one by one for the logics that have value of 1
    assign out = ~a&b&~c&~d | a&~b&~c&~d | ~a&~b&~c&d | a&b&~c&d | ~a&b&c&d | a&~b&c&d | ~a&~b&c&~d | a&b&c&~d ;

endmodule