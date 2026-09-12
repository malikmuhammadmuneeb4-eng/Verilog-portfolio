module sequencedectector(
    input clk, reset, x,
    output reg [1:0] state,
    output reg z
);
    parameter s0=2'b00, s1=2'b01, s2=2'b10, s3=2'b11;

    // Sequential: state register
    always@(posedge clk)
    begin
        if (reset) state <= s0;
        else if (state==s0) begin
            if (x==0) state <= s0;
            else state <= s1;
        end
        else if (state==s1) begin
            if (x==1) state <= s1;
            else state <= s2;
        end
        else if (state==s2) begin
            if (x==1) state <= s3;
            else state <= s0;
        end
        else if (state==s3) begin
            if (x==0) state <= s2;
            else state <= s1;
        end
    end

    // Combinational: Mealy output logic - depends on current state AND current input,
    // so detection fires immediately in the same cycle, not one cycle late.
    always@(*)
    begin
        if (state==s2 && x==1) z=1'b1;
        else z=1'b0;
    end
endmodule
