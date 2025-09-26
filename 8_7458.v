module top_module ( 
    input p1a, p1b, p1c, p1d, p1e, p1f,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y );

    simplified_7458 instance1 (
        .p1a(p1a),
        .p1b(p1b),
        .p1c(p1c),
        .p1d(p1d),
        .p1e(p1e),
        .p1f(p1f),
        .p1y(p1y),
        .p2a(p2a),
        .p2b(p2b),
        .p2c(p2c),
        .p2d(p2d),
        .p2y(p2y)
    );

endmodule

module simplified_7458 ( 
    input p1a, p1b, p1c, p1d, p1e, p1f,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y );

    assign p1y = (p1a & p1c & p1b) | (p1f & p1e & p1d);
    assign p2y = (p2a & p2b) | (p2c & p2d);

endmodule

module with_wire_7458 ( 
    input p1a, p1b, p1c, p1d, p1e, p1f,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y );

    wire wlt,wlb,wrt,wrb; // wire left top, wire left bottom, wire right top, wire right bottom

    assign wrt = p1a & p1c & p1b;
    assign wrb = p1f & p1e & p1d;
    assign p1y = wrt | wrb;

    assign wlt = p2a & p2b;
    assign wlb = p2c & p2d;
    assign p2y = wlt | wlb;

endmodule
