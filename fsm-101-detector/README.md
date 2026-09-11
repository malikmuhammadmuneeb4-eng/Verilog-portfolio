# Overlapping "101" Sequence Detector (in progress)

A Mealy FSM that detects the overlapping pattern "1,0,1" in a serial bit stream (e.g. the input
`1,0,1,0,1` should detect twice).

**Status: design complete and exhaustively verified; Verilog not yet written.**

See [design.md](./design.md) for:
- The reasoning for why this needed to be a Mealy machine, not Moore
- The 4-state design and full transition table
- Exhaustive verification against a reference implementation (all sequences up to 8 bits)
- A from-scratch Boolean equation derivation for the next-state logic (NQ1 done; NQ0 and Z
  planned for the next session), including a real K-map grouping mistake caught by verification

## Next steps
- Finish deriving NQ0 and Z equations from the truth table
- Write the Verilog module (likely two `always` blocks: state register + Mealy output logic,
  or a direct gate-level implementation from the derived equations)
- Build a self-checking testbench feeding in bit streams and checking `Z` against expected
  overlapping-match positions
