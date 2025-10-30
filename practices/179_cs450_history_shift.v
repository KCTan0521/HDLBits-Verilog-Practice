module top_module(
    input clk,
    input areset,

    input predict_valid,
    input predict_taken,
    output [31:0] predict_history,

    input train_mispredicted,
    input train_taken,
    input [31:0] train_history
);

    reg [2:0] history_counter;

    always @(*) begin

    end
    
    // haven't completed
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            history_counter <= 3'b0;
        end
        else begin
        
        
        end


    end

endmodule
