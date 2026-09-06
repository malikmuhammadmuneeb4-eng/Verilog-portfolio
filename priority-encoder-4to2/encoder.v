module encoder(
    input  i0, i1, i2, i3,
    output a, b, valid
);
    reg a;
    reg b;
    reg valid;
    always @(*)
    begin
        casez({i3,i2,i1,i0})
            4'b1???: {a,b,valid} = 3'b111;
            4'b01??: {a,b,valid} = 3'b101;
            4'b001?: {a,b,valid} = 3'b011;
            4'b0001: {a,b,valid} = 3'b001;
            4'b0000: {a,b,valid} = 3'b000;
        endcase
    end
endmodule
