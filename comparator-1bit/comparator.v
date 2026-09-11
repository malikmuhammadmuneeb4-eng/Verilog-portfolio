// Version 1: direct boolean expressions
module comparator(
    input a, b,
    output lt, gt, eq
);
    reg lt, gt, eq;
    always @(*)
    begin
        lt = ~a & b;
        gt = a & ~b;
        eq = (~a & ~b) | (a & b);
    end
endmodule


// Version 2: case-based, using concatenation (alternate style, same behavior)
module comparator_case(
    input a, b,
    output lt, gt, eq
);
    reg lt, gt, eq;
    always @(*)
    begin
        case({a,b})
            2'b00: {lt,gt,eq} = 3'b001;
            2'b01: {lt,gt,eq} = 3'b100;
            2'b10: {lt,gt,eq} = 3'b010;
            2'b11: {lt,gt,eq} = 3'b001;
        endcase
    end
endmodule
