module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 

    parameter A=0,B=1,C=2,D=3;
    reg [1:0] state, next;

    always @(*) begin
        case (state)
            A: begin
                if (r[1]) next = B;
                else if (r[2]) next = C;
                else if (r[3]) next = D;
                else next = A;
            end
            B: next = r[1] ? B : A;
            C: next = r[2] ? C : A;
            D: next = r[3] ? D : A;
        endcase

        g[1] = state == B;
        g[2] = state == C;
        g[3] = state == D;
    end

    always @(posedge clk) begin
        if (!resetn) begin
            state <= A;
        end
        else begin
            state <= next;
        end
    end
    
endmodule
