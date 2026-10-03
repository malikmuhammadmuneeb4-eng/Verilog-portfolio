# Testbench Ladder - Step 4: Toggle FSM - Design Notes

## The DUT
A trivial 2-state Moore FSM with no data inputs - every clock edge simply toggles between
STATE_A and STATE_B, except when `reset` forces STATE_A. Chosen specifically because it isolates
pure clock/edge timing behavior from any input-dependent logic.

## The central bug: fixed-period delays skip clock edges

Early testbench versions inserted a fixed delay (first `#4`, later mistakenly `#10`, equal to the
full clock period) between `@(posedge clk)`-based checks, intending to "wait one more cycle"
before the next check. This is fragile/wrong: if the fixed delay is long enough to carry
simulation time past the *next* intended edge, the subsequent `@(posedge clk)` call lands on the
edge *after* that one instead - silently skipping an edge's effect on the DUT. The result was a
consistent "off by one state" pattern across all post-reset checks.

Traced to ground truth twice, independently:
1. By hand, constructing a precise timeline of clock edges (t=5,15,25,35,45 for a period-10
   clock) and walking through exactly which edge each `@(posedge clk)` call would actually land
   on given the preceding delay.
2. Later, by actually generating a real waveform (EDA Playground + EPWave, see below) and reading
   it directly - independently re-identifying the same skipped-edge pattern without being told,
   purely by observing that `reset` was still high at an edge the testbench intended to have
   already passed.

**Fix:** removed all fixed-period delays between cycle-advances entirely; rely only on
`@(posedge clk)` to step one cycle at a time. A short `#1` is still used (and still required)
immediately after each `@(posedge clk)`, purely to let the DUT's non-blocking assignment commit
before checking it - this is categorically different from a fixed-period inter-cycle delay and
does not cause skipping.

## Rule derived for when a delay is or isn't needed (generalizes beyond this design)
- Setting an input (`reset=1;`) - never needs a delay, before or after; it's an immediate
  blocking assignment with no clock/commit involved.
- Checking a DUT's registered output right after `@(posedge clk)` - always needs a short `#1`
  first (confirmed directly: without it, the read value was `x`/stale; with it, correct).
- Advancing one more clock cycle - always use `@(posedge clk)` again; never a fixed
  `#<period>`-style delay, since its safety depends on exactly how much time has already elapsed
  since the last edge, which is easy to miscalculate (as happened here).

## Real waveform tooling: EDA Playground + EPWave
Set up as a free, legal, browser-based replacement for a local GTKWave install when local file
management for `iverilog`/`vvp` became a friction point (correct exact filenames with no
installing a cracked/pirated simulator was explicitly identified and avoided, in favor of this
legitimate free toolchain). `$dumpfile`/`$dumpvars` added to the testbench, "Open EPWave after
run" used to view the resulting waveform directly.

Also used to build intuition for basic timing-diagram vocabulary (period, high/low time, rising/
falling edge) by generating and reading a trivial 2-time-unit-period clock, and to directly
verify (not just reason about) the delta-cycle commit-timing rule above.

## Verification
Final version (no fixed inter-cycle delays, `#1` retained after each `@(posedge clk)`) passed
all 5 checks, confirmed both via local Icarus Verilog and via EDA Playground with a viewed
waveform matching the expected timeline exactly.
