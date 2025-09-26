module top_module (
    input clk,
    input reset,
    input ena,
    output pm, 
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss
);
    integer i;

    reg [7:0] t_hh, t_mm, t_ss;
    reg t_pm;

    bin2bcd b2b0 (
        .bin(t_hh),
        .bcd(hh)
    );
    bin2bcd b2b1 (
        .bin(t_mm),
        .bcd(mm)
    );
    bin2bcd b2b2 (
        .bin(t_ss),
        .bcd(ss)
    );

    assign pm = t_pm;

    always @(posedge clk) begin

        if (reset) begin
            t_hh <= 8'd12;    
            t_mm <= 8'd0;    
            t_ss <= 8'd0;    
            t_pm <= 1'd0;
        end
        else begin

            // kc thought that ena is like a timer adder, when it is 1 kc need to add 1 more second
            // but actually it is just a toggle, like it is 1 then clock continue to execute
            // if it is 0 then do not execute the clock
            // for (i=0; i < ena + 1'd1; i=i+1 ) begin

            // extra:
            // clk signal is very fast, i.e. 50, 100Mhz
            // the ena signal in this case is slower than clk to mimic normal clock speed
            for (i=0; i < ena; i=i+1 ) begin
                if (t_ss == 8'd59) begin
                    t_ss <= 8'd0;
                    if (t_mm == 8'd59) begin
                        t_mm <= 8'd0;
                        if (t_hh == 8'd11) begin
                            t_hh <= 8'd12;
                            t_pm <= ~t_pm;
                        end
                        else if (t_hh == 8'd12) begin
                            t_hh <= 8'd1;
                        end
                        else begin
                            t_hh <= t_hh + 8'd1;
                        end
                    end
                    else begin
                        t_mm <= t_mm + 8'd1;
                    end
                end
                else begin
                    t_ss <= t_ss + 8'd1;
                end
            end
        end
    end

endmodule


module bin2bcd (
    input [7:0] bin,
    output [7:0] bcd
);

    // because the highest number will be passed is 59
    // hence kc thinks it is okay to do so
    assign bcd[3:0] = bin % 5'd10;
    assign bcd[7:4] = bin / 5'd10;

endmodule

// sample answer 2 from chatgpt
module top_module (
    input clk,
    input reset,
    input ena,
    output pm, 
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss
);

    reg [7:0] t_hh, t_mm, t_ss;
    reg t_pm;

    assign pm = t_pm;

    bin2bcd b2b0 (.bin(t_hh), .bcd(hh));
    bin2bcd b2b1 (.bin(t_mm), .bcd(mm));
    bin2bcd b2b2 (.bin(t_ss), .bcd(ss));

    always @(posedge clk) begin
        if (reset) begin
            t_hh <= 8'd12;    
            t_mm <= 8'd0;    
            t_ss <= 8'd0;    
            t_pm <= 1'b0;  // AM
        end
        else if (ena) begin
            // Handle seconds
            if (t_ss == 8'd59) begin
                t_ss <= 8'd0;

                // Handle minutes
                if (t_mm == 8'd59) begin
                    t_mm <= 8'd0;

                    // Handle hours
                    if (t_hh == 8'd11) begin
                        t_hh <= 8'd12;
                        t_pm <= ~t_pm; // Toggle PM at 11 -> 12
                    end
                    else if (t_hh == 8'd12) begin
                        t_hh <= 8'd1;
                    end
                    else begin
                        t_hh <= t_hh + 8'd1;
                    end

                end else begin
                    t_mm <= t_mm + 8'd1;
                end
            end else begin
                t_ss <= t_ss + 8'd1;
            end
        end
    end

endmodule


module bin2bcd (
    input [7:0] bin,
    output [7:0] bcd
);
    assign bcd[3:0] = bin % 10;
    assign bcd[7:4] = bin / 10;
endmodule


// sample answer from chatgpt
module top_module (
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh, // BCD hours (01–12)
    output reg [7:0] mm, // BCD minutes (00–59)
    output reg [7:0] ss  // BCD seconds (00–59)
);

    // Helper function to increment BCD
    function [7:0] bcd_increment(input [7:0] bcd, input [7:0] max);
        if (bcd[3:0] == 4'd9) begin
            if (bcd[7:4] == (max / 10)) begin
                bcd_increment = 8'd0;
            end else begin
                bcd_increment = {bcd[7:4] + 1'b1, 4'd0};
            end
        end else begin
            bcd_increment = {bcd[7:4], bcd[3:0] + 1'b1};
        end
    endfunction

    // BCD to binary comparison helper
    function is_bcd_equal(input [7:0] bcd, input [7:0] value);
        is_bcd_equal = ((bcd[7:4] * 4'd10 + bcd[3:0]) == value);
    endfunction

    always @(posedge clk) begin
        if (reset) begin
            ss <= 8'h00;
            mm <= 8'h00;
            hh <= 8'h12;  // 12:00:00
            pm <= 1'b0;   // AM
        end
        else if (ena) begin
            // Increment seconds
            if (is_bcd_equal(ss, 59)) begin
                ss <= 8'h00;

                // Increment minutes
                if (is_bcd_equal(mm, 59)) begin
                    mm <= 8'h00;

                    // Check if hour is 11 before increment
                    if (is_bcd_equal(hh, 11)) begin
                        hh <= 8'h12;
                        pm <= ~pm;  // Toggle AM/PM at 11 ➝ 12
                    end
                    else if (is_bcd_equal(hh, 12)) begin
                        hh <= 8'h01;
                    end
                    else begin
                        hh <= bcd_increment(hh, 12);
                    end
                end
                else begin
                    mm <= bcd_increment(mm, 59);
                end
            end
            else begin
                ss <= bcd_increment(ss, 59);
            end
        end
    end
endmodule


// module top_module (
//     input clk,
//     input reset,
//     input ena,
//     output pm, 
//     output [7:0] hh,
//     output [7:0] mm,
//     output [7:0] ss
// );
//     integer i;

//     always @(posedge clk) begin

//         if (reset) begin
//             hh <= 8'b00010010;    
//             mm <= 8'd0;    
//             ss <= 8'd0;    
//             pm <= 1'd0;
//         end
//         else begin
//             for (i=0; i < ena + 1'd1; i=i+1 ) begin
//                 if (ss == 8'd59) begin
//                     ss <= 8'd0;
//                     if (mm == 8'd59) begin
//                         if (hh == 8'd12) begin
//                             hh <= 8'd1;
//                             pm = ~pm;
//                         end
//                         else begin
//                             hh <= hh + 8'd1;
//                         end
//                     end
//                     else begin
//                         mm <= mm + 8'd0;
//                     end
//                 end
//                 else begin
//                     ss <= ss + 8'd0;
//                 end
//             end
//         end
//     end

// endmodule