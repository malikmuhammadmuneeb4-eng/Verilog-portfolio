# Traffic Light FSM — `typedef enum` version

Rebuild of the earlier traffic light FSM using SystemVerilog's `typedef enum` for named states
instead of manual `parameter` encodings.

- **Inputs:** `clk`, `reset`
- **Outputs:** `state` (state_t), `light[2:0]` (one-hot: red=100, green=010, yellow=001)

## Design notes
- `typedef enum` must be declared **outside** the module (before it), since it's used directly
  in the port list — a real compile error was hit and fixed when this was first attempted with
  the typedef inside the module.
- One-hot `light` encoding means the `case(state)` block inside `always_comb` effectively *is* a
  decoder — no separate decoder module is needed, since the case statement directly produces the
  per-LED control signals from the 2-bit state.
- A genuine, corrected misconception along the way: assumed `enum` type-checking would catch an
  invalid value assignment at compile time — verified by actually testing it, and found that
  Icarus Verilog does NOT enforce this (silently accepts out-of-range values). Commercial tools
  (Questa/VCS) are expected to enforce this more strictly; `enum` is still worth using here for
  readability and named-value waveform display, just not relied on as a safety net with this
  particular open-source toolchain.

## Verification
Compiled with Icarus Verilog; self-checking testbench confirmed correct RGY cycling and correct
one-hot light values, 4/4 assertions passed.

## Files
- `traffic_light_FSM.sv`
