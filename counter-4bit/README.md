# 4-bit Up Counter

A synchronous 4-bit up counter with active reset, built as a register with feedback (+1 each
clock edge).

- **Inputs:** `clk`, `reset`
- **Output:** `cout[3:0]`

See [design.md](./design.md) for the block-level explanation, overflow behavior, and the
synchronous vs asynchronous counter distinction.

## Files
- `counter.v` — Verilog design

## Next steps
- Add a `down` input to make this an up/down counter
- Add a terminal-count (`tc`) output flag that pulses when about to wrap
