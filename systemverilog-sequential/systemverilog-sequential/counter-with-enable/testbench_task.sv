module tb;
reg clk,reset,enable;
wire [3:0]count;

four_bit_counter F0(.clk(clk),.reset(reset),.enable(enable),.count(count));
initial clk=0;
always #5 clk=~clk;

task check_counter(input logic enable_i, input logic[3:0] exp_count); begin
    enable=enable_i;
    @(posedge clk);
    #1;
    if (count==exp_count)
    $display("Pass: reset=%b enable=%b count=%b",reset, enable, count);
    else
    $display("Fail: reset=%b enable=%b count=%b expected count=%b ",reset, enable, count, exp_count);
end
endtask

initial begin
    reset=1;
    check_counter(1'b0,4'b0000);

    reset=0;
    enable=1;
    check_counter(1'b1,4'b0001);

    reset=0;
    enable=1;
    check_counter(1'b1,4'b0010);

    reset=0;
    enable=1;
    check_counter(1'b1,4'b0011);

    reset=0;
    enable=1;
    check_counter(1'b1,4'b0100);

    reset=0;
    enable=1;
    check_counter(1'b1,4'b0101);

    reset=0;
    enable=1;
    check_counter(1'b1,4'b0110);

    reset=0;
    enable=1;
    check_counter(1'b1,4'b0111);

    reset=0;
    enable=1;
    check_counter(1'b1,4'b1000);

    reset=0;
    enable=1;
    check_counter(1'b1,4'b1001);

    reset=0;
    enable=1;
    check_counter(1'b1,4'b1010);

    reset=0;
    enable=1;
    check_counter(1'b1,4'b1011);

    reset=0;
    enable=1;
    check_counter(1'b1,4'b1100);

    reset=0;
    enable=1;
    check_counter(1'b1,4'b1101);

    reset=0;
    enable=1;
    check_counter(1'b1,4'b1110);

    reset=0;
    enable=1;
    check_counter(1'b1,4'b1111);

    reset=0;
    enable=1;
    check_counter(1'b1,4'b0000);

    reset=0;
    enable=1;
    check_counter(1'b1,4'b0001);

    reset=1;
    enable=0;
    check_counter(1'b0,4'b0000);

    $finish;
end
endmodule
