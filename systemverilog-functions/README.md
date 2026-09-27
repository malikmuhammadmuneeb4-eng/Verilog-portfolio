# SystemVerilog `function` Practice

First hands-on practice with SystemVerilog `function`: rebuilding two already-verified designs
(equality checker, priority-based comparator) as callable functions instead of inline logic.

See [design.md](./design.md) for the syntax rules learned, a corrected misconception
("functions can't use if/else" — false, verified by testing), and two real bugs caught while
converting the comparator (assigning to the wrong signal, and an incorrect return type width).

## Verification
Both compiled with Icarus Verilog and exhaustively tested — 0 mismatches across all 256 (a,b)
combinations for each.

## Files
- `equality_checker.sv`
- `comparator_module.sv`
