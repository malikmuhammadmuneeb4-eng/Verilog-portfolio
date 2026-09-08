module mooremachine(
    input clk, reset,
    output [1:0] state,
    output [2:0] light
);
    parameter RED = 2'b00, GREEN = 2'b01, YELLOW = 2'b10;
    reg [1:0] state;

    // Block 1: Sequential - state register
    always @(posedge clk)
    begin
        if (reset) state <= RED;
        else if (state == RED) state <= GREEN;
        else if (state == GREEN) state <= YELLOW;
        else state <= RED;
    end

    reg [2:0] light;

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
endmodule
