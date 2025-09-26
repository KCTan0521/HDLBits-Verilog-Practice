module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q
);

    integer i;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end
        else begin
            q[0] <= rule110(q[1], q[0], 0);
            for (i=1; i<511; i=i+1) begin
                q[i] <= rule110(q[i+1], q[i], q[i-1]);
            end
            q[511] <= rule110(0, q[511], q[510]);
        end
    end

    function rule110;
        input a,b,c;
        begin
            if ((a == b && b == c) || a & ~b & ~c ) begin
                rule110 = 0;
            end
            else begin
                rule110 = 1;
            end
        end
    endfunction
endmodule


