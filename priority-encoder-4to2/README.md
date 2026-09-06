# 4-to-2 Priority Encoder

A priority encoder implemented in Verilog using `casez` to handle multiple simultaneously
active inputs, always resolving to the highest-priority active input (i3 > i2 > i1 > i0).

- **Inputs:** `i0`, `i1`, `i2`, `i3`
- **Outputs:** `a`, `b` (2-bit code), `valid` (1 if any input is active)

See [design.md](./design.md) for the priority table and reasoning.

## Files
- `encoder.v` — Verilog design

## Next steps
- Add a testbench covering simultaneous-input cases specifically
- Extend to an 8-to-3 priority encoder
