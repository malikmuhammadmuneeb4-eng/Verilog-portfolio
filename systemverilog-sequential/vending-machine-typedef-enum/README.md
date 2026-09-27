# Vending Machine — `typedef enum` + Edge Detector

Rebuild of the vending machine FSM using `typedef enum` states, with the coin-pulse edge detector
re-derived from scratch and deeply debugged.

- **Inputs:** `clk`, `reset`, `coin_in` (raw signal)
- **Outputs:** `state`, `dispense`

See [design.md](./design.md) for a genuinely deep debugging session covering an incorrect
edge-detector formula (missing NOT), delta-cycle timing artifacts, and a clock-edge race
condition in the testbench — all traced down to "is it the design or the test?" and resolved
each time by finding the testbench was at fault, not the design.

## Files
- `vending_machine.sv`
