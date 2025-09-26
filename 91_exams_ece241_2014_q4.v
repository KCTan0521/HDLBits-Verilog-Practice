module top_module(
    input clk,
    input x,
    output z
);

    reg xor_out, and_out, or_out;
    reg f0,f1,f2;

    assign xor_out = x ^ f0;
    assign and_out = x & ~f1;
    assign or_out = x | ~f2;

    always @(posedge clk) begin
        f0 <= xor_out;
        f1 <= and_out;
        f2 <= or_out;    
    end

    assign z = ~ (f0 | f1 | f2);

endmodule


// sample answer
module top_module (
    input clk,
    input x,
    output z
); 
   wire d1,d2,d3;
    reg q1,q2,q3;
    assign d1=x^q1,
        d2=x&~q2,
        d3=x|~q3,
        z=~(q1|q2|q3);
    always @(posedge clk)begin
        q1<=d1;
        q2<=d2;
        q3<=d3;
    end

endmodule