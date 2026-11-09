module tb;
reg clk, reset;
wire [2:0] light;
reg [2:0] expected_light;
state_t expected_state;
reg [2:0] expected_counter;

traffic_light TF0( .clk(clk), .reset(reset), .light(light));

initial clk=0;
always #5 clk=~clk;

initial begin
reset=1;
expected_light=3'b100;
expected_counter=3'b000;
expected_state=RED;
@(posedge clk);
#1;
if (expected_light==light && expected_state==TF0.state && expected_counter==TF0.counter)
    $display( "PASS: reset successful light=%d, state=%s, counter=%d", light, TF0.state.name(),TF0.counter);
else
  $display( "FAIL: light=%d, state=%s counter=%d expected light=%d, state=%s counter=%d", light, TF0.state.name(),TF0.counter,expected_light, expected_state.name(),expected_counter);

reset=0;
expected_light=3'd2;
expected_counter=3'd0;
expected_state=GREEN;
repeat(4)begin
  @(posedge clk);
  #1;
end
if (expected_light==light && expected_state==TF0.state && expected_counter==TF0.counter)
  $display( "PASS: light=%d, state=%s, counter=%d", light, TF0.state.name(),TF0.counter);
else
  $display( "FAIL: light=%d, state=%s counter=%d expected light=%d, state=%s counter=%d", light, TF0.state.name(),TF0.counter,expected_light, expected_state.name(),expected_counter);

expected_light=3'd1;
expected_counter=3'd0;
expected_state=YELLOW;
repeat(3)begin
  @(posedge clk);
  #1;
end
if (expected_light==light && expected_state==TF0.state && expected_counter==TF0.counter)
  $display( "PASS: light=%d, state=%s, counter=%d", light, TF0.state.name(),TF0.counter);
else
  $display( "FAIL: light=%d, state=%s counter=%d expected light=%d, state=%s counter=%d", light, TF0.state.name(),TF0.counter,expected_light, expected_state.name(),expected_counter);

expected_light=3'd4;
expected_counter=3'd0;
expected_state=RED;
repeat(2)begin
  @(posedge clk);
  #1;
end
if (expected_light==light && expected_state==TF0.state && expected_counter==TF0.counter)
  $display( "PASS: light=%d, state=%s, counter=%d", light, TF0.state.name(),TF0.counter);
else
  $display( "FAIL: light=%d, state=%s counter=%d expected light=%d, state=%s counter=%d", light, TF0.state.name(),TF0.counter,expected_light, expected_state.name(),expected_counter);

expected_light=3'd2;
expected_counter=3'd0;
expected_state=GREEN;
repeat(4)begin
  @(posedge clk);
  #1;
end
if (expected_light==light && expected_state==TF0.state && expected_counter==TF0.counter)
  $display( "PASS: light=%d, state=%s, counter=%d", light, TF0.state.name(),TF0.counter);
else
  $display( "FAIL: light=%d, state=%s counter=%d expected light=%d, state=%s counter=%d", light, TF0.state.name(),TF0.counter,expected_light, expected_state.name(),expected_counter);

$finish;
end
endmodule
