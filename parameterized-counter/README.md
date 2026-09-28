# Parameterized Counter — Sync & Async Reset

Extends the earlier counter-with-enable to be width-configurable via a `parameter`, and explores
the difference between synchronous and asynchronous reset.

- **Parameter:** `N` (bit width, default 4)
- **Inputs:** `clk`, `reset`, `en`
- **Output:** `count[N-1:0]`

See [design.md](./design.md) for:
- How a single module definition serves multiple widths (N=4 and N=8 instantiated and verified
  simultaneously from the same code)
- The distinction between natural full-width overflow (no extra logic needed) and explicit
  wraparound logic (needed for non-power-of-two ranges like a Mod-6 counter) - connected directly
  to a mock-interview question about Mod-6 counter glitch recovery
- Sync vs async reset, confirmed via a mid-cycle reset test, plus the real-world reasoning for
  why async reset exists (clock instability at power-up, clock-stopped low-power modes)

## Verification
Both versions compiled with Icarus Verilog. Sync version tested at two widths at once; async
version tested by asserting reset outside any clock edge window and confirming immediate effect.

## Files
- `counter.sv` — both `counter` (sync reset) and `counter_async` (async reset)
