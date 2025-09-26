module top_module (
    input [7:0] a,b,c,d,
    output [7:0] min
);

    wire [7:0] minValue1, minValue2;
    assign minValue1 = (a < b) ? a : b;
    assign minValue2 = (minValue1 < c) ? minValue1 : c;
    assign min = (minValue2 < d) ? minValue2 : d;

endmodule


// in verilog
// You cannot have more than one continuous assignment (assign) driving the same wire.
// Here, minValue is assigned twice, which is illegal in Verilog.
// module top_module (
//     input [7:0] a,b,c,d,
//     output [7:0] min
// );

//     wire [7:0] minValue;
//     assign minValue = (a < b) ? a : b;
//     assign minValue = (minValue < c) ? minValue : c;
//     assign min = (minValue < d) ? minValue : d;
    
// endmodule