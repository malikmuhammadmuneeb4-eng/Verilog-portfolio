# 4-bit Comparator

Two implementations of a 4-bit LT/GT/EQ comparator: a simple behavioral version using built-in
operators, and a structural, priority-based version built from single-bit comparisons (MSB to
LSB), mirroring real hardware comparator architecture.

- **Inputs:** `a[3:0]`, `b[3:0]`
- **Outputs:** `LT`, `GT`, `EQ`

See [design.md](./design.md) for the full priority-logic reasoning, a worked trace example, and
two real bugs caught along the way (a declaration conflict caught by the compiler, and a
begin/end nesting bug).

## Verification
Compiled with Icarus Verilog and exhaustively tested against all 256 input combinations with a
self-checking testbench (comparing against Verilog's native `<`,`>`,`==` as ground truth) —
zero mismatches.

## Files
- `comparator_4bit.v` — both the behavioral (`comparator_4bit`) and structural
  (`comparator4bit`) versions
