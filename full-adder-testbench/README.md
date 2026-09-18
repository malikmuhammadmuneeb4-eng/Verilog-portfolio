# Full Adder Testbench — First Steps into Verification

First hands-on testbenches written, covering the progression from basic manual test cases to a
self-checking, loop-based exhaustive test — the same core pattern used for verifying every design
in this repo going forward, now written and run independently (installed Icarus Verilog and
VS Code locally to compile and simulate outside of any online tool).

## Files (in learning order)

1. **`testbench_basic.v`** — 4 manually-chosen test cases, each printing the result with
   `$display` for manual (eyeball) checking. Also documents a real early mistake: putting each
   test case in its own separate `initial` block, which actually run in PARALLEL at time 0 (a
   race condition), not sequentially as intended — fixed by moving all test cases into a single
   `initial` block.

2. **`testbench_selfcheck.v`** — same 4 test cases, but each one now compares the DUT's actual
   output against a hardcoded expected value and prints PASS/FAIL automatically, removing the
   need to manually check printed values by eye.

3. **`testbench_loop.v`** — replaces the 4 hardcoded test cases with a `for` loop driving all
   8 possible input combinations via `{a,b,cin} = i;`, computing the expected sum/cout from the
   known formulas inline, and self-checking each one. Demonstrates the exhaustive-testing
   pattern used for larger designs (comparator, ALU) earlier in this repo, but now written from
   scratch rather than provided.

## Key concepts learned
- `initial` block semantics (runs once, and multiple `initial` blocks run in **parallel**, not
  sequentially — a genuine early bug caught and fixed)
- `reg`/`wire` roles reversed in a testbench vs. a design (testbench drives with `reg`, observes
  DUT outputs with `wire`)
- `#<delay>` for letting combinational logic settle before checking results
- `$display` for printing, self-checking with `if/else`
- `for` loops with `integer` counters, and using concatenation (`{a,b,cin} = i;`) to sweep
  through all input combinations automatically

## Verification
All versions compiled and run locally with Icarus Verilog (installed for this purpose); 8/8
pass in the exhaustive loop version.
