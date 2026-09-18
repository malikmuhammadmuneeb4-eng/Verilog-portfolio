module vendingmachine(
    input clk, reset, coin_in,
    output reg dispense, state
);
    parameter s1=1'b1, s0=1'b0;
    reg coin_in_prev;
    wire coin_pulse = coin_in & ~coin_in_prev;

    // Sequential: state register (driven by the debounced coin_pulse, not raw coin_in)
    always@(posedge clk)
    begin
        if (reset) state <= s0;
        else if (state==s0) begin
            if (coin_pulse==0) state <= s0;
            else state <= s1;
        end
        else if (state==s1) begin
            if (coin_pulse==1) state <= s0;
            else state <= s1;
        end
    end

    // Edge detector: converts a coin_in signal that may be held high for
    // many cycles into a single one-cycle pulse on its rising edge.
    always @(posedge clk) begin
        coin_in_prev <= coin_in;
    end

    // Combinational: Mealy output logic
    always@(*)
    begin
        if (state==s1 && coin_pulse==1) dispense=1'b1;
        else dispense=1'b0;
    end
endmodule
