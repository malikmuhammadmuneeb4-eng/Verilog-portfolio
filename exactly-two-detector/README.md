# "Exactly 2 of 3" Detector

Designed entirely independently (truth table -> SOP -> K-map judgment call -> gate-level circuit
sketch -> Verilog) as a design-practice exercise, without following an existing worked example.

- **Inputs:** `a`, `b`, `c`
- **Output:** `y` (1 when exactly two of the three inputs are 1)

See [design.md](./design.md) for the full derivation and the important lesson about
distinguishing "irreducible via K-map" from "checkerboard/XOR pattern."

## Files
- `exactlytwo.v` — Verilog design
