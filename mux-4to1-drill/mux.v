module mux(
    input i0, i1, i2, i3,
    input s0, s1,
    output y
);
    reg y;
    always @(*)
    begin
        case ({s0,s1})
            2'b00: y = i0;
            2'b01: y = i1;
            2'b10: y = i2;
            2'b11: y = i3;
        endcase
    end
endmodule
