typedef enum logic {idle, waiting} state_t;

module vending_machine(
    input  logic clk, reset,
    input  logic coin_in,      // raw signal - may stay high for multiple cycles
    output state_t state,
    output logic dispense
);
    logic coin_in_prev;
    logic coin_pulse;

    always_ff @(posedge clk)
    begin
        coin_in_prev <= coin_in;   // remember last cycle's value
    end

    assign coin_pulse = coin_in & ~coin_in_prev;
    // coin_pulse = 1 only on the exact 0->1 transition (genuine new coin),
    // regardless of how long coin_in is held high afterward

    always_ff @(posedge clk)
    begin
        if (reset) state <= idle;
        else if (state==idle) begin
            if (coin_pulse==0) state <= idle;
            else state <= waiting;
        end
        else if (state==waiting) begin
            if (coin_pulse==1) state <= idle;
            else state <= waiting;
        end
        else state <= idle;
    end

    always_comb
    begin
        // Mealy: dispense fires immediately when the SECOND coin arrives while
        // already waiting (first 5 cents already registered)
        if (state==waiting && coin_pulse==1) dispense = 1'b1;
        else dispense = 1'b0;
    end
endmodule
