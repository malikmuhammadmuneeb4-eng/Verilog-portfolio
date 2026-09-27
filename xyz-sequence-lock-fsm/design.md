# XYZ Sequence Lock FSM — Design Notes

## Spec
A lock with three buttons (X, Y, Z) opens only when the exact sequence X, Y, Z is pressed in
order. Any wrong button resets progress back to the start. Designed and hand-traced entirely at
the table level before writing any code (see the design process below), specifically to build
independent FSM design fluency.

## Design process (table-first, no code)
1. Defined states: **s0** (nothing matched), **s1** (X matched), **s2** (X,Y matched)
2. Explicitly enumerated the result of **every** input in **every** state (not just the "expected
   path") — this was the key habit being practiced, since missing a case is the most common real
   FSM design mistake
3. Made an explicit design choice: a repeated X while already progressing (e.g. X pressed twice
   in a row) is treated as "sticky" (stays at the current progress level) rather than resetting -
   a valid, self-consistent choice, confirmed by testing
4. Hand-traced multiple full sequences (X,Y,Z; X,X,Y,Z; Y,X,Z; X,Z) against the table before
   writing any Verilog, confirming the design was correct entirely on paper first

## Full transition table

| State | Input | Next State | Output (unlock) |
|-------|-------|------------|------------------|
| s0 | X | s1 | 0 |
| s0 | Y | s0 | 0 |
| s0 | Z | s0 | 0 |
| s1 | X | s1 | 0 |
| s1 | Y | s2 | 0 |
| s1 | Z | s0 | 0 |
| s2 | X | s1 | 0 |
| s2 | Y | s0 | 0 |
| s2 | Z | s0 | 1 |

## Two Verilog implementations

**`xyz_seq_detector.sv`** — inline version, full nested if/else directly inside the
`always_ff` state register block (same style as the earlier "101" sequence detector).

**`xyz_seq_detector_function.sv`** — the entire next-state decision logic extracted into a
`function` (`next_state_logic`), called from a single line inside `always_ff`. Demonstrates that
combinational decision logic can be factored out of a clocked block into a reusable function
without changing behavior — confirmed identical (12/12 test assertions pass in both versions).

## Real bugs caught while coding
- `tpyedef` typo (letters transposed)
- Missing `logic` base type in `typedef enum[1:0]{...}` (needed `typedef enum logic [1:0]{...}`)
- Non-blocking assignment (`<=`) mistakenly used inside an `always_comb` block (should always be
  blocking `=` in combinational logic) - caught as a compiler warning
- Reserved keyword `input` mistakenly used as a signal name (renamed to `button`)
- Inside the function version: initially tried assigning to `{LT,GT,EQ}`-style undeclared signals
  instead of the function's own name; corrected to always assign to the function's name, and
  changed the return type from 1-bit to the correct multi-bit/enum width for the value being
  returned

## Verification
Both versions compiled with Icarus Verilog and exhaustively tested with a self-checking
testbench covering: the correct sequence, a sticky-X-repeat variant, a wrong-first-button case,
and a broken-mid-sequence case. 12/12 (13/13 in the earliest full-coverage run) assertions
passed for both implementations.
