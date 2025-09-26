/*
*view in word wrap
When designing circuits, you must think first in terms of circuits:

I want this logic gate
I want a combinational blob of logic that has these inputs and produces these outputs
I want a combinational blob of logic followed by a set of flip-flops
What you must not do is write the code first, then hope it generates a proper circuit.

If (cpu_overheated) then shut_off_computer = 1;
If (~arrived) then keep_driving = ~gas_tank_empty;
Syntactically-correct code does not necessarily result in a reasonable circuit (combinational logic + flip-flops). The usual reason is: "What happens in the cases other than those you specified?". Verilog's answer is: Keep the outputs unchanged.

This behaviour of "keep outputs unchanged" means the current state needs to be remembered, and thus produces a latch. Combinational logic (e.g., logic gates) cannot remember any state. Watch out for Warning (10240): ... inferring latch(es)" messages. Unless the latch was intentional, it almost always indicates a bug. Combinational circuits must have a value assigned to all outputs under all conditions. This usually means you always need else clauses or a default value assigned to the outputs.
*/

// kc opinion:
// the main idea is you need to define value for each variable
// you cannot let variable to have unknown value in different state
// this is to avoid latches
// To avoid creating latches, all outputs must be assigned a value in all possible conditions

// synthesis verilog_input_version verilog_2001
module top_module (
    input      cpu_overheated,
    output reg shut_off_computer,
    input      arrived,
    input      gas_tank_empty,
    output reg keep_driving  ); 

    always @(*) begin
        if (cpu_overheated)
           shut_off_computer = 1;
        else
            shut_off_computer = 0;

        // in shorter expression
        // shut_off_computer = cpu_overheated;
    end

    always @(*) begin
        if (~gas_tank_empty && ~arrived)
           keep_driving = 1'b1;
        else
            keep_driving = 1'b0;
        
        // in shorter expression
        //  keep_driving = ~gas_tank_empty && ~arrived;
    end

endmodule

// provided by question
// module top_module (
//     input      cpu_overheated,
//     output reg shut_off_computer,
//     input      arrived,
//     input      gas_tank_empty,
//     output reg keep_driving  ); //

//     always @(*) begin
//         if (cpu_overheated)
//            shut_off_computer = 1;
//     end

//     always @(*) begin
//         if (~arrived)
//            keep_driving = ~gas_tank_empty;
//     end

// endmodule