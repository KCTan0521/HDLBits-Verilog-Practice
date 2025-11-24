module top_module();
    reg clk;
    reg in;
    reg [2:0] s;
    reg out;

    initial begin
        clk = 0;
        in = 0;
        s = 2;

        #10; 
        s = 6;

        #10; 
        in = 1;
        s = 2;

        #10; 
        in = 0;
        s = 7;

        #10;
        in = 1;
        s = 0;

        #30
        in = 0;
        
    end

    always begin
        #5 clk = ~clk;
    end

    q7 q7_instance (
        .clk(clk),
        .in(in),
        .s(s),
        .out(out)    
    );


endmodule

// module provided by question
// module q7(
//     input clk,
//     input in,
//     input [2:0] s;
//     output out
// );