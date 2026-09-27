# 4-bit Counter with Enable

Scales the register-with-enable pattern to a counter: `enable=1` increments each cycle,
`enable=0` holds the current count (does not reset), `reset=1` forces count to 0.

- **Inputs:** `clk`, `reset`, `enable`
- **Output:** `count[3:0]`

## Verification
Compiled with Icarus Verilog; tested reset, counting while enabled, holding while disabled
(resuming from the held value rather than restarting), and overflow wraparound after 16 counts.

## Files
- `four_bit_counter.sv`
