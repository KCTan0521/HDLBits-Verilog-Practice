module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
);

    reg [11:0] value;
    
    assign OneHertz = value[11:8] == 4'd9 && value[7:4] == 4'd9 && value[3:0] == 4'd9;

    always @(*) begin
        c_enable[0] <= 1'b1;
        c_enable[1] <= 1'b0;
        c_enable[2] <= 1'b0;

        if (value[3:0] == 4'd9) begin
            c_enable[1] <= 1'b1;
        end
        if (value[7:4] == 4'd9 && value[3:0] == 4'd9) begin
            c_enable[2] <= 1'b1;
        end
        
    end

    bcdcount counter0 (
        .clk(clk),
        .reset(reset),
        .enable(c_enable[0]),
        .Q(value[3:0])
    );
    bcdcount counter1 (
        .clk(clk),
        .reset(reset),
        .enable(c_enable[1]),
        .Q(value[7:4])
    );
    bcdcount counter2 (
        .clk(clk),
        .reset(reset),
        .enable(c_enable[2]),
        .Q(value[11:8])
    );
    
endmodule



// provided by question
module bcdcount (
	input clk,
	input reset,
	input enable,
	output reg [3:0] Q
);
endmodule


// sample answer from chatgpt
module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
);

    wire [3:0] digit0, digit1, digit2;  // BCD outputs
    assign c_enable[0] = 1'b1;                             // ones counter always enabled
    assign c_enable[1] = (digit0 == 4'd9);                 // tens enabled when ones == 9
    assign c_enable[2] = (digit0 == 4'd9) && (digit1 == 4'd9);  // hundreds enabled when ones == 9 AND tens == 9

    // OneHertz pulse when counter = 999 (BCD: 9 9 9)
    assign OneHertz = (digit0 == 4'd9) && (digit1 == 4'd9) && (digit2 == 4'd9);

    // Instantiate BCD counters
    bcdcount counter0 (
        .clk(clk),
        .reset(reset),
        .enable(c_enable[0]),
        .Q(digit0)
    );
    
    bcdcount counter1 (
        .clk(clk),
        .reset(reset),
        .enable(c_enable[1]),
        .Q(digit1)
    );
    
    bcdcount counter2 (
        .clk(clk),
        .reset(reset),
        .enable(c_enable[2]),
        .Q(digit2)
    );

endmodule
