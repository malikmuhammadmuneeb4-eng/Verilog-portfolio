module decoder2to4 (
    input  a, b,
    output y0, y1, y2, y3
);
    reg y0, y1, y2, y3;
    always @(*)
    begin
        case({a,b})
            2'd0: {y3,y2,y1,y0} = 4'b0001;
            2'd1: {y3,y2,y1,y0} = 4'b0010;
            2'd2: {y3,y2,y1,y0} = 4'b0100;
            2'd3: {y3,y2,y1,y0} = 4'b1000;
        endcase
    end
endmodule
