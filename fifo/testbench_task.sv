module tb;
reg clk, rst ,wr_en ,rd_en;
reg [7:0]din;
wire [7:0]dout;
wire full,empty;

FIFO F0(.clk(clk),.rst(rst),.wr_en(wr_en),.rd_en(rd_en),.din(din),.dout(dout),.full(full),.empty(empty));

initial clk=0;
always #5 clk=~clk;

task check_FIFO(input logic wr_en_i, input logic rd_en_i, input logic [7:0]din_i , input logic exp_empty, input logic exp_full, input logic [7:0] exp_dout);
begin
wr_en = wr_en_i;
rd_en = rd_en_i;
din=din_i;
@(posedge clk);
#1;
if (exp_empty==empty && exp_full==full && exp_dout==dout) $display("PASS: empty=%b,full=%b,dout=%b", empty,full,dout); else $display("FAIL: empty=%b,full=%b,dout=%b expected empty=%b,full=%b,dout=%b", empty,full,dout,exp_empty,exp_full,exp_dout); end endtask

initial begin
rst=1;
check_FIFO(1'b0,1'b0,8'b0,1'b1,1'b0,8'b0);
rst=0;
rd_en=0;
wr_en=1;
check_FIFO(1'b1,1'b0,8'HAA,1'b0,1'b0,8'b0);
rst=0;
rd_en=0;
wr_en=1;
check_FIFO(1'b1,1'b0,8'HBB,1'b0,1'b0,8'b0);
rst=0;
rd_en=0;
wr_en=1;
check_FIFO(1'b1,1'b0,8'HCC,1'b0,1'b0,8'b0);
rst=0;
rd_en=0;
wr_en=1;
check_FIFO(1'b1,1'b0,8'HDD,1'b0,1'b1,8'b0);
rst=0;
rd_en=0;
wr_en=1;
check_FIFO(1'b1,1'b0,8'HAA,1'b0,1'b1,8'b0);
rst=0;
rd_en=1;
wr_en=0;
check_FIFO(1'b0,1'b1,8'd0,1'b0,1'b0,8'HAA);
rst=0;
rd_en=1;
wr_en=0;
check_FIFO(1'b0,1'b1,8'd0,1'b0,1'b0,8'HBB);
rst=0;
rd_en=1;
wr_en=0;
check_FIFO(1'b0,1'b1,8'd0,1'b0,1'b0,8'HCC);
rst=0;
rd_en=1;
wr_en=0;
check_FIFO(1'b0,1'b1,8'd0,1'b1,1'b0,8'HDD);
rst=0;
rd_en=1;
wr_en=0;
check_FIFO(1'b0,1'b1,8'd0,1'b1,1'b0,8'HDD);
rst=0;
rd_en=0;
wr_en=1;
check_FIFO(1'b1,1'b0,8'HAA,1'b0,1'b0,8'HDD);

$finish;
end
endmodule
