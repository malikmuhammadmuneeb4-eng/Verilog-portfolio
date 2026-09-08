module downcounter (
    input clk, reset,
    output [3:0] cout
);
    reg [3:0] cout;

    always @(posedge clk)
    begin
        if (reset) cout <= 4'b1111;
        else       cout <= cout - 1;
    end
endmodule
