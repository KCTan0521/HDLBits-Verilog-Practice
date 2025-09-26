module top_module(
    input clk,
    input [7:0] in,
    output [7:0] pedge
);
    
    integer i;
    reg [7:0] prev_in;

    always @(posedge clk) begin
        for (i=0; i<8; i=i+1) begin
            pedge[i] <= in[i] & ~prev_in[i];
        end

        // note that only update the prev-in after for loop is completed
        prev_in <= in;
    end

endmodule


// sample answer
module top_module (
    input clk,
    input [7:0] in,
    output reg [7:0] pedge
);

    reg [7:0] prev_in;

    always @(posedge clk) begin
        pedge <= ~prev_in & in;  // detect rising edges bitwise
        prev_in <= in;           // store current input for next cycle
    end

endmodule
