# Moore FSM — Traffic Light Controller

A 3-state Moore finite state machine (RED -> GREEN -> YELLOW -> RED) using the standard
two-always-block FSM coding pattern: a clocked state register plus a combinational output
decoder.

- **Inputs:** `clk`, `reset`
- **Outputs:** `state[1:0]` (current state code), `light[2:0]` (decoded red/green/yellow output)

See [design.md](./design.md) for the Moore-vs-Mealy distinction, state encoding, and why the
two-always-block pattern matters.

## Files
- `mooremachine.v` — Verilog design

## Next steps
- Add a timer so each state holds for multiple cycles instead of switching every edge
- Rebuild as a Mealy machine for comparison (e.g. add a pedestrian-crossing input that
  immediately affects the output)
- Add a testbench that walks through a full reset + several cycles and checks `light` matches
  the expected sequence
