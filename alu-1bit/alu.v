module alu(
    input a, b,
    input [1:0] sel,
    output reg y
);
    always @(*)
    begin
        case(sel)
            2'b00: y = a&b;
            2'b01: y = a|b;
            2'b10: y = a^b;
            2'b11: y = ~a;
        endcase
    end
endmodule
