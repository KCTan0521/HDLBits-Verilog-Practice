// kc opinion : in some situation, especially there is a limit on memory size
// hard code the value will be a better choice
// rather than using more variables, functions, for loops
// in order to save memory

// answer from GitHub
module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q ); 

    reg [3:0] sum;

    always @(posedge clk) begin
        if (load) begin
            q  <= data;
        end
        else begin
            for (integer i = 0; i < 256; i++) begin
                if (i == 0) begin
                    sum = q[1]+q[16]+q[17]+q[240]+q[241]+q[15]+q[31]+q[255];
                end
                else if (i == 15) begin
                    sum = q[14]+q[16]+q[0]+q[240]+q[254]+q[30]+q[31]+q[255];
                end
                else if (i == 240) begin
                    sum = q[0]+q[15]+q[239]+q[241]+q[1]+q[224]+q[225]+q[255];
                end
                else if (i == 255) begin
                    sum = q[0]+q[15]+q[14]+q[224]+q[238]+q[240]+q[239]+q[254];
                end
                else if (i > 0 && i < 15) begin
                    sum = q[i-1]+q[i+1]+q[i+15]+q[i+16]+q[i+17]+q[i+239]+q[i+240]+q[i+241];
                end
                else if (i % 16 == 0) begin
                    sum = q[i-1]+q[i+1]+q[i+15]+q[i+16]+q[i+17]+q[i-16]+q[i-15]+q[i+31];
                end
                else if (i % 16 == 15) begin
                    sum = q[i-1]+q[i+1]+q[i+15]+q[i+16]+q[i-17]+q[i-16]+q[i-15]+q[i-31];
                end
                else if (i > 240 && i < 255) begin
                    sum = q[i-1]+q[i+1]+q[i-17]+q[i-16]+q[i-15]+q[i-239]+q[i-240]+q[i-241];
                end
                else begin
                    sum = q[i-1]+q[i+1]+q[i-17]+q[i-16]+q[i-15]+q[i+15]+q[i+16]+q[i+17];
                end

                if ((sum == 0 || sum == 1) || (sum >= 4)) begin
                    q[i] <= 0;
                end
                else if (sum == 3) begin
                    q[i] <= 1;
                end
            end
        end
    end

endmodule

// kc answer
// but cannot verify correct or not (kc think most likely it is wrong)
// because allocated memory not sufficient to run the program
module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q ); 

    wire [255:0] next_q;
    integer i,j;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end
        else begin
            q <= next_q;
        end
    end

    always @(*) begin
        int neighbors = 0;

        for (i = 0; i < 256; i = i + 1) begin: loop3
            // Count live neighbors (8 neighbors)
            // left, center, right
            // top, middle, bottom
            neighbors += q[index_func(i-16-1)]; // TL
            neighbors += q[index_func(i-16)]; // TC
            neighbors += q[index_func(i-16+1)]; // TR
            neighbors += q[index_func(i-1)]; // ML
            neighbors += q[index_func(i+1)]; // MR
            neighbors += q[index_func(i+16-1)]; // BL
            neighbors += q[index_func(i+16)]; // BC
            neighbors += q[index_func(i+16+1)]; // BR

            // Apply rules:
            // 0-1 neighbors -> 0
            // 2 neighbors -> same
            // 3 neighbors -> 1
            // 4+ neighbors -> 0
            if (neighbors <= 1)
                next_q[i] = 1'b0;
            else if (neighbors == 2)
                next_q[i] = q[i];
            else if (neighbors == 3)
                next_q[i] = 1'b1;
            else
                next_q[i] = 1'b0;
        end
    end

    function int index_func(input int value);
        // cannot directly modify value
        // because parameters in functions are read-only
        int temp;
        temp = value;

        if (temp < 0)
            temp = temp + 56;
        else if (temp > 56)
            temp = temp - 56;

        index_func = temp;
    endfunction

endmodule


// answer from ChatGPT
// but cannot verify correct or not
// because allocated memory not sufficient to run the program
module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);
    // Parameters
    localparam WIDTH = 16;
    localparam HEIGHT = 16;

    // Convert flat vector to 2D array for easier indexing
    wire grid [0:HEIGHT-1][0:WIDTH-1];
    genvar r, c;
    generate
        for (r = 0; r < HEIGHT; r = r + 1) begin: loop1
            for (c = 0; c < WIDTH; c = c + 1) begin: loop2
                assign grid[r][c] = q[r*WIDTH + c];
            end
        end
    endgenerate

    // Next state grid (combinational)
    reg next_grid [0:HEIGHT-1][0:WIDTH-1];

    integer i, j;

    // Function to wrap indices toroidally
    function automatic int wrap(input int idx, input int max);
        if (idx < 0) 
            wrap = max - 1;
        else if (idx >= max)
            wrap = 0;
        else
            wrap = idx;
    endfunction

    always @(*) begin
        for (i = 0; i < HEIGHT; i = i + 1) begin: loop3
            for (j = 0; j < WIDTH; j = j + 1) begin: loop4
                // Count live neighbors (8 neighbors)
                int neighbors = 0;
                neighbors += grid[wrap(i-1, HEIGHT)][wrap(j-1, WIDTH)];
                neighbors += grid[wrap(i-1, HEIGHT)][j];
                neighbors += grid[wrap(i-1, HEIGHT)][wrap(j+1, WIDTH)];
                neighbors += grid[i][wrap(j-1, WIDTH)];
                neighbors += grid[i][wrap(j+1, WIDTH)];
                neighbors += grid[wrap(i+1, HEIGHT)][wrap(j-1, WIDTH)];
                neighbors += grid[wrap(i+1, HEIGHT)][j];
                neighbors += grid[wrap(i+1, HEIGHT)][wrap(j+1, WIDTH)];

                // Apply rules:
                // 0-1 neighbors -> 0
                // 2 neighbors -> same
                // 3 neighbors -> 1
                // 4+ neighbors -> 0
                if (neighbors <= 1)
                    next_grid[i][j] = 1'b0;
                else if (neighbors == 2)
                    next_grid[i][j] = grid[i][j];
                else if (neighbors == 3)
                    next_grid[i][j] = 1'b1;
                else
                    next_grid[i][j] = 1'b0;
            end
        end
    end

    genvar rn, cn;
    // Flatten next_grid into a vector
    wire [255:0] next_q;
    generate
        for (rn = 0; rn < HEIGHT; rn = rn + 1) begin:loop5
            for (cn = 0; cn < WIDTH; cn = cn + 1) begin:loop6
                assign next_q[rn*WIDTH + cn] = next_grid[rn][cn];
            end
        end
    endgenerate

    always @(posedge clk) begin
        if (load)
            q <= data;
        else
            q <= next_q;
    end

endmodule
