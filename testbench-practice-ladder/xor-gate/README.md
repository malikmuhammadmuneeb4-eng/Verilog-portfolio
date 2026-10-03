# Testbench Ladder - Step 1: XOR Gate

Simplest drill in the ladder: 4 manual test cases for a combinational XOR gate.

**Real bug caught:** initially checked `y` immediately after setting `a`/`b` with no delay,
causing every check to read the *previous* test case's value (a one-case-behind pattern) due to
delta-cycle scheduling - fixed by adding `#10` before each check, not just between cases.

See the [ladder overview](../design.md) for the full set of lessons across all five steps.
