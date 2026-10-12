# Synchronous FIFO — Design Notes

## Purpose
A 4-slot, 8-bit synchronous FIFO, identified as a gap in the interview-prep roadmap and added
after noticing it's a classic DSD whiteboard topic. Built from first principles: a pointer-based
memory buffer, not a shift register — data isn't physically moved, only the read/write pointers
move.

## Key design decisions
- **Full/empty ambiguity**: raw `write_ptr==read_ptr` is ambiguous between full and empty (a
  4-slot FIFO written A,B,C,D with no reads wraps `write_ptr` back to 0, matching `read_ptr`, yet
  the FIFO is actually full, not empty). Solved with a separate item counter: increments on
  write, decrements on read, `full` when `count==depth`, `empty` when `count==0`.
- **Overflow/underflow protection**: write only proceeds when `!full`, read only when `!empty` —
  initially missing, caught independently while reasoning through the design (writing while full,
  or reading while empty, would otherwise silently corrupt `count` past its valid range).
- **`dout` reset**: `dout` is only driven in the read branch, so it was never reset in the `rst`
  branch — a real design gap (not just a testbench omission), surfaced by reasoning about
  simulation's 4-state logic (an unreset register holds `X`, not `0`). Fixed by resetting
  `dout<=8'd0` alongside the pointers/counter.

## Real bugs caught while building the design
- Array indexing with `()` instead of `[]`.
- Blocking (`=`) vs non-blocking (`<=`) assignment misuse inside `always_ff`.
- Missing `read_ptr` increment (symmetric to an earlier missing `write_ptr` increment).
- `if else` instead of `else if`; a block starting with `else if` with no preceding `if`.
- Signal name mismatch (`reset` vs the actual port `rst`).
- Concatenation width mismatch resetting two 2-bit pointers with a single `2'b00`.
- Wrong full-threshold constant (`3'b111`=7 instead of `3'b100`=4) — `count` needs 3 bits
  specifically because 2 bits maxes out at 3, one short of the needed value 4.
- `=` vs `==` in an `if` condition.

## Real bugs caught while building and debugging the manual testbench
- Instantiation missing a closing paren; clock-gen typo (`always clk#5...` instead of
  `always #5...`); `expected_*` variables used before declaration; `=` vs `==` recurring in a
  testbench condition; stray `&` typos in `$display` strings; a missing semicolon; a stray
  incomplete `$display` line.
- `dout` during a pure write: initially assumed it should be checked against a hardcoded value;
  corrected — it only updates in the `rd_en` branch, so it holds its *previous* value during a
  write.
- Simulation 4-state logic (0/1/X/Z): an unreset/undriven register defaults to `X` in simulation,
  not `0` — this reasoning is what surfaced the `dout` reset gap above.
- **Expected-value tracking bugs that looked like DUT bugs** — found via real simulation runs:
  - `expected_full` left at `0` (copy-pasted from earlier blocks) for the 4th write, which
    legitimately fills the FIFO — should have been `1`.
  - `wr_en` never explicitly set back to `0` before the read-test blocks, so it stayed at its last
    written value; since the DUT's `always_ff` is an if-else-if priority chain
    (reset > write > read), once a read dropped `count` below the full threshold, the stale
    `wr_en=1` caused a spurious write instead of the intended read on the next cycle.
  - `expected_dout` hardcoded to `0` for the underflow-protection test — but a blocked read
    (FIFO empty) never updates `dout`, so it should hold the last successfully-read value, not
    `0`.
  - `$display` format strings labeled `din=%b` while passing the `dout` value as the argument, in
    every READ block — a cosmetic/label bug, not functional, but confusing to debug against.

## Refactor: manual -> task-based testbench
Same 11 checks, rewritten as calls to one
`check_FIFO(wr_en, rd_en, din, exp_empty, exp_full, exp_dout)` task. Bugs caught specifically
during the refactor:
- Task parameters named identically to the testbench's top-level `reg`s (`wr_en`, `rd_en`, `din`)
  shadowed them inside the task — the task never actually drove the DUT's inputs until the
  parameters were renamed (`wr_en_i`, etc.) and explicitly assigned to the outer regs inside the
  task body.
- Calling a task with its own formal parameter names instead of actual literal values.
- SystemVerilog literal syntax: `<width>'<base><value>` (e.g. `1'b1`, `8'd0`) — `'d` requires
  decimal digits only, caught passing hex digits like `AA`/`DD` after `'d` (should be `'h`).
- An entire write call (the first write, `din=8'hAA`) was dropped while assembling the final
  file, silently shifting every later check's actual-vs-expected comparison by one call — found
  by comparing the assembled file's call order against the originally-confirmed sequence.

## Verification
Compiled and run locally with Icarus Verilog (no AI assistance for the compile/run step).
`testbench_manual.sv`: 11/11 PASS. `testbench_task.sv`: 11/11 PASS (same coverage, refactored).

## Not yet implemented
Async (dual-clock-domain) version with Gray-code pointer synchronization — discussed
conceptually (2-flop synchronizers + Gray-code encoding so a multi-bit pointer only ever changes
1 bit between consecutive values during cross-domain sampling) but not built.
