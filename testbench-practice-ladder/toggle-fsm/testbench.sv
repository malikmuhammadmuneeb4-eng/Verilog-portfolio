module tb;
reg clk,reset;
state_t state;
state_t expected_state;

toggle_fsm TF0(.clk(clk),.reset(reset),.state(state));

initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, tb);
end

initial clk=0;
always #5 clk=~clk;

initial begin
    reset=1;
    expected_state=STATE_A;
    @(posedge clk);
    #1;
    if (state==expected_state)
    $display("reset successful:state=%b", state);
    else
    $display("reset Failed:state=%b expected state=%b", state,expected_state);

    reset=0;
    expected_state=STATE_B;
    @(posedge clk);
    #1;
    if (state==expected_state)
    $display("PASS: state=%b",state);
    else
    $display("FAIL: state=%b -> expected state=%b", state,expected_state);

    reset=0;
    expected_state=STATE_A;
    @(posedge clk);
    #1;
    if (state==expected_state)
    $display("PASS: state=%b",state);
    else
    $display("FAIL: state=%b -> expected state=%b", state,expected_state);

    reset=0;
    expected_state=STATE_B;
    @(posedge clk);
    #1;
    if (state==expected_state)
    $display("PASS: state=%b",state);
    else
    $display("FAIL: state=%b -> expected state=%b", state,expected_state);

    reset=1;
    expected_state=STATE_A;
    @(posedge clk);
    #1;
    if (state==expected_state)
    $display("reset successful:state=%b", state);
    else
    $display("reset Failed:state=%b expected state=%b", state,expected_state);

    $finish;
end
endmodule
