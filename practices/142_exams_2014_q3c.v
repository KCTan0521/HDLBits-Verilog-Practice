// kc answer
module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);

    reg[2:0] state; // represent y
    integer i=1;

    always @(*) begin
        case (y)
            3'b000: state = x ? 3'b001 : 3'b000;
            3'b001: state = x ? 3'b100 : 3'b001;
            3'b010: state = x ? 3'b001 : 3'b010;
            3'b011: state = x ? 3'b010 : 3'b001;
            3'b100: state = x ? 3'b100 : 3'b011;
            default: state = state;
        endcase
    end

    assign z = (y == 3'b011 || y == 3'b100);
    assign Y0 = state[0];
endmodule


// sample answer from GitHub
module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);

    reg [2:0] Y;
    
    always@(*) begin
        case({y, x})
            4'b0000:    Y = 3'b000;
            4'b0001:    Y = 3'b001;
            4'b0010:    Y = 3'b001;
            4'b0011:    Y = 3'b100;
            4'b0100:    Y = 3'b010;
            4'b0101:    Y = 3'b001;
            4'b0110:    Y = 3'b001;
            4'b0111:    Y = 3'b010;
            4'b1000:    Y = 3'b011;
            4'b1001:    Y = 3'b100;
        endcase
    end
    
    assign  z = (y == 3'b011 || y == 3'b100);
    assign Y0 = Y[0];

endmodule