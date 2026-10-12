module FIFO(
    input logic clk, rst ,wr_en ,rd_en,
    input logic [7:0]din,
    output logic [7:0]dout,
    output logic full, empty
);
logic [7:0] mem [3:0];
logic [1:0]write_ptr ,read_ptr;
logic [3:0] count;
always_ff @(posedge clk) begin
if (rst) begin write_ptr<= 2'b00; read_ptr <= 2'b00; count<=3'b000; dout<=8'd0; end
else if (wr_en==1 && !full) begin mem[write_ptr]<= din; write_ptr<=write_ptr+1; count<=count+1; end
else if (rd_en==1 && !empty) begin dout<=mem[read_ptr]; read_ptr<=read_ptr+1 ;count<=count-1; end
end
always_comb begin
if (count==3'b000) empty=1'b1;
else if (count==3'b100) full=1'b1;
else begin empty=1'b0; full=1'b0; end
end
endmodule
