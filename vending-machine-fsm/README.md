# Vending Machine FSM

A 2-state Mealy FSM modeling a simple vending machine (10-cent item, 5-cent coins). Designed
independently, then hardened with edge-detection after discovering a genuine input-timing bug.

- **Inputs:** `clk`, `reset`, `coin_in`
- **Outputs:** `state`, `dispense`

See [design.md](./design.md) for:
- The 2-state design and transition table
- A real hardware bug found via simulation (spurious double-counting when `coin_in` is held high
  across multiple cycles) and its fix (edge detection / pulse generation)
- A "was it the design or the testbench?" debugging story — a test that appeared to fail turned
  out to have a bug in the test itself (missing a reset between independent scenarios), not in
  the design

## Verification
Compiled with Icarus Verilog and tested against multiple realistic scenarios (held-high input,
clean separate pulses, held-then-released-then-one-more), with a self-checking testbench.

## Files
- `vendingmachine.v` — Verilog design, including the edge-detector logic
