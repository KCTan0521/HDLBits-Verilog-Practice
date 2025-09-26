module top_module(
    input [399:0] a,b,
    input cin,
    output cout,
    output [399:0] sum
);

    genvar i;
    wire [99:0] coutArr;

    bcd_fadd adder0 (
        .a(a[3:0]),
        .b(b[3:0]),
        .cin(cin),
        .cout(coutArr[0]),
        .sum(sum[3:0])
    );

    generate
        for (i=1; i < 100; i=i+1) begin: addition_loop
            bcd_fadd adders (
                .a(a[i*4+3:i*4]),
                .b(b[i*4+3:i*4]),
                .cin(coutArr[i-1]),
                .cout(coutArr[i]),
                .sum(sum[i*4+3:i*4])
            );
        end
    endgenerate
    
    assign cout = coutArr[99];
endmodule


// provided by question
module bcd_fadd (
    input [3:0] a,
    input [3:0] b,
    input     cin,
    output   cout,
    output [3:0] sum );
endmodule



// sample answer from chatgpt
module top_module (
    input  [399:0] a,
    input  [399:0] b,
    input         cin,
    output        cout,
    output [399:0] sum
);

    // Parameters for easy scaling
    localparam N = 100; // number of BCD digits
    localparam W = 4;   // width of each BCD digit

    genvar i;
    wire [N-1:0] carry; // carry chain

    // First BCD adder: uses external carry-in
    bcd_fadd adder0 (
        .a   (a[W-1:0]),
        .b   (b[W-1:0]),
        .cin (cin),
        .cout(carry[0]),
        .sum (sum[W-1:0])
    );

    // Generate rest of the BCD adders
    generate
        for (i = 1; i < N; i = i + 1) begin: addition_loop
            bcd_fadd adders (
                .a   (a[i*W + W - 1 : i*W]),
                .b   (b[i*W + W - 1 : i*W]),
                .cin (carry[i - 1]),
                .cout(carry[i]),
                .sum (sum[i*W + W - 1 : i*W])
            );
        end
    endgenerate

    // Final carry-out of the whole chain
    assign cout = carry[N - 1];

endmodule
