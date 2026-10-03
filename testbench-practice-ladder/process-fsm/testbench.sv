module tb;
reg clk,reset,start,stop;
proc_state_t state;
proc_state_t expected_state;

simple_process_fsm SPF0(.clk(clk), .reset(reset), .start(start), .stop(stop), .state(state));

initial clk=0;
always #5 clk=~clk;

initial begin
reset=1;
expected_state=IDLE;
  @(posedge clk);
#1;
  if (state==expected_state)
    $display("reset sucessful state=%b",state);
else
  $display("reset failed state=%b ->expected state=%b",state,expected_state);

if (state==IDLE) begin
    reset=0; start=1; stop=0;
    expected_state=RUNNING;
    @(posedge clk);
    #1;
    if (state==expected_state)
    $display ("PASS: start=%b -> state=%b ",start,state);
    else
    $display ("FAIL: start=%b -> state=%b expected state=%b",start,state,expected_state);
end
else if (state==RUNNING) begin
    $display("ERROR: already in RUNNING...");
end
else begin
    $display("ERROR: unexpected state=%b", state);
end

if (state==RUNNING) begin
    reset=0; start=0; stop=1;
    expected_state=DONE;
    @(posedge clk);
    #1;
    if (state==expected_state)
    $display ("PASS: stop=%b -> state=%b ",stop,state);
    else
    $display ("FAIL: stop=%b -> state=%b expected state=%b",stop,state,expected_state);
end
else if (state==DONE) begin
    $display("ERROR: State is in DONE state stop will have no effect...");
end
else begin
    $display("ERROR: unexpected state=%b", state);
end

if(state==DONE) begin
    reset=0; start=0; stop=0;
    expected_state=IDLE;
    @(posedge clk);
    #1;
    if (state==expected_state)
    $display ("PASS: STATE Toogle AS state was in DONE -> state=%b ",state);
    else
      $display ("FAIL: STATE Toogle AS state was in DONE start=%b stop=%b -> state=%b expected state=%b",start,stop,state,expected_state);
end
else
  $display("Current state=%b",state);

 $finish;
end
endmodule
