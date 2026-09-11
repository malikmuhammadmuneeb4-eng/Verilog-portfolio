# 1-bit ALU

A simplified 1-bit Arithmetic Logic Unit selecting between AND/OR/XOR/NOT based on a 2-bit
select code — a small taste of the core computation block inside a real CPU.

- **Inputs:** `a`, `b`, `sel[1:0]`
- **Output:** `y`

See [design.md](./design.md) for the MUX-based design reasoning and the discriminating-test-case
verification methodology used in CircuitVerse before writing any code.

## Verification
Compiled with Icarus Verilog and exhaustively tested against all 16 input combinations with a
self-checking testbench — zero mismatches.

## Files
- `alu.v` — Verilog design
