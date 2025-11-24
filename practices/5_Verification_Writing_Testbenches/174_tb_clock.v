module top_module ( );
    parameter time_period = 10;
    reg clock;

    initial begin
        clock = 0;
    end

    always begin
        #(time_period / 2) clock = ~clock;
    end

    dut dut1 (.clk(clock));
endmodule

// module provided by question
// module dut ( input clk ) ;