// First testbench attempt. NOTE: an earlier version of this file mistakenly split these
// 4 test cases into 4 SEPARATE initial blocks, which all start running in PARALLEL at time 0
// (a race condition), not one after another. Fixed by combining all test cases into a single
// initial block, so the #10 delays correctly sequence them.
module testbench;
    reg a, b, cin;
    wire sum, cout;

    fulladder DUT (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

    initial begin
        a=0; b=0; cin=0;
        #10;
        $display("a=%b b=%b cin=%b -> sum=%b cout=%b", a, b, cin, sum, cout);

        a=0; b=1; cin=0;
        #10;
        $display("a=%b b=%b cin=%b -> sum=%b cout=%b", a, b, cin, sum, cout);

        a=1; b=0; cin=1;
        #10;
        $display("a=%b b=%b cin=%b -> sum=%b cout=%b", a, b, cin, sum, cout);

        a=1; b=1; cin=1;
        #10;
        $display("a=%b b=%b cin=%b -> sum=%b cout=%b", a, b, cin, sum, cout);
    end
endmodule
