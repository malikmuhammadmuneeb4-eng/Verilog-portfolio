# Testbench Ladder - Step 2: Majority Gate

Loop-based, self-checking testbench for a 3-input majority gate (all 8 combinations).

**Real bugs caught:**
- `i=1+1` instead of `i=i+1` - always assigns 2 regardless of current `i`, causing an infinite
  loop (caught before it could hang, by reasoning through what the expression actually does).
- `if (y=expected_y)` - classic blocking-assignment-instead-of-comparison bug (`=` vs `==`).
- A PASS/FAIL `$display` copy-paste mistake (FAIL branch's string still said "PASS").
- Missing settle-delay before the very first check (same lesson as the XOR gate, re-applied
  correctly here on the first attempt after it was pointed out once).

See the [ladder overview](../design.md) for the full set of lessons across all five steps.
