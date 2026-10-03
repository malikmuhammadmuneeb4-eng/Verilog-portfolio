module tb;
reg a,b;
wire y;
reg expected_y;

xor_gate X0(.a(a), .b(b), .y(y));

initial begin
    a=0; b=0;
    expected_y=1'b0;
    #10;
    if (y==expected_y)
    $display("PASS a=%b b=%b -> y=%b",a,b,y);
    else
    $display("FAIL a=%b b=%b -> y=%b expected y=%b",a,b,y,expected_y);

    #10;
    a=0; b=1;
    expected_y=1'b1;
    #10;
    if (y==expected_y)
    $display("PASS a=%b b=%b -> y=%b",a,b,y);
    else
    $display("FAIL a=%b b=%b -> y=%b expected y=%b",a,b,y,expected_y);
    #10;

    a=1; b=0;
    expected_y=1'b1;
    #10;
    if (y==expected_y)
    $display("PASS a=%b b=%b -> y=%b",a,b,y);
    else
    $display("FAIL a=%b b=%b -> y=%b expected y=%b",a,b,y,expected_y);
    #10;

    a=1; b=1;
    expected_y=1'b0;
    #10;
    if (y==expected_y)
    $display("PASS a=%b b=%b -> y=%b",a,b,y);
    else
    $display("FAIL a=%b b=%b -> y=%b expected y=%b",a,b,y,expected_y);
    #10;
end
endmodule
