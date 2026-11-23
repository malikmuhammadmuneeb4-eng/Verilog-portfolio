// Register file with a single write/read port and an explicit error flag
// for an illegal simultaneous write+read request on the same cycle.
module reg_file (
    input  logic [7:0] din,
    input  logic [2:0] addr,
    input  logic       wr,
    input  logic       rd,
    input  logic       clk,
    input  logic       resetn,
    output logic [7:0] dout,
    output logic       error
);
logic [7:0] regs [7:0];
always_ff @(posedge clk) begin
  if (resetn==0) begin error<=0; dout<=8'b0; regs<='{default:'0}; end
  else if (wr==1 && rd==1) begin error<=1; regs[addr]<=regs[addr]; end
  else if (wr==1) begin regs[addr]<=din; error<=0; end
  else if (rd==1) begin dout<=regs[addr]; error<=0; end
  else begin regs[addr]<=regs[addr]; error<=0; end
end
endmodule
