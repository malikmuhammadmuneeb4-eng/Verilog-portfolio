module mux(
    input  logic a,b,select,
    output logic y
);
    always_comb
    begin
        case(select)
            1'b0: y=a;
            1'b1: y=b;
        endcase
    end
endmodule
