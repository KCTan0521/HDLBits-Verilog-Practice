module top_module (
    input clk,
    input reset,
    input enable,
    output [3:0] Q,
    output c_enable,
    output c_load,
    output [3:0] c_d
);

    // Internal wires for control signals to count4
    reg load;
    reg enable_internal;
    reg [3:0] d;

    // Assign outputs for control signals
    assign c_load = load;
    assign c_enable = enable_internal;
    assign c_d = d;

    // Instantiate the provided 4-bit counter
    count4 counter (
        .clk(clk),
        .enable(enable_internal),
        .load(load),
        .d(d),
        .Q(Q)
    );

    // Logic to control count4 inputs
    always @(*) begin
        
        load = 1'b0;
        enable_internal = 1'b0;
        d = 4'b1;
        
        if (reset) begin
            load = 1;
            enable_internal = 0;
        end
        else if (enable) begin
            if (Q == 4'd12) begin
                load = 1;
                enable_internal = 0;
            end 
            else begin
                load = 0;
                enable_internal = 1;
            end
        end
    end
endmodule



// sample answer from ChatGPT
module top_module (
    input clk,
    input reset,
    input enable,
    output [3:0] Q,
    output c_enable,
    output c_load,
    output [3:0] c_d
);

    // Internal wires for control signals to count4
    reg load;
    reg enable_internal;
    reg [3:0] d;

    // Assign outputs for control signals
    assign c_load = load;
    assign c_enable = enable_internal;
    assign c_d = d;

    // Instantiate the provided 4-bit counter
    count4 counter (
        .clk(clk),
        .enable(enable_internal),
        .load(load),
        .d(d),
        .Q(Q)
    );

    // Logic to control count4 inputs
    always @(*) begin
        // Default: no load, no enable
        load = 0;
        enable_internal = 0;
        d = 4'b0001;  // value to load is always 1 when loading

        if (reset) begin
            // On reset, synchronously load 1
            load = 1;
            enable_internal = 0;
        end else if (enable) begin
            if (Q == 4'd12) begin
                // When count reaches 12, load 1 on next clock
                load = 1;
                enable_internal = 0;
            end else begin
                // Otherwise, count up
                load = 0;
                enable_internal = 1;
            end
        end else begin
            // enable == 0: hold current value (disable counting, no load)
            load = 0;
            enable_internal = 0;
        end
    end

endmodule


// provided by question
module count4(
	input clk,
	input enable,
	input load,
	input [3:0] d,
	output reg [3:0] Q
);
endmodule