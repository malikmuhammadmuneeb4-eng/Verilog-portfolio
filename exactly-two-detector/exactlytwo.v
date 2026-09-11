module exactlytwo(
    input a, b, c,
    output reg y
);
    always @(*)
    begin
        y = (~a&b&c) | (a&~b&c) | (a&b&~c);
    end
endmodule
