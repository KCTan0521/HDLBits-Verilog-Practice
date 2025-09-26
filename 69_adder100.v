module top_module( 
    input [99:0] a, b,
    input cin,
    output cout,
    output [99:0] sum );

    // first method, also sample answer
    // assign {cout, sum} = a + b + cin;


    // second method
    wire [100:0] full_sum;
    // need to manually add 1 zero bit in front, so that system put carry out at there
    assign full_sum = {1'b0, a} + {1'b0, b} + cin;
    assign sum = full_sum[99:0];
    assign cout = full_sum[100];  // This is the actual carry-out

endmodule
