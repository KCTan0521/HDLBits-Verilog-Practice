module top_module ( input a, input b, output out );

    // this method is through port position
    mod_a instance1 (a,b,out);

    // this method is through port name
    // mod_a instance2 (
    //     .a(a),
    //     .b(b),
    //     .out(out),
    // );

endmodule

// this mod_a is I declare myself, basically this is module hierarchy practice
module mod_a ( input a, input b, output out );

endmodule