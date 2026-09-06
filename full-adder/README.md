# Full Adder

A full adder implemented in Verilog using continuous `assign` statements, derived directly
from the Sum/Cout equations found via truth table + K-map analysis.

- **Inputs:** `a`, `b`, `cin`
- **Outputs:** `sum`, `cout`

See [design.md](./design.md) for the full derivation, including why Sum (an XOR-type function)
resists K-map simplification while Cout (a majority function) simplifies cleanly.

## Files
- `fulladder.v` — Verilog design

## Next steps
- Add a testbench covering all 8 input combinations
- Use this module to build a 4-bit Ripple Carry Adder (structural instantiation)
