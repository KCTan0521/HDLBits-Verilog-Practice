// https://hdlbits.01xz.net/wiki/Module_cseladd

module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire [15:0] lowerBitSum;
    wire [15:0] upperBitSumCarry0;
    wire [15:0] upperBitSumCarry1;
    wire lowerBitCarry;
    wire upperBitCarry0;
    wire upperBitCarry1;

    add16 lowerBitSumProcess (
        .a(a[15:0]),
        .b(b[15:0]),
        .cin(1'b0),
        .sum(lowerBitSum),
        .cout(lowerBitCarry)
    );

    add16 upperBitSumCarry0Process (
        .a(a[31:16]),
        .b(b[31:16]),
        .cin(1'b0),
        .sum(upperBitSumCarry0),
        .cout(upperBitCarry0)
    );

    add16 upperBitSumCarry1Process (
        .a(a[31:16]),
        .b(b[31:16]),
        .cin(1'b1),
        .sum(upperBitSumCarry1),
        .cout(upperBitCarry1)
    );

    assign sum[15:0] = lowerBitSum;

    always @(*) begin
        case (lowerBitCarry)
            1'b0: sum[31:16] = upperBitSumCarry0;
            1'b1: sum[31:16] = upperBitSumCarry1;
        endcase
    end

endmodule

// provided by question
module add16 ( input[15:0] a, input[15:0] b, input cin, output[15:0] sum, output cout );
endmodule