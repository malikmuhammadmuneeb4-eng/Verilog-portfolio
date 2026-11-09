# Synchronous FIFO (4x32, SystemVerilog)

A 4-slot, 32-bit synchronous FIFO, rebuilt in SystemVerilog as a cold-recall revision exercise
(the original design, in plain Verilog, is preserved in git history). Counter-based full/empty
detection, natural pointer wraparound (no explicit modulo logic), and support for a genuine
simultaneous read+write in the same clock cycle.

- **DUT:** `fifo` (`data_in[31:0]` in, `data_out[31:0]` out, `write_en`/`read_en`/`reset`
  control, `full`/`empty` status) — pointer-based (`write_ptr`/`read_ptr`, 2 bits, one per
  memory slot) with a separate item-`counter` to resolve the full/empty pointer-equality
  ambiguity.
- **Testbench:** `fifo_tb.sv` — a single reusable `fcheck` task, 11 checks: reset, 4 writes,
  overflow-protection (4th write hits `full`), 4 ordered reads, underflow-protection, then a
  genuine simultaneous read+write on a partially-filled FIFO.

See [design.md](./design.md) for the full story — why a separate counter sidesteps the need for
extra-width "lap" pointers, how pointer wraparound falls out of fixed-width binary arithmetic for
free, the simultaneous-read+write priority ordering, and every real bug caught along the way.

## Verification
Compiled and run with Icarus Verilog. 11/11 PASS.
(Icarus doesn't support whole-array assignment yet — `mem <= '0;` is standard SystemVerilog and
works in Vivado/Questa/VCS; for local Icarus runs it needs a `for`-loop reset instead, same as the
`memory-and-register-file` module.)

## Files
- `fifo.sv` — design
- `fifo_tb.sv` — testbench
