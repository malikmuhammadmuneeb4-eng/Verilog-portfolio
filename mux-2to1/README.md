# 2-to-1 Multiplexer

A basic 2-to-1 MUX implemented in Verilog using a behavioral `always/case` style.

- **Inputs:** `i0`, `i1` (data), `s` (select)
- **Output:** `y`

See [design.md](./design.md) for the truth table and Boolean derivation.

## Files
- `mux2to1.v` — Verilog design

## Next steps
- Add a testbench to verify all input combinations
- Add an `assign`-based ternary version for comparison
