# Overlapping "101" Sequence Detector

A Mealy FSM that detects the overlapping pattern "1,0,1" in a serial bit stream (e.g. the input
`1,0,1,0,1` detects twice — once at the first "1,0,1", and again reusing the trailing "0,1" as
the start of a new match).

- **Inputs:** `clk`, `reset`, `x` (serial bit stream)
- **Outputs:** `state[1:0]`, `z` (fires 1 the instant the pattern completes)

See [design.md](./design.md) for:
- Why this needed to be a Mealy machine rather than Moore
- The full 4-state design and transition table
- A complete from-scratch Boolean equation derivation (NQ1, NQ0, Z) from the truth table,
  including two real mistakes caught and corrected via verification (an incorrect K-map grouping,
  and two incorrect early guesses for Z)
- A genuine Mealy-vs-Moore timing bug caught during Verilog verification (checking the
  post-transition state instead of the pre-transition state + input, which silently produces a
  Moore-style one-cycle-late output instead of true Mealy behavior)

## Verification
- Design exhaustively checked in Python against a brute-force reference detector across all
  input sequences up to 8 bits long — zero mismatches
- Boolean equations verified against the full truth table
- Verilog compiled with Icarus Verilog; output logic directly verified against all 8
  (state, input) combinations, including a mid-cycle timing check confirming genuine Mealy
  (not Moore) behavior

## Files
- `sequencedectector.v` — Verilog design (two-always-block FSM pattern)
