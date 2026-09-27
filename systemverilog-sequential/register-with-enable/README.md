# 4-bit Register with Enable

Scales the single-bit D-flip-flop-with-enable pattern up to a 4-bit bus.

- **Inputs:** `clk`, `reset`, `enable`, `d[3:0]`
- **Output:** `q[3:0]`

## Verification
Compiled with Icarus Verilog; self-checking testbench confirmed reset, load-on-enable, and
hold-on-disable behavior across a full sequence (load, hold while d changes, load again).

## Files
- `four_bit_register.sv`
