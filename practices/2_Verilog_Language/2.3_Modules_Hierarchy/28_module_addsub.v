module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    wire [31:0] b_xor;
    wire [15:0] lowByteSum, upperByteSum;
    wire lowByteCarry, upperByteCarry;

    assign b_xor = b ^ { 32{sub} };

    add16 lowByteSumProcess (
        .a(a[15:0]),
        .b(b_xor[15:0]),
        .cin(sub),
        .sum(lowByteSum),
        .cout(lowByteCarry)
    );

    add16 upperByteSumProcess (
        .a(a[31:16]),
        .b(b_xor[31:16]),
        .cin(lowByteCarry),
        .sum(upperByteSum),
        .cout(upperByteCarry)
    );

    assign sum = { upperByteSum, lowByteSum };

endmodule

// provided by question
module add16 ( input[15:0] a, input[15:0] b, input cin, output[15:0] sum, output cout );
endmodule