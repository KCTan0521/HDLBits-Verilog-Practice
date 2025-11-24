module top_module (
    input [3:1] y,
    input w,
    output Y2);

    parameter A=0,B=1,C=2,D=3,E=4,F=5;
    reg [3:1] next;

    always @(*) begin
        case (y) 
            A: next = w ? A : B;
            B: next = w ? D : C;
            C: next = w ? D : E;
            D: next = w ? A : F;
            E: next = w ? D : E;
            F: next = w ? D : C;
            default: next = next;
        endcase
    end

    assign Y2 = next[2];

endmodule
