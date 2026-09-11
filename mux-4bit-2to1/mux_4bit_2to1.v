module mux_4bit_2to1(
    input [3:0] a, b,
    input s,
    output [3:0] y
);
    reg [3:0] y;
    always @(*)
    begin
        case(s)
            1'b0: y = a;
            1'b1: y = b;
        endcase
    end
endmodule
