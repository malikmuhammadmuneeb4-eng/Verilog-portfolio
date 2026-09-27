# XYZ Sequence Lock FSM

A 3-button sequence-lock FSM (unlocks only on X, Y, Z pressed in order), designed entirely at the
table level first — no code until the full transition table was built and hand-traced against
multiple sequences. Implemented two equivalent ways: inline nested if/else, and with the
next-state logic factored into a `function`.

- **Inputs:** `clk`, `reset`, `button` (button_t: x/y/z)
- **Outputs:** `state` (state_t), `unlock`

See [design.md](./design.md) for the full table-first design process, the design choice around
repeated-button ("sticky") behavior, and several real syntax/semantic bugs caught while coding
(a transposed-letter typo, a missing `logic` base type in an enum declaration, non-blocking
assignment inside `always_comb`, and the reserved keyword `input` mistakenly used as a signal
name).

## Verification
Both versions compiled with Icarus Verilog and exhaustively tested with a self-checking
testbench covering the correct sequence, sticky-repeat, wrong-first-button, and broken-sequence
cases — all assertions passed identically in both implementations.

## Files
- `xyz_seq_detector.sv` — inline nested if/else version
- `xyz_seq_detector_function.sv` — next-state logic factored into a `function`
