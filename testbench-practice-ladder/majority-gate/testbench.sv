module tb;
reg a,b,c;
wire y;
integer i;
reg expected_y;

majority M0(.a(a),.b(b),.c(c),.y(y));
initial begin
    for (i=0; i<8; i=i+1) begin
        {a,b,c}=i;
        #10;
        if (a==1'b1 && b==1'b1 && c==1'b1 ) expected_y=1'b1;
        else if (a==1'b1 && b==1'b1 && c==1'b0 ) expected_y=1'b1;
        else if (a==1'b1 && b==1'b0 && c==1'b1 ) expected_y=1'b1;
        else if (a==1'b0 && b==1'b1 && c==1'b1 ) expected_y=1'b1;
        else expected_y=1'b0;
        if (y==expected_y)
        $display("PASS: a=%b b=%b c=%b -> y=%b",a,b,c,y);
        else
        $display("FAIL: a=%b b=%b c=%b -> y=%b expected y=%b",a,b,c,y,expected_y);
    end
end
endmodule
