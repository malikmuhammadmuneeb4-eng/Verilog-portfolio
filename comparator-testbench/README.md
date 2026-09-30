# 4-bit Comparator Testbench

Second exhaustive, self-checking testbench (after the priority encoder one), covering all 256
input combinations of a 4-bit comparator using the same reusable template.

- **DUT:** `comparator4bit` (a[3:0], b[3:0] in, LT/GT/EQ out)
- **Testbench:** loops through all 256 combinations, independently computes expected LT/GT/EQ
  using plain `<`/`>` comparisons, and reports PASS/FAIL per case

See [design.md](./design.md) for real bugs caught (shift-vs-comparison operator confusion
recurring from an earlier session, a misplaced instantiation dot, `if else` vs `else if`) and a
worked-through explanation of correct loop bounds for exhaustive n-bit testing (`i<2^n`, never
starting from 1), confirmed directly via simulation.

## Verification
Compiled and run locally with Icarus Verilog, without AI assistance for the compile/run step.
All 256 combinations passed.

## Files
- `comparator4bit.sv`
- `testbench.sv`
