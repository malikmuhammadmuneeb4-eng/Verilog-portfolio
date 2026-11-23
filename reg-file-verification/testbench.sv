// Self-checking, constrained-random testbench for reg_file:
// randomized transaction class -> reference (golden) model -> scoreboard
// -> functional coverage, all built from scratch.
module tb;

class packet;
  rand bit [7:0] din;
  rand bit [2:0] addr;
  rand logic     wr;
  rand logic     rd;

  // Bias toward the rarer write/read/error combinations instead of a flat
  // 25% each, so the error case (wr=1,rd=1) gets extra stress-testing.
  constraint c_op {
    {wr,rd} dist { 2'b11:=30, 2'b10:=20, 2'b01:=20, 2'b00:=30 };
  }

  function void display();
    $display("wr=%0d, rd=%0d, addr=%0d, din=%0d", wr, rd, addr, din);
  endfunction

  // Functional coverage: every (address, operation-type) combination.
  covergroup cg;
    cp_addr: coverpoint addr;
    cp_op:   coverpoint {wr,rd};
    cross cp_addr, cp_op;
  endgroup

  function new();
    cg = new();
  endfunction
endclass

reg clk;
reg resetn;
wire error;
wire [7:0] dout;

reg [7:0] din_s;
reg [2:0] addr_s;
reg wr_s, rd_s;

packet p1;

reg_file RF0 (
  .din(din_s), .addr(addr_s), .wr(wr_s), .rd(rd_s),
  .clk(clk), .resetn(resetn), .dout(dout), .error(error)
);

// Reference (golden) model: a behavioral shadow copy of the register array,
// kept in sync with the DUT so expected dout/error can be predicted for
// every randomized transaction before the DUT ever produces a result.
logic [7:0] ref_mem [0:7];
logic [7:0] exp_dout;
logic       exp_error;

task update_ref();
  if (p1.wr==1 && p1.rd==1) exp_error = 1;
  else if (p1.wr==1) begin ref_mem[p1.addr] = p1.din; exp_error = 0; end
  else if (p1.rd==1) begin exp_dout = ref_mem[p1.addr]; exp_error = 0; end
  else begin ref_mem[p1.addr] = ref_mem[p1.addr]; exp_error = 0; end
endtask

// Scoreboard: compares the DUT's actual dout/error against the reference
// model's prediction every cycle.
task check_result();
  if (p1.rd && !p1.wr) begin
    if (dout !== exp_dout)
      $display("FAIL addr=%0d: expected dout=%0d, got dout=%0d", p1.addr, exp_dout, dout);
  end
  if (error !== exp_error)
    $display("FAIL: expected error=%0d, got error=%0d", exp_error, error);
endtask

initial clk = 0;
always #5 clk = ~clk;

initial begin
  p1 = new();
  resetn    = 0;
  ref_mem   = '{default:0};
  exp_dout  = 0;
  exp_error = 0;
  @(posedge clk);
  resetn = 1;

  for (int i=0; i<255; i=i+1) begin
    p1.randomize();
    p1.cg.sample();

    din_s  = p1.din;
    addr_s = p1.addr;
    wr_s   = p1.wr;
    rd_s   = p1.rd;

    update_ref();
    @(posedge clk);
    #1;
    check_result();
    p1.display();
    $display("dout=%0d error=%0d", dout, error);
  end

  $display("All 255 transactions checked.");
  $display("Coverage = %0.2f%%", p1.cg.get_coverage());
  $finish;
end
endmodule
