module mux2to1 (
    input  i0,
    input  i1,
    input  s,
    output y
);
    reg y;
    always @(*)
    begin
        case(s)
            1'd0: y = i0;
            1'd1: y = i1;
        endcase
    end
endmodule
