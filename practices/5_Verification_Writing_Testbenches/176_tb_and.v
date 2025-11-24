module top_module();

    reg [1:0] in;
    reg out;

    initial begin
        in = 2'b00;

        #10; in = 2'b01;
        #10; in = 2'b10;
        #10; in = 2'b11;

    end

    andgate andgate1 (
        .in(in),
        .out(out)
    );

endmodule


// module provided by question
// module andgate (
//     input [1:0] in,
//     output out
// );