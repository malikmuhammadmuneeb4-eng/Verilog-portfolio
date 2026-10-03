typedef enum logic {STATE_A, STATE_B} state_t;

module toggle_fsm(
    input logic clk, reset,
    output state_t state
);
    always_ff @(posedge clk)
    begin
        if (reset) state <= STATE_A;
        else if (state==STATE_A) state <= STATE_B;
        else state <= STATE_A;
    end
endmodule
