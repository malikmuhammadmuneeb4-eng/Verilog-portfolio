module testbench;
    reg a, b, cin;
    wire sum, cout;
    integer i;
    reg expected_sum, expected_cout;

    fulladder DUT (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

    initial begin
        for (i=0; i<8; i=i+1) begin
            {a,b,cin} = i;
            #10;
            expected_sum = a ^ b ^ cin;
            expected_cout = (a&b) | (a&cin) | (b&cin);
            if (sum==expected_sum && cout==expected_cout)
                $display("PASS: a=%b b=%b cin=%b", a, b, cin);
            else
                $display("FAIL: a=%b b=%b cin=%b -> got sum=%b cout=%b, expected sum=%b cout=%b",
                          a,b,cin,sum,cout,expected_sum,expected_cout);
        end
    end
endmodule
