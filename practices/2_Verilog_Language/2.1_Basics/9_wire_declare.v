module sample_answer (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

    wire w1,w2;
    assign w1 = a&b;
    assign w2 = c&d;
    assign out = w1 | w2;
    assign out_n = ~out;
    
endmodule

module top_module (
    input a,b,c,d,
    output out,out_n);

    wire topAndGateOutput;
    wire bottomAndGateOutput;
    wire notGateOutput;
    
    assign topAndGateOutput = a & b;
    assign bottomAndGateOutput = c & d;
    assign notGateOutput = topAndGateOutput | bottomAndGateOutput;

    assign out = notGateOutput;
    assign out_n = ~notGateOutput;

endmodule
