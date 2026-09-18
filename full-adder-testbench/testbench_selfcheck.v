module testbench;
    reg a, b, cin;
    wire sum, cout;

    fulladder DUT (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

    initial begin
        a=0; b=0; cin=0;
        #10;
        if (sum==0 && cout==0)
            $display("PASS: a=%b b=%b cin=%b", a, b, cin);
        else
            $display("FAIL: a=%b b=%b cin=%b -> got sum=%b cout=%b", a, b, cin, sum, cout);

        a=0; b=1; cin=0;
        #10;
        if (sum==1 && cout==0)
            $display("PASS: a=%b b=%b cin=%b", a, b, cin);
        else
            $display("FAIL: a=%b b=%b cin=%b -> got sum=%b cout=%b", a, b, cin, sum, cout);

        a=1; b=0; cin=1;
        #10;
        if (sum==0 && cout==1)
            $display("PASS: a=%b b=%b cin=%b", a, b, cin);
        else
            $display("FAIL: a=%b b=%b cin=%b -> got sum=%b cout=%b", a, b, cin, sum, cout);

        a=1; b=1; cin=1;
        #10;
        if (sum==1 && cout==1)
            $display("PASS: a=%b b=%b cin=%b", a, b, cin);
        else
            $display("FAIL: a=%b b=%b cin=%b -> got sum=%b cout=%b", a, b, cin, sum, cout);
    end
endmodule
