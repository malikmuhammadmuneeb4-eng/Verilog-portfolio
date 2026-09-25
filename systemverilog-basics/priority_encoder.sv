module pirority_encoder(
    input  logic i0,i1,i2,i3,
    output logic y0, y1
);
    always_comb
    begin
        casez({i0,i1,i2,i3})
            4'b???1: {y0,y1} = 2'b11;   // i3 = highest priority
            4'b??10: {y0,y1} = 2'b10;
            4'b?100: {y0,y1} = 2'b01;
            4'b1000: {y0,y1} = 2'b00;
            default: {y0,y1} = 2'b00;   // no input active
        endcase
    end
endmodule
