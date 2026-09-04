# 2-to-4 Decoder

A 2-to-4 binary decoder implemented in Verilog, using concatenation for both the case selector
and the one-hot output assignment.

- **Inputs:** `a`, `b`
- **Outputs:** `y0`, `y1`, `y2`, `y3` (one-hot, exactly one active per input combination)

See [design.md](./design.md) for the truth table and Boolean derivation.

## Files
- `decoder2to4.v` — Verilog design

## Next steps
- Add a testbench to verify all 4 input combinations
- Extend to a 3-to-8 decoder
