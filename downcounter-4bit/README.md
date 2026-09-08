# 4-bit Down Counter

A synchronous 4-bit down counter with active reset (resets to `1111`, the max value).

- **Inputs:** `clk`, `reset`
- **Output:** `cout[3:0]`

See [design.md](./design.md) for underflow behavior and how it connects to 2's complement
subtraction.

## Files
- `downcounter.v` — Verilog design

## Next steps
- Add a testbench verifying the underflow wraparound (0000 -> 1111)
- Combine with the up counter into a single up/down counter module
