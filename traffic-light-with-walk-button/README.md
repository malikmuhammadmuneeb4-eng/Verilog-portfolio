# Traffic Light with Pedestrian Walk Button

Extends the earlier Moore traffic light FSM with a pedestrian crossing button, demonstrating that
a single FSM can mix Moore-style and Mealy-style outputs simultaneously.

- **Inputs:** `clk`, `reset`, `walk_button`
- **Outputs:** `state`, `light` (Moore), `walk_signal` (Mealy)

See [design.md](./design.md) for the reasoning behind why `light` stays Moore while
`walk_signal` needed to be Mealy, and why the state-transition logic needed no changes at all.

## Verification
Compiled with Icarus Verilog; self-checking testbench, 10/10 assertions passed, confirming the
automatic cycle is unaffected by the button and `walk_signal` fires with correct Mealy timing
only when safe (state==RED).

## Files
- `mooremachine.v` — Verilog design (three always blocks: state register, Moore light output,
  Mealy walk_signal output)
