module top_module (
	input [2:0] SW,      // R
	input [1:0] KEY,     // L and clk
	output [2:0] LEDR);  // Q

    mux_dff md0 (
        .in0(LEDR[2]),
        .in1(SW[0]),
        .L(KEY[1]),
        .clk(KEY[0]),
        .Q(LEDR[0])
    );

    mux_dff md1 (
        .in0(LEDR[0]),
        .in1(SW[1]),
        .L(KEY[1]),
        .clk(KEY[0]),
        .Q(LEDR[1])
    );

    
    mux_dff md2 (
        .in0(LEDR[2] ^ LEDR[1]),
        .in1(SW[2]),
        .L(KEY[1]),
        .clk(KEY[0]),
        .Q(LEDR[2])
    );

endmodule

module mux_dff (
    input in0,
    input in1,
    input L,
    input clk,
    output Q
);

    always @(posedge clk) begin
        if (L) begin
            Q <= in1;
        end
        else begin
            Q <= in0;
        end
    end

endmodule