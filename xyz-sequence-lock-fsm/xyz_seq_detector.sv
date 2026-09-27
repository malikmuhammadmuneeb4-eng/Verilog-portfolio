typedef enum logic[1:0]{
    x,y,z
}button_t;
typedef enum logic [1:0]{
    s0,s1,s2
}state_t;

module xyz_seq_detector(
    input logic clk, reset,
    input button_t button,
    output state_t state,
    output logic unlock
);
    always_ff @(posedge clk)
    begin
        if (reset) state <= s0;
        else if (state==s0) begin
            if (button==x) state <= s1;
            else if (button==y) state <= s0;
            else state <= s0;
        end
        else if (state==s1) begin
            if (button==x) state <= s1;
            else if (button==y) state <=s2;
            else state <= s0;
        end
        else if (state==s2) begin
            if (button==x) state<=s1;
            else if (button==y) state<=s0;
            else state <=s0;
        end
    end

    always_comb
    begin
        if (state==s2 && button==z) unlock=1'b1;
        else unlock=1'b0;
    end
endmodule
