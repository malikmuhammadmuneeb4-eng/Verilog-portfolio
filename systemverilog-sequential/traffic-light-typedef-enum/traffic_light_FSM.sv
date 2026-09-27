typedef enum logic [1:0] {red, green, yellow} state_t;

module traffic_light_FSM(
    input  logic clk, reset,
    output state_t state,
    output logic [2:0] light
);
    always_ff @(posedge clk)
    begin
        if (reset) state <= red;
        else if (state==red) state <= green;
        else if (state==green) state <= yellow;
        else if (state==yellow) state <= red;
    end

    always_comb
    begin
        case(state)
            red:     light = 3'b100;
            green:   light = 3'b010;
            yellow:  light = 3'b001;
            default: light = 3'b000;
        endcase
    end
endmodule
