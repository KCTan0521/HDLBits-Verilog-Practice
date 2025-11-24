module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire [15:0] lowerAdd, higherAdd;
    wire lowerCarry, higerCarry;

    add16 lowerAddProcess (
        .a(a[15:0]),
        .b(b[15:0]),
        .cin(1'b0),
        .sum(lowerAdd),
        .cout(lowerCarry)
    );

    add16 higerAddProcess(
        .a(a[31:16]),
        .b(b[31:16]),
        .cin(lowerCarry),
        .sum(higherAdd),
        .cout(higerCarry)
    );

    assign sum = { higherAdd, lowerAdd };

endmodule


// provided by question
// module add16 ( input[15:0] a, input[15:0] b, input cin, output[15:0] sum, output cout );
// endmodule