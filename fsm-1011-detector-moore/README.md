# "1011" Overlapping Sequence Detector (Moore FSM)

A 5-state Moore FSM that detects the overlapping pattern "1,0,1,1" in a serial bit stream (e.g.
the stream `0,0,0,1,0,1,1,1,0,1,1,0,1,1,0,0` contains three overlapping matches). Built as a
companion/contrast to [`fsm-101-detector`](../fsm-101-detector) (a Mealy detector for "101") to
practice the Moore-vs-Mealy distinction directly — same kind of problem, deliberately built the
other style.

- **Inputs:** `clk`, `reset`, `x` (serial bit stream)
- **Outputs:** `y` (Moore output — depends only on current state, not the current input)
- **States:** `s0`..`s4`, where `s4` represents "1011 fully matched"; `y=1` exactly when
  `state==s4`.

See [design.md](./design.md) for the state/transition table, the Moore-vs-Mealy output-logic
mistake caught while building it, and the overlap-handling subtlety in the `s3` transition.

## Verification
Compiled and run with Icarus Verilog. 9/9 PASS, including two overlapping detections in one run.

## Files
- `sequence_detector.sv` — design
- `sequence_detector_tb.sv` — testbench (task-based, reusable `seq` check)
