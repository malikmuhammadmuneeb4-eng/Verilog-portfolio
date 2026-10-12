# Synchronous FIFO (4x8)

A 4-slot, 8-bit synchronous FIFO, identified as a gap in the interview-prep roadmap (a classic
DSD whiteboard topic that hadn't been covered) and built from scratch. Includes the design plus
two testbench iterations: a manual version with repeated check blocks, then a task-based refactor
of the same checks.

- **DUT:** `FIFO` (`din[7:0]` in, `dout[7:0]` out, `wr_en`/`rd_en`/`rst` control, `full`/`empty`
  status) — pointer-based (`write_ptr`/`read_ptr`) with a separate item-counter to resolve the
  full/empty pointer-equality ambiguity.
- **Testbenches:**
  - `testbench_manual.sv` — 11 manually written sequential checks (reset, 4 writes,
    overflow-protection, 4 ordered reads, underflow-protection)
  - `testbench_task.sv` — the same 11 checks refactored into a single reusable `check_FIFO` task

See [design.md](./design.md) for the full story — the empty/full pointer-ambiguity problem and
the counter-based solution, async FIFO + Gray-code reasoning (discussed, not implemented here),
and every real bug caught while building and refactoring (expected-value tracking bugs, a
`wr_en`/`rd_en` priority-chain bug, a missing task call, literal-syntax mistakes).

## Verification
Compiled and run locally with Icarus Verilog, without AI assistance for the compile/run step.
Both testbenches: 11/11 PASS.

## Files
- `fifo.sv`
- `testbench_manual.sv`
- `testbench_task.sv`
