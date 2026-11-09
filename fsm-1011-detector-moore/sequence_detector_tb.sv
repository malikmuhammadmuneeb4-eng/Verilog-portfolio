module tb;
reg clk,reset,x;
wire y;
sequence_detector SQ0(.clk(clk), .reset(reset), .x(x), .y(y));

initial clk=0;
always #5 clk=~clk;

task seq( input logic x_i,input state_t exp_state, input logic exp_y);
  x=x_i;
  @(posedge clk);
  #1;
  if (exp_y==y && exp_state==SQ0.state)
    $display( "PASS: state=%s output=%d", SQ0.state.name(),y);
  else
    $display( "FAIL state=%s output=%d expected state=%s output=%d", SQ0.state.name(),y,exp_state.name(),exp_y);
endtask

initial begin
reset=1;
  seq(0,s0,0);
reset=0;
  seq(0,s0,0);
  seq(1,s1,0);
  seq(0,s2,0);
  seq(1,s3,0);
  seq(1,s4,1);
  seq(0,s2,0);
  seq(1,s3,0);
  seq(1,s4,1);
$finish;
end
endmodule
