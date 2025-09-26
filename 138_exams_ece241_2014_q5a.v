module top_module (
    input clk,
    input areset,
    input x,
    output z
); 

    parameter IDLE=0, INVERT=1;
    reg [1:0] state, next;
    reg temp_z;

    always @(*) begin
        case (state) 
            IDLE: next = x ? INVERT : IDLE;
            INVERT: next = INVERT;
        endcase
        
    end

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= IDLE;
            temp_z <= 1'b0;
        end
        else begin
            state <= next;
            
            if (state == IDLE && x) begin
                temp_z <= x;
            end
            else if (state == INVERT) begin
                temp_z <= ~x;
            end
            else begin
                temp_z <= 1'b0;
            end
        end
    end

    assign z = temp_z;

endmodule



// sample answer from GitHub
module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    
    parameter S0 = 0, S1 = 1, S2 = 2;
    reg [1:0] state;
    reg [1:0] next_state;
    
    always @(*) begin
        case(state)
            S0 : begin
                next_state = x ? S1 : S0;
                z = 1'b0;
            end
            
            S1 : begin
                next_state = x ? S2 : S1;
                z = 1'b1;
            end
            
            S2 : begin
                next_state = x ? S2 : S1;
                z = 1'b0;
            end
            default : begin
                next_state = S0;
                z = 1'b0;
            end
        endcase
    end
    
    always @(posedge clk or posedge areset) begin
        if(areset)  
            state <= S0;
        else
            state <= next_state;
    end
    

endmodule