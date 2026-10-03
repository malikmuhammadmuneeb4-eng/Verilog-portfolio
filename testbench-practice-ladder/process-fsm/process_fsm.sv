typedef enum logic [1:0] {IDLE, RUNNING, DONE} proc_state_t;

module simple_process_fsm(
    input logic clk, reset, start, stop,
    output proc_state_t state
);
    always_ff @(posedge clk)
    begin
        if (reset) state <= IDLE;
        else begin
            case(state)
                IDLE:    if (start) state <= RUNNING;
                RUNNING: if (stop) state <= DONE;
                DONE:    state <= IDLE;
                default: state <= IDLE;
            endcase
        end
    end
endmodule
