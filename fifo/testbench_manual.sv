module tb;
reg clk, rst ,wr_en ,rd_en;
reg [7:0]din;
wire [7:0]dout;
wire full,empty;
reg expected_full,expected_empty;
reg [7:0]expected_dout;

FIFO F0(.clk(clk),.rst(rst),.wr_en(wr_en),.rd_en(rd_en),.din(din),.dout(dout),.full(full),.empty(empty));

initial clk=0;
always #5 clk=~clk;

initial begin
    rst=1;
    expected_empty=1'b1;
    expected_full=1'b0;
    expected_dout= 8'd0;
    @(posedge clk);
    #1;
    if (expected_empty==empty && expected_full==full && expected_dout==dout)
    $display("FIFO reset successful :) empty=%b,full=%b,dout=%b",empty,full,dout);
    else
    $display("FIFO reset failed :( empty=%b,full=%b,dout=%b expected empty=%b,full=%b,dout=%b ",empty,full,dout,expected_empty,expected_full,expected_dout);


    rst=0;
    wr_en=1;
    din=8'hAA;
    expected_empty=1'b0;
    expected_full=1'b0;
    @(posedge clk);
    #1;
    if (expected_empty==empty && expected_full==full)
    $display("write successfull empty=%b,full=%b,din=%b",empty,full,din);
    else
    $display("write Fail empty=%b,full=%b,din=%b expected empty=%b,full=%b ",empty,full,din,expected_empty,expected_full);

    rst=0;
    wr_en=1;
    din=8'hBB;
    expected_empty=1'b0;
    expected_full=1'b0;
    @(posedge clk);
    #1;
    if (expected_empty==empty && expected_full==full)
    $display("write successfull empty=%b,full=%b,din=%b",empty,full,din);
    else
    $display("write Fail empty=%b,full=%b,din=%b expected empty=%b,full=%b ",empty,full,din,expected_empty,expected_full);

    rst=0;
    wr_en=1;
    din=8'hCC;
    expected_empty=1'b0;
    expected_full=1'b0;
    @(posedge clk);
    #1;
    if (expected_empty==empty && expected_full==full)
    $display("write successfull empty=%b,full=%b,din=%b",empty,full,din);
    else
    $display("write Fail empty=%b,full=%b,din=%b expected empty=%b,full=%b ",empty,full,din,expected_empty,expected_full);

    rst=0;
    wr_en=1;
    din=8'hDD;
    expected_empty=1'b0;
    expected_full=1'b1;
    @(posedge clk);
    #1;
    if (expected_empty==empty && expected_full==full)
    $display("write successfull empty=%b,full=%b,din=%b",empty,full,din);
    else
    $display("write Fail empty=%b,full=%b,din=%b expected empty=%b,full=%b ",empty,full,din,expected_empty,expected_full);

    rst=0;
    wr_en=1;
    din=8'hAA;
    expected_empty=1'b0;
    expected_full=1'b1;
    @(posedge clk);
    #1;
    if (expected_empty==empty && expected_full==full)
    $display("PASS: write FAIL FIFO IS FULL empty=%b,full=%b,din=%b",empty,full,din);
    else
    $display("FAIL: write succesful error :((( empty=%b,full=%b,din=%b expected empty=%b,full=%b ",empty,full,din,expected_empty,expected_full);


    rst=0;
    rd_en=1;
    wr_en=0;
    expected_dout=8'HAA;
    expected_empty=1'b0;
    expected_full=1'b0;
    @(posedge clk);
    #1;
    if (expected_empty==empty && expected_full==full && expected_dout==dout)
    $display("READ successfull empty=%b,full=%b,dout=%b",empty,full,dout);
    else
    $display("READ Fail empty=%b,full=%b,dout=%b expected empty=%b,full=%b ",empty,full,dout,expected_empty,expected_full);

    rst=0;
    rd_en=1;
    wr_en=0;
    expected_dout=8'HBB;
    expected_empty=1'b0;
    expected_full=1'b0;
    @(posedge clk);
    #1;
    if (expected_empty==empty && expected_full==full && expected_dout==dout)
    $display("READ successfull empty=%b,full=%b,dout=%b",empty,full,dout);
    else
    $display("READ Fail empty=%b,full=%b,dout=%b expected empty=%b,full=%b ",empty,full,dout,expected_empty,expected_full);

    rst=0;
    wr_en=1;
    rd_en=0;
    din=8'hAA;
    expected_empty=1'b0;
    expected_full=1'b0;
    @(posedge clk);
    #1;
    if (expected_empty==empty && expected_full==full)
    $display("write successfull empty=%b,full=%b,din=%b dout=%b",empty,full,din,dout);
    else
    $display("write Fail empty=%b,full=%b,din=%b expected empty=%b,full=%b ",empty,full,din,expected_empty,expected_full);

    rst=0;
    rd_en=1;
    wr_en=0;
    expected_dout=8'HCC;
    expected_empty=1'b0;
    expected_full=1'b0;
    @(posedge clk);
    #1;
    if (expected_empty==empty && expected_full==full && expected_dout==dout)
    $display("READ successfull empty=%b,full=%b,dout=%b",empty,full,dout);
    else
    $display("READ Fail empty=%b,full=%b,dout=%b expected empty=%b,full=%b ",empty,full,dout,expected_empty,expected_full);

    rst=0;
    rd_en=1;
    wr_en=0;
    expected_dout=8'HDD;
    expected_empty=1'b0;
    expected_full=1'b0;
    @(posedge clk);
    #1;
    if (expected_empty==empty && expected_full==full && expected_dout==dout)
    $display("READ successfull empty=%b,full=%b,dout=%b",empty,full,dout);
    else
    $display("READ Fail empty=%b,full=%b,dout=%b expected empty=%b,full=%b ",empty,full,dout,expected_empty,expected_full);

    rst=0;
    rd_en=1;
    wr_en=0;
    expected_dout=8'HAA;
    expected_empty=1'b1;
    expected_full=1'b0;
    @(posedge clk);
    #1;
    if (expected_empty==empty && expected_full==full && expected_dout==dout)
    $display("READ successfull empty=%b,full=%b,dout=%b",empty,full,dout);
    else
    $display("READ Fail empty=%b,full=%b,dout=%b expected empty=%b,full=%b ",empty,full,dout,expected_empty,expected_full);

    rst=0;
    rd_en=1;
    wr_en=0;
    expected_dout=8'HAA;
    expected_empty=1'b1;
    expected_full=1'b0;
    @(posedge clk);
    #1;
    if (expected_empty==empty && expected_full==full && expected_dout==dout)
    $display("PASS: READ fail FIFO is empty=%b,full=%b,dout=%b",empty,full,dout);
    else
    $display("FAIL: READ PASS empty=%b,full=%b,dout=%b expected empty=%b,full=%b ",empty,full,dout,expected_empty,expected_full);


$finish;
end
endmodule
