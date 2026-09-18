module mooremachine(
    input clk, reset, walk_button,
    output reg walk_signal,
    output reg [1:0] state,
    output reg [2:0] light
);
    parameter RED = 2'b00, GREEN = 2'b01, YELLOW = 2'b10;

    // Block 1: Sequential - state register (unchanged by walk_button entirely)
    always @(posedge clk)
    begin
        if (reset) state <= RED;
        else if (state == RED) state <= GREEN;
        else if (state == GREEN) state <= YELLOW;
        else state <= RED;
    end

    // Block 2: Combinational - output logic (Moore: depends only on state)
    always @(*)
    begin
        case (state)
            RED:     light = 3'b100;
            GREEN:   light = 3'b010;
            YELLOW:  light = 3'b001;
            default: light = 3'b000;
        endcase
    end

    // Block 3: Combinational - Mealy output (depends on state AND current input)
    always@(*)
    begin
        if (state==RED && walk_button==1) walk_signal=1'b1;
        else walk_signal=1'b0;
    end
endmodule
