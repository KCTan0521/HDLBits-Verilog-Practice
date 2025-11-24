module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );
    
    genvar i;

    add1 adder0 (
        .a(a[0]),
        .b(b[0]),
        .cin(cin),
        .cout(cout[0]),
        .sum(sum[0])
    );

    generate 
        for (i=1; i < 100; i=i+1 ) begin : addition_loop
            add1 adders (
                .a(a[i]),
                .b(b[i]),
                .cin(cout[i-1]),
                .cout(cout[i]),
                .sum(sum[i]),
            );
        end
    endgenerate

endmodule

module add1 (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);
    assign sum  = a ^ b ^ cin;
    assign cout = (a & b) | (a & cin) | (b & cin);
endmodule

// Verilog does not allow module instantiation inside procedural blocks like always.
// Module instantiation must be done at the structural level, outside of always.
// to perform multiple adders process without specifying one by one
// use generate statement to help
// module top_module( 
//     input [99:0] a, b,
//     input cin,
//     output [99:0] cout,
//     output [99:0] sum );

//     wire cout_result;
//     wire sum_result;
//     add1 [99:0] add1Process;
//     integer i;  
        
//     always @(*) begin
//         for (i=0; i < 100; i=i+1) begin
//             if (i == 1'b0) begin
// error is at here
//                 add1Process[i] = (
//                     .a(a[i]),
//                     .b(b[i]),
//                     .cin(cin)
//                     .cout(cout[i])
//                     .sum(sum[i])
//                 );
//             end
//             else begin
//                 add1Process[i] = (
//                     .a(a[i]),
//                     .b(b[i]),
//                     .cin(cout[i-1])
//                     .cout(cout[i])
//                     .sum(sum[i])
//                 );
//             end
//         end
//     end

// endmodule


// | Use case         | Loop type    | Variable type | When it runs                              | Purpose                                                                             |
// | ---------------- | ------------ | ------------- | ----------------------------------------- | ----------------------------------------------------------------------------------- |
// | `always` block   | runtime loop | `integer`     | At simulation or synthesis time (dynamic) | Looping over values during simulation (or synthesizable for hardware control logic) |
// | `generate` block | compile-time | `genvar`      | At elaboration time (before simulation)   | Instantiating modules/hardware at compile time                                      |

