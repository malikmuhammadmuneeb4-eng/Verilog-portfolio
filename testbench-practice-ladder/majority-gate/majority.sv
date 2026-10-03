module majority(
    input logic a, b, c,
    output logic y
);
    assign y = (a&b) | (b&c) | (a&c);
endmodule
