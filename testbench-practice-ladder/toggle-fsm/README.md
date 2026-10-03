# Testbench Ladder - Step 4: Toggle FSM

A deep dive into clock-edge timing: a trivial no-input toggle FSM used specifically to isolate
and fully understand how fixed-period delays can silently skip clock edges.

See [design.md](./design.md) for the full story - a skipped-edge bug found and fixed twice
independently (once by hand-tracing a timeline, once by reading a real generated waveform), the
precise rule for when a delay is or isn't needed, and setting up EDA Playground + EPWave as a
free/legal waveform-viewing toolchain.

See the [ladder overview](../design.md) for the full set of lessons across all five steps.

## Files
- `toggle_fsm.sv`
- `testbench.sv` - final, correct version (includes `$dumpfile`/`$dumpvars` for waveform viewing)
