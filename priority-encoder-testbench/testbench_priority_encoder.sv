module testbench_priority_encoder;
    reg i0,i1,i2,i3;
    integer i;
    wire a,b;
    reg expected_a, expected_b;

    priority_encoder PE0(.i0(i0), .i1(i1), .i2(i2), .i3(i3), .a(a), .b(b));

    initial begin
        for (i=0; i<16; i=i+1) begin
            {i0,i1,i2,i3} = i;
            #10;
            if (i3==1) {expected_a,expected_b}=2'b11;
            else if (i2==1 && i3==0) {expected_a,expected_b}=2'b10;
            else if (i1==1 && i3==0 && i2==0) {expected_a,expected_b}=2'b01;
            else {expected_a,expected_b}=2'b00;

            if (a==expected_a && b==expected_b)
                $display("PASS: i0=%b i1=%b i2=%b i3=%b -> a=%b b=%b",i0,i1,i2,i3,a,b);
            else
                $display("FAIL: i0=%b i1=%b i2=%b i3=%b -> a=%b b=%b expected a=%b b=%b",
                          i0,i1,i2,i3,a,b,expected_a,expected_b);
        end
    end
endmodule
