# Testbench Practice Ladder — Overview

## Purpose
A structured, difficulty-ramped series of testbenches written entirely from scratch for fresh
(not previously built) designs, specifically to build independent testbench-writing fluency
ahead of technical interviews — identified as a weak area after a mock interview exposed gaps in
basic (non-UVM) testbench skills.

## Ladder (easy to hard)
1. **XOR gate** (combinational, manual cases) — basic structure, settle-delay concept
2. **Majority gate** (combinational, loop-based) — self-checking loop, infinite-loop bug, `=`/`==`
3. **D Flip-Flop** (sequential, single input) — clock generation, `@(posedge clk)`, instantiation
4. **Toggle FSM** (sequential, no inputs) — edge-skipping via fixed delays, delta-cycle timing,
   real waveform tooling (EDA Playground + EPWave)
5. **3-state Process FSM** (sequential, 2 inputs, multi-stage) — precondition checks, a
   self-caught design-vs-testbench logic bug

## Key, recurring lessons across the whole ladder

### Settle-delay is needed everywhere, not just sequential circuits
Checking a signal immediately after changing an input it depends on (even for purely
combinational `assign` logic) can read a stale value due to delta-cycle scheduling. A small
delay (`#1`) between changing an input and checking a dependent output is required in both
combinational and sequential contexts.

### The precise rule for *when* a delay is needed (derived through extensive discussion)
- Setting an input signal (`reset=1; d=0;`) — never needs a delay before or after, it takes
  effect immediately (it's a plain blocking-assigned `reg`).
- Checking a DUT's registered output (`state`, `q`, `count`) immediately after `@(posedge clk)`
  — always needs a short delay (`#1`) first, because non-blocking (`<=`) assignments inside the
  DUT's `always_ff` are scheduled to commit in a later delta cycle, not instantaneously at the
  edge. Verified directly by comparing `q` read with and without the `#1` — confirmed `x`
  (stale/uncommitted) without it, `1` (correct, committed) with it.
- Advancing to the next clock cycle — always use `@(posedge clk)` again, never a fixed
  `#<period>`-style delay.

### Fixed-period delays between `@(posedge clk)` calls silently skip edges
Inserting a delay equal to or greater than the clock period between uses of `@(posedge clk)`
causes the next `@(posedge clk)` to land on a *later* edge than intended, since the delay itself
already carries the simulation time past the edge that was meant to be waited for. This produces
results that are consistently "one state behind" what was expected, without any compile or
obvious runtime error. Confirmed and resolved twice independently (via reasoning through a
precise timeline, and later via actually generating and reading a real waveform in EPWave that
showed the skipped edge directly). The robust fix is to never mix fixed-period delays with
`@(posedge clk)`-based cycle stepping.

### Real waveform tooling
Set up and used EDA Playground + EPWave (free, legal) to generate and read actual `.vcd`
waveforms from self-written testbenches, rather than only reasoning about timing on paper -
including independently re-discovering the "skipped edge" bug by reading a real waveform.

## Verification
All five designs were compiled and run (locally via Icarus Verilog, and via EDA Playground),
with all final testbench versions passing their respective checks after the bugs described in
each project's own notes were found and fixed.
