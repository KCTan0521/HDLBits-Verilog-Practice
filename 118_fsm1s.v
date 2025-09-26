// paramter it is similar to a compile-time constant
// Use localparam instead if you don't want others to override the value during instantiation.

// kc answer
module top_module(
    input clk,
    input reset,    // Synchronous reset to state B
    input in,
    output out);//  

    parameter A=0, B=1; 

    always @(posedge clk) begin    // This is a sequential always block
        // State flip-flops with asynchronous reset
        if (reset) begin
            out <= B;
        end
        else begin
            if (out == B && in == 0) begin
                out <= A;
            end
            else if (out == B && in == 1) begin
                out <= B;
            end
            else if (out == A && in == 0) begin
                out <= B;
            end
            else if (out == B && in == 1) begin
                out <= A;
            end
        end
    end

endmodule


// sample answer format
// Note the Verilog-1995 module declaration syntax here:
module top_module(clk, reset, in, out);
    input clk;
    input reset;    // Synchronous reset to state B
    input in;
    output out;//  
    reg out;

    // Fill in state name declarations

    reg present_state, next_state;

    always @(posedge clk) begin
        if (reset) begin  
            // Fill in reset logic
        end else begin
            case (present_state)
                // Fill in state transition logic
            endcase

            // State flip-flops
            present_state = next_state;   

            case (present_state)
                // Fill in output logic
            endcase
        end
    end

endmodule