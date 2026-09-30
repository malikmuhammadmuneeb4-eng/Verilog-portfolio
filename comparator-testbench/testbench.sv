module testbench;
reg [3:0]a,b;
integer i;
wire LT, GT, EQ;
reg expected_LT,expected_GT,expected_EQ;
comparator4bit C0(.a(a), .b(b), .LT(LT), .GT(GT), .EQ(EQ));
initial begin
    for (i=0; i<256; i=i+1) begin
    {a,b}=i;
    #10;
    if (a>b) {expected_LT,expected_GT,expected_EQ}=3'b010;
    else if (a<b) {expected_LT,expected_GT,expected_EQ}=3'b100;
    else {expected_LT,expected_GT,expected_EQ}=3'b001;
    if (LT==expected_LT && GT==expected_GT && EQ==expected_EQ)
    $display("PASS: a=%b b=%b -> LT=%b GT=%b EQ=%b", a,b,LT,GT,EQ);
    else $display ("FAIL: a=%b b=%b -> LT=%b GT=%b EQ=%b expected LT=%b GT=%b EQ=%b", a,b,LT,GT,EQ,expected_LT,expected_GT,expected_EQ);
    end
end
endmodule
