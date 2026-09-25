# SystemVerilog Basics

First SystemVerilog practice: converting three already-verified plain-Verilog designs (MUX,
Decoder, Priority Encoder) to SystemVerilog syntax (`logic`, `always_comb`), focused purely on
the language-level differences.

See [design.md](./design.md) for the Verilog-to-SystemVerilog syntax comparison, and for a real
corrected misconception about `casez` wildcards (`x` does NOT work as a don't-care in `casez` —
only `z`/`?` do) discovered and confirmed by actually compiling and simulating both versions.

## Verification
All three modules compiled with Icarus Verilog in SystemVerilog mode (`-g2012`) and exhaustively
tested with self-checking testbenches (priority encoder: 7/7 assertions passed, including
priority-conflict cases and the no-input-active default case).

## Files
- `mux.sv`
- `decoder.sv`
- `priority_encoder.sv`
