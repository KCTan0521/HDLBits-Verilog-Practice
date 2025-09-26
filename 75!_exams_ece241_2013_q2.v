// note that the 1,2,3,4,... arrangement in the table
// we assume dont care value as 1, become we need larger 1 group as possible
// from that, we include dont care values

module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
); 

    // sample answer from github
    assign out_sop = (c&d) | (c&~a&~b) ,
        out_pos = c & (d|~b) & (d|~a) ;

        assign out_sop = (~a & ~b & c) | (b & c & d) | (a & c & d);
    assign out_pos = out_sop;

endmodule
