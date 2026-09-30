module priority_encoder(
    input logic i0, i1, i2, i3,
    output logic a, b
);
    always_comb begin
        casez({i3,i2,i1,i0})
            4'b1???: {a,b} = 2'b11;
            4'b01??: {a,b} = 2'b10;
            4'b001?: {a,b} = 2'b01;
            4'b0001: {a,b} = 2'b00;
            default: {a,b} = 2'b00;
        endcase
    end
endmodule
