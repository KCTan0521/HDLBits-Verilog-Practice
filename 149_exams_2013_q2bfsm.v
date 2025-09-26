module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 
    parameter WAIT_RESET=0, RESET=1, POST_RESET=2, X1=3, X2=4, X3=5, Y1=6, Y2=7,ERROR_X=8,ERROR_Y=9;
    reg [3:0] state, next;
    reg temp_g;

    always @(*) begin
        case (state)
            WAIT_RESET: next = resetn ? RESET : WAIT_RESET;
            RESET: next = POST_RESET;
            POST_RESET: next = x ? X1 : ERROR_X;
            X1: next = x ? ERROR_X : X2;
            X2: next = x ? X3 : ERROR_X;
            X3: next = y ? Y2 : Y1;
            ERROR_X: next = ERROR_X;
            Y1: next = y ? Y2 : ERROR_Y;
            Y2: next = Y2;
            ERROR_Y: next = ERROR_Y;
        endcase

        if (state == RESET) begin
            f = 1'b1;
        end 
        else begin
            f = 1'b0;
        end
    end

    always @(posedge clk) begin
        if (!resetn) begin
            state <= WAIT_RESET;
            temp_g <= 1'b0;
        end
        else begin
            state <= next;
            
            if (state == Y2) begin
                temp_g <= 1'b1;
            end
            else if (state == ERROR_Y) begin
                temp_g <= 1'b0;
            end
            else if (state == X3 || state == Y1) begin
                temp_g <= 1'b1;
            end
        end
        
    end

    assign g = temp_g;

endmodule





// module top_module (
//     input clk,
//     input resetn,    // active-low synchronous reset
//     input x,
//     input y,
//     output f,
//     output g
// ); 
//     parameter A=0,X1=1,X2=2,X3=3,PENDING=4,FINAL=5,NOT_Y=6;
//     reg [2:0] state, next;
    
//     parameter WAIT_RESET=0, RESET=1, POST_RESET=2;
//     reg [2:0] reset_state, reset_next;
    
//     integer counter = 0;

//     always @(*) begin
//         case (state)
//             A: next = x && reset_state == POST_RESET ? X1 : A;
//             X1: next = x ? X1 : X2;
//             X2: next = x ? X3 : X1;
//             X3: next = y ? FINAL : PENDING;
//             PENDING: next = y ? FINAL : NOT_Y;
//             FINAL: next = FINAL;
//             NOT_Y: next = NOT_Y;
//         endcase

//         if (state == FINAL) begin
//             g = 1'b1;
//         end
//         else if (state == NOT_Y) begin
//             g = 1'b0;
//         end
//         else if (state == X3) begin
//             g = 1'b1;
//         end
//         else begin
//             g = 1'b0;
//         end
//     end

//     always @(*) begin
//         case (reset_state)
//             WAIT_RESET: reset_next = resetn ? RESET : WAIT_RESET;
//             RESET: reset_next = POST_RESET;
//             POST_RESET: reset_next = resetn ? POST_RESET : WAIT_RESET;
//         endcase

//         if (reset_state == RESET) begin
//             f = 1'b1;
//         end 
//         else begin
//             f = 1'b0;
//         end
//     end

//     always @(posedge clk) begin
//         if (!resetn) begin
//             state <= A;
//             reset_state <= WAIT_RESET;
//             // f <= 1'b0;
//             // g <= 1'b0;
//             // counter <= 0;
//         end
//         else begin
//             state <= next;
//             reset_state <= reset_next;
//             // f <= 1'b1;
//             // g <= state == X3;
            
//             // if (state == X3) begin
//             //     counter <= counter + 1;
//             //     if (counter > 2) begin
                    
//             //     end
//             // end
//             // else begin
//             //     counter <= counter;
//             // end
//         end
//     end

// endmodule
