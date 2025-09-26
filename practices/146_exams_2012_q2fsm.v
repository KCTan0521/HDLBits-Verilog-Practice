module top_module (
    input clk,
    input reset,     // synchronous reset
    input w,
    output z);

    parameter A=0,B=1,C=2,D=3,E=4,F=5;

    reg [2:0] state, next;
    reg temp_z;

    always @(*) begin
        case (state) 
            A: next = w ? B : A;
            B: next = w ? C : D;
            C: next = w ? E : D;
            D: next = w ? F : A;
            E: next = w ? E : D;
            F: next = w ? C : D;
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            state <= A;
        end
        else begin
            state <= next;
        end
    end

    always @(*) begin
        if (state == A || state == B || state == C || state == D) begin
            z = 1'b0;
        end
        else begin
            z = 1'b1;
        end
    end

    // this method can also work
    // always @(*) begin
    //     case (state)
    //         E, F: z = 1'b1;
    //         default: z = 1'b0;
    //     endcase
    // end

endmodule



// kc answer version 2
module top_module (
    input clk,
    input reset,     // synchronous reset
    input w,
    output z);

    parameter A=0,B=1,C=2,D=3,E=4,F=5;

    reg [2:0] state, next;
    reg temp_z;

    always @(*) begin
        case (state) 
            A: next = ~w ? A : B;
            B: next = ~w ? D : C;
            C: next = ~w ? D : E;
            D: next = ~w ? A : F;
            E: next = ~w ? D : E;
            F: next = ~w ? D : C;
        endcase

        if (state == A || state == B || state == C || state == D) begin
            z = 1'b0;
        end
        else begin
            z = 1'b1;
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            state <= A;
        end
        else begin
            state <= next;
        end
    end

endmodule
