module decoder(
    input  logic a,b,
    output logic y0,y1,y2,y3
);
    always_comb
    begin
        case ({a,b})
            2'b00: {y0,y1,y2,y3} = 4'b1000;
            2'b01: {y0,y1,y2,y3} = 4'b0100;
            2'b10: {y0,y1,y2,y3} = 4'b0010;
            2'b11: {y0,y1,y2,y3} = 4'b0001;
            default: {y0,y1,y2,y3} = 4'b0000;
        endcase
    end
endmodule
