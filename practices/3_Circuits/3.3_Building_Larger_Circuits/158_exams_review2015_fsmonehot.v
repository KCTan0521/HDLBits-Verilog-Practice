module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output B3_next,
    output S_next,
    output S1_next,
    output Count_next,
    output Wait_next,
    output done,
    output counting,
    output shift_ena
); //

    // You may use these parameters to access state bits using e.g., state[B2] instead of state[6].
    parameter S=0, S1=1, S11=2, S110=3, B0=4, B1=5, B2=6, B3=7, Count=8, Wait=9;

    assign B3_next = state[6];
    assign S_next = (~d & state[0]) | (~d & state[1]) | (~d & state[3]) | (ack & state[9]);
    assign S1_next = d & state[0];
    assign Count_next = state[7] | (~done_counting & state[8]);
    assign Wait_next = (done_counting & state[8]) | (~ack & state[9]);
    assign done = state[9];
    assign counting = state[8];
    assign shift_ena = state[4] | state[5] | state[6] | state[7];
    
endmodule
