// Bitwise XNOR technique - simpler and less error-prone than nested if/else
// when only equality (not GT/LT) is needed.
module equalitychecker_4bit (
    input [3:0] a, b,
    output reg eq
);
    always @(*)
    begin
        eq = (a[0]~^b[0]) & (a[1]~^b[1]) & (a[2]~^b[2]) & (a[3]~^b[3]);
    end
endmodule
