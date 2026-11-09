module fifo(
  input logic clk, reset,
  input logic write_en, read_en,
  input logic [31:0] data_in,
  output logic [31:0] data_out,
  output logic full , empty 
);
  reg [3:0] counter;
  logic [31:0] mem [3:0];
  reg [1:0] read_ptr,write_ptr;
  always_ff @(posedge clk) begin
    if (reset) begin mem <= '0; read_ptr<=2'd0; write_ptr<=2'd0; counter<=4'b0; data_out<=32'b0; end
    else if (read_en && empty==0 && write_en && full==0) begin
      mem[write_ptr]<=data_in;
      data_out <= mem[read_ptr];
      read_ptr<=read_ptr+1;
      write_ptr<=write_ptr+1;
      counter<=counter;
    end
    else if(write_en && full==0) begin mem[write_ptr]<=data_in; write_ptr<=write_ptr+1; counter<=counter+1; end
    else if (read_en && empty==0) begin data_out <= mem[read_ptr]; read_ptr<=read_ptr+1; counter<=counter-1; end
  end
  always_comb begin
    if (counter==4'd4) begin  full=1; empty=0; end
    else if (counter==4'd0)begin  full=0; empty=1; end
    else  begin full=0; empty=0; end
  end
endmodule
