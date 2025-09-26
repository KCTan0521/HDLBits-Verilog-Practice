module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
); 
    wire [8:0] sum;
    assign sum = a + b;
    assign s = sum[7:0];
    
    
    // 2’s complement method to determine overflow (conceptual form)
    assign overflow = (a[7] == b[7]) && (s[7] != a[7]);

    // logically equivalent with 2’s complement (bitwise logic form)
    // assign overflow = (a[7] & b[7] & ~sum[7]) | (~a[7] & ~b[7] & sum[7]);
    
    // this method cannot determine overflow
    // assign overflow = (a[7] & b[7] & ~sum[8]) | (~a[7] & ~b[7] & sum[8]);
    
endmodule