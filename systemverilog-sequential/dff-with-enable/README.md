# D Flip-Flop with Enable

Extends the basic D flip-flop with an `enable` input: `enable=1` loads new data, `enable=0` holds
the current value (does not reset to 0 - a real misconception caught and corrected here: `q<=q`
means "hold," not "clear").

- **Inputs:** `d`, `clk`, `reset`, `enable`
- **Output:** `q`

## Verification
Compiled with Icarus Verilog (`-g2012`); simulated to confirm `q` genuinely holds its last value
across multiple cycles with `enable=0` (rather than becoming 0), verified against a change in `d`
that should have no effect while disabled.

## Files
- `d_flip_flop.sv`
