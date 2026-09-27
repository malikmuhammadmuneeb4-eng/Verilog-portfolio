typedef enum logic[1:0]{
    x,y,z
}button_t;
typedef enum logic [1:0]{
    s0,s1,s2
}state_t;

module xyz_seq_detector_function(
    input logic clk, reset,
    input button_t button,
    output state_t state,
    output logic unlock
);
    function state_t next_state_logic(input state_t state, input button_t button);
        if (state==s0) begin
            if (button==x) next_state_logic =s1;
            else if (button==y)next_state_logic =s0;
            else next_state_logic = s0;
        end
        else if (state==s1) begin
            if (button==x) next_state_logic = s1;
            else if (button==y) next_state_logic =s2;
            else next_state_logic = s0;
        end
        else if (state==s2) begin
            if (button==x)next_state_logic =s1;
            else if (button==y) next_state_logic =s0;
            else next_state_logic =s0;
        end
    endfunction

    always_ff @(posedge clk)
    begin
        if (reset) state <= s0;
        else state <= next_state_logic(state, button);
    end

    always_comb
    begin
        if (state==s2 && button==z) unlock=1'b1;
        else unlock=1'b0;
    end
endmodule
