// kc answer
module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);

    parameter A=1'b0, B=1'b1;
    reg state, next;
    reg [2:0] data;
    reg[2:0] counter;
    reg temp_z;

    always @(*) begin
        case (state) 
            A: next = s ? B : A;
            B: next = B;
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            state <= A;
            data <= 3'b0;
            counter <= 0;
            temp_z <= 0;
        end
        else begin
            state <= next;

            if (state == B) begin
                if (counter == 2) begin
                    // last cycle of group, include current w
                    data <= 0;  // reset counter for next group
                    counter <= 0;

                    // Check sum of previous data + current w
                    if (data + w == 2) begin
                        temp_z <= 1;
                    end else begin
                        temp_z <= 0;
                    end
                end else begin
                    // accumulate w count and increment counter
                    data <= data + w;
                    counter <= counter + 1'b1;
                    temp_z <= 0;
                end
            end else begin
                // In state A reset everything
                counter <= 0;
                data <= 0;
                temp_z <= 0;
            end
        end
    end

    assign z = temp_z;

endmodule


// kc wrong answer
// module top_module (
//     input clk,
//     input reset,   // Synchronous reset
//     input s,
//     input w,
//     output z
// );

//     parameter A=1'b0, B=1'b1;
//     reg state, next;
//     reg [2:0] data;

//     always @(*) begin
//         case (state) 
//             A: next = s ? B : A;
//             B: next = B;
//         endcase
//     end

//     always @(posedge clk) begin
//         if (reset) begin
//             state <= A;
//             data <= 3'b0;
//         end
//         else begin
//             state <= next;
//         end

//         z <= 1'b0;
//         if (state == B) begin
//             data <= { data[1:0], w };
//             if (data[2] + data[1] + data[0] == 2'd2) begin
//                 z <= 1'b1;
//             end
//         end
//         else begin
//             data <= 3'b0;
//         end
        
//     end

// endmodule
