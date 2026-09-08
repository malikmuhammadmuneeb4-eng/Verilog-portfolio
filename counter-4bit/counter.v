module counter (
    input clk, reset,
    output [3:0] cout
);
    reg [3:0] cout;

    always @(posedge clk)
    begin
        if (reset) cout <= 0;
        else       cout <= cout + 1;
    end
endmodule
