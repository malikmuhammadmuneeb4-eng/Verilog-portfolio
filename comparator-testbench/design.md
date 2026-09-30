# 4-bit Comparator Testbench — Design Notes

## Purpose
Second exhaustive, self-checking testbench built independently (after the priority encoder one),
reusing the same template: loop through all input combinations, independently compute the
expected output, compare against the DUT, report PASS/FAIL.

## Real bugs caught while building this
- `<<`/`>>` (shift operators) mistakenly used instead of `<`/`>` (comparison operators) - the
  same mistake caught once before, weeks earlier, while building a standalone `is_greater`
  function; recurred here and was corrected the same way.
- Port connection `EQ(.EQ)` had the dot in the wrong place (should be `.EQ(EQ)` - dot immediately
  before the port name, not inside the parentheses); an earlier attempt also simply omitted the
  dot entirely (`EQ(EQ)`).
- `if else` (wrong keyword order) instead of `else if`.
- Off-by-one loop bound: `a[3:0]` and `b[3:0]` concatenated give 8 bits, so all combinations
  require `i<256` (2^8), not `i<255` - the latter would silently skip the very last combination
  (a=15, b=15).

## Loop-bound reasoning, worked through explicitly
For an n-bit combined signal, valid values range from `0` to `2^n - 1` (never starting at 1,
since binary counting starts at 0 and an n-bit value cannot represent 2^n itself - e.g. a 4-bit
value maxes out at 15, not 16). Therefore the correct loop is `for (i=0; i<2^n; i=i+1)` -
confirmed that `i<2^n` and `i<=2^n-1` are equivalent and both correct, while starting from `i=1`
would both skip the valid all-zero combination and attempt an out-of-range value at the top end.
Also confirmed directly via simulation that a SystemVerilog `for` loop's body never executes for
the exact boundary value in a `<` condition (e.g. `for (i=0;i<5;i=i+1)` runs i=0..4, never i=5).

## Verification
Compiled and run locally with Icarus Verilog (no AI assistance for the compile/run step).
All 256 exhaustive combinations passed (256/256 PASS, 0 FAIL).
