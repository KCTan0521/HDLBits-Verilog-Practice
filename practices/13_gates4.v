module top_module(
    input  [3:0] in,
    output       out_and,
    output       out_or,
    output       out_xor
);

    assign out_and = &in;  // reduction AND: AND of all bits in 'in'
    assign out_or  = |in;  // reduction OR: OR of all bits in 'in'
    assign out_xor = ^in;  // reduction XOR: XOR of all bits in 'in'

endmodule

// my answer
// module top_module(
//     input [3:0] in,
//     output out_and,
//     output out_or,
//     output out_xor
// );

//     assign out_and = in[3] & in[2] & in[1] & in[0];
//     assign out_or = in[3] | in[2] | in[1] | in[0];
//     assign out_xor = in[3] ^ in[2] ^ in[1] ^ in[0];

// endmodule
