// https://hdlbits.01xz.net/wiki/Vector3

module top_module(
    input [4:0] a,b,c,d,e,f,
    output [7:0] w,x,y,z
);

    wire [31:0] total;
    assign total = {a,b,c,d,e,f, 2'b11};

    assign z = total[7:0];
    assign y = total[15:8];
    assign x = total[23:16];
    assign w = total[31:24];

endmodule