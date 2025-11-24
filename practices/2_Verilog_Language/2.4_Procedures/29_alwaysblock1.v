// always cannot have continuous assignments
// *Procedural continuous assignments do exist, 
// *but are somewhat different from continuous assignments, and are not synthesizable.

// A note on wire vs. reg: 
// The left-hand-side of an assign statement must be a net type (e.g., wire), 
// while the left-hand-side of a procedural assignment (in an always block) 
// must be a variable type (e.g., reg). 
// These types (wire vs. reg) have nothing to do with what hardware is synthesized, 
// and is just syntax left over from Verilog's use as a hardware simulation language.

// synthesis verilog_input_version verilog_2001
module top_module(
    input a, 
    input b,
    output wire out_assign,
    output reg out_alwaysblock
);

    assign out_assign = a & b;

    always @(*) begin
        out_alwaysblock = a & b;
    end

endmodule
