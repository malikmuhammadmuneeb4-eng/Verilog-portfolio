# 4-bit Ripple Carry Adder

A 4-bit adder built two ways: structurally (chaining 4 instantiated full adders) and
behaviorally (using the `+` operator directly). Both produce identical results; the structural
version is the one that reflects real hardware architecture.

- **Inputs:** `a[3:0]`, `b[3:0]`, `cin`
- **Outputs:** `sum[3:0]`, `cout`

See [design.md](./design.md) for the carry-chain explanation, a worked example, and how
overflow is captured in `cout`.

## Files
- `ripple_adder4_structural.v` — built from 4 instantiated `fulladder` modules (depends on the
  `fulladder` module from the [full-adder](../full-adder) project)
- `ripple_adder4_behavioral.v` — built using the `+` operator directly

## Next steps
- Add a testbench comparing both versions against each other across many random inputs
- Extend to an 8-bit or parameterized N-bit adder
- Use this as a base to explore carry-lookahead adders (faster, more complex carry logic)
