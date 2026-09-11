module decoder(
    input a, b, c,
    output y0, y1, y2, y3, y4, y5, y6, y7
);
    reg y0, y1, y2, y3, y4, y5, y6, y7;
    always @(*)
    begin
        case({a,b,c})
            3'b000: {y0,y1,y2,y3,y4,y5,y6,y7} = 8'b10000000;
            3'b001: {y0,y1,y2,y3,y4,y5,y6,y7} = 8'b01000000;
            3'b010: {y0,y1,y2,y3,y4,y5,y6,y7} = 8'b00100000;
            3'b011: {y0,y1,y2,y3,y4,y5,y6,y7} = 8'b00010000;
            3'b100: {y0,y1,y2,y3,y4,y5,y6,y7} = 8'b00001000;
            3'b101: {y0,y1,y2,y3,y4,y5,y6,y7} = 8'b00000100;
            3'b110: {y0,y1,y2,y3,y4,y5,y6,y7} = 8'b00000010;
            3'b111: {y0,y1,y2,y3,y4,y5,y6,y7} = 8'b00000001;
        endcase
    end
endmodule
