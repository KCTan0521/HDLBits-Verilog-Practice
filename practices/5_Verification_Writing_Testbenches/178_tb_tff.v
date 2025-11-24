module top_module ();

    reg clk;
    reg reset;
    reg t;
    wire q;

    initial begin
        clk = 0;
        reset = 1;

        #10
        reset = 0;
        t = 0;

        #10; t = 1;

        #10; 
        t = 0;
        reset = 1;

        #10; 
        t = 1;
        reset = 1;
    end

    always begin
        #5 clk = ~clk;
    end

    tff tff1 (
        .clk(clk),
        .reset(reset),
        .t(t),
        .q(q)
    );

endmodule

// provided by question
// module tff (
//     input clk,
//     input reset,   // active-high synchronous reset
//     input t,       // toggle
//     output q
// );


// sample answer from GitHub
module top_module ();
    reg clk, reset, t;
    reg q;
    initial begin
        clk = 0;
        reset = 0;
        t = 0;
        #15 reset = 1;
        #10 reset = 0;
        #10 t = 1;
    end
    always begin
        #5 clk = ~clk;
    end
    tff tff1(clk, reset, t, q);
endmodule