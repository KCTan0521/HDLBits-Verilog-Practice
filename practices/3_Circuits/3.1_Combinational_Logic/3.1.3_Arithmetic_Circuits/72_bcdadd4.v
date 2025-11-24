module top_module ( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum );

    genvar i;

    localparam N = 4;
    localparam W = 4;
    wire [N-1:0] carry ;

    bcd_fadd adder0(
        .a(a[3:0]),
        .b(b[3:0]),
        .cin(cin),
        .cout(carry[0]),
        .sum(sum[3:0])
    );

    generate
        for (i=1; i < N; i=i+1) begin: bcd_add_loop
            bcd_fadd adders (
                .a(a[i*W+3:i*W]),
                .b(b[i*W+3:i*W]),
                .cin(carry[i-1]),
                .cout(carry[i]),
                .sum(sum[i*W+3:i*W])
            );
        end
    endgenerate

    assign cout = carry[N-1];
endmodule

// provided by question
module bcd_fadd (
    input [3:0] a,
    input [3:0] b,
    input     cin,
    output   cout,
    output [3:0] sum );
endmodule