module demux(
    input d,
    input s1, s0,
    output y0, y1, y2, y3
);
    reg y0, y1, y2, y3;
    always @(*)
    begin
        case ({s1,s0})
            2'b00: {y0,y1,y2,y3} = {d,1'b0,1'b0,1'b0};
            2'b01: {y0,y1,y2,y3} = {1'b0,d,1'b0,1'b0};
            2'b10: {y0,y1,y2,y3} = {1'b0,1'b0,d,1'b0};
            2'b11: {y0,y1,y2,y3} = {1'b0,1'b0,1'b0,d};
        endcase
    end
endmodule
