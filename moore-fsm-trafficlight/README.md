# Moore FSM — Traffic Light Controller (with timed hold)

A 3-state Moore finite state machine (RED -> GREEN -> YELLOW -> RED), rebuilt as a cold-recall
revision exercise with a real per-state timed hold (RED 4 cycles, GREEN 3, YELLOW 2) added on
top of the original bare state-switching version (preserved in git history).

- **Inputs:** `clk`, `reset`
- **Outputs:** `light[2:0]` (one-hot decoded red/green/yellow output)
- **4 always blocks:** next-state logic (`always_comb`), state register (`always_ff`), a
  per-state hold counter (`always_ff`), and output logic (`always_comb`) — the standard
  next-state / state-register / output-decoder Moore pattern, with the counter as a 4th block
  since each state now holds for a different number of cycles rather than switching every edge.

See [design.md](./design.md) for the counter-reset design, an Icarus-specific `?:`-with-enum
cast quirk, and every bug caught building the design and its testbench.

## Verification
Compiled and run with Icarus Verilog. Design + testbench: 5/5 PASS (reset, then one full
RED->GREEN->YELLOW->RED cycle with timing checked at every transition).

## Files
- `traffic_light.sv` — design
- `traffic_light_tb.sv` — testbench
