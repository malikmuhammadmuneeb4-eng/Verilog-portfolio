module encoder(
    input i0, i1, i2, i3,
    output a, b,
    output valid
);
    reg a, b, valid; // valid distinguishes "no input active" from "i0 active" (both would
                      // otherwise encode as a=0,b=0)
    always @(*)
    begin
        case({i0,i1,i2,i3})
            4'b1000: {a,b,valid} = 3'b001;
            4'b0100: {a,b,valid} = 3'b011;
            4'b0010: {a,b,valid} = 3'b101;
            4'b0001: {a,b,valid} = 3'b111;
            4'b0000: {a,b,valid} = 3'b000;
        endcase
    end
endmodule
