module tb;
reg clk,reset,d;
wire q;
reg expected_q;

dff_simple DS0(.clk(clk),.reset(reset),.d(d),.q(q));

initial clk=0;
always #5 clk=~clk;

initial begin
    reset=1; d=0;
    @(posedge clk);
    #1;
    expected_q=1'b0;
    if (q==expected_q)
    $display("reset worked -> q=%b", q);
    else
    $display("reset failed -> q=%b -> expected_q", q,expected_q);

    reset=0; d=1;
    @(posedge clk);
    #1;
    expected_q=d;
    if (q==expected_q)
    $display("PASS -> q=%b", q);
    else
    $display("FAIL -> q=%b -> expected_q", q,expected_q);

    reset=0; d=0;
    @(posedge clk);
    #1;
    expected_q=d;
    if (q==expected_q)
    $display("PASS -> q=%b", q);
    else
    $display("FAIL -> q=%b -> expected_q", q,expected_q);

    reset=1; d=1;
    @(posedge clk);
    #1;
    expected_q=1'b0;
    if (q==expected_q)
    $display("reset worked -> q=%b", q);
    else
    $display("reset failed -> q=%b -> expected_q", q,expected_q);

    reset=0; d=0;
    @(posedge clk);
    #1;
    expected_q=d;
    if (q==expected_q)
    $display("PASS -> q=%b", q);
    else
    $display("FAIL -> q=%b -> expected_q", q,expected_q);

    $finish;
end
endmodule
