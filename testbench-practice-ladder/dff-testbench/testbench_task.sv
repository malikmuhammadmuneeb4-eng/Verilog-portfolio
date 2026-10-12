module tb;
reg clk,reset,d;
wire q;
dff_simple DF0(.clk(clk),.reset(reset),.d(d),.q(q));
initial clk=0;
always #5 clk=~clk;

task check_ff(input logic d_i, input logic exp_q); begin
    d=d_i;
    @(posedge clk);
    #1;
    if (q==exp_q)
    $display("PASS: q=%b d=%b",q, d);
    else
    $display("FAIL: q=%b d=%b expected q=%b d=%b",q, d,exp_q,d);
end
endtask

initial begin
    reset=1;
    check_ff(1'b0,1'b0);

    reset=1;
    check_ff(1'b1,1'b0);

    reset=0;
    check_ff(1'b1,1'b1);

    reset=0;
    check_ff(1'b0,1'b0);

    $finish;
end
endmodule
