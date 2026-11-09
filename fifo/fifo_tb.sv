module tb;
reg clk,reset,write_en, read_en;
reg [31:0] data_in;
wire [31:0] data_out;
wire full, empty;

fifo F0( .clk(clk), .reset(reset), .write_en(write_en), .read_en(read_en), .data_in(data_in), .data_out(data_out), .full(full), .empty(empty));

initial clk=0;
always #5 clk=~clk;

task fcheck( input logic [31:0] data_in_i,input logic write_en_i, input logic read_en_i, input logic [31:0] exp_data_out, input logic exp_full , input logic exp_empty);
  data_in= data_in_i;
  write_en= write_en_i;
  read_en= read_en_i;
  @(posedge clk);
  #1;
  if (exp_data_out==data_out && exp_full == full && exp_empty==empty)
    $display("PASS: data_in=%0d, write_en=%d ,read_en=%d, data_out=%0d , full=%d , empty=%d", data_in, write_en, read_en, data_out, full, empty);
  else
    $display("FAIL: data_in=%0d, write_en=%d ,read_en=%d, data_out=%0d , full=%d , empty=%d expected data_out=%0d , full=%d , empty=%d" , data_in, write_en, read_en, data_out, full, empty, exp_data_out, exp_full, exp_empty);
endtask

initial begin
  reset=1;
  fcheck(32'b0, 0, 0,32'b0,0,1);
  reset=0;
  fcheck(32'd12, 1, 0,32'b0,0,0);
  fcheck(32'd13, 1, 0,32'b0,0,0);
  fcheck(32'd14, 1, 0,32'b0,0,0);
  fcheck(32'd15, 1, 0,32'b0,1,0);
  fcheck(32'b0, 0, 1,32'd12,0,0);
  fcheck(32'b0, 0, 1,32'd13,0,0);
  fcheck(32'b0, 0, 1,32'd14,0,0);
  fcheck(32'b0, 0, 1,32'd15,0,1);
  fcheck(32'd12, 1, 0,32'd15,0,0);
  fcheck(32'd18, 1, 1,32'd12,0,0);
  $finish;
end
endmodule
