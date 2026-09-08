# 4-bit Up Counter — Design Notes

## Concept
A synchronous 4-bit register that increments by 1 on every rising clock edge, resetting to 0
when `reset` is asserted. All 4 bits update simultaneously (synchronous), avoiding the
propagation-delay issues of asynchronous/ripple counters.

## Block-level view
- Register holds current `count`
- Combinational `+1` computes the next value
- A mux (implemented as `if/else` in the always block) selects between `0` (reset) and
  `count+1` (normal operation), feeding the register's input

## Overflow / wraparound
Since `count` is only 4 bits, `1111 + 1` naturally wraps to `0000` (the carry bit is simply
discarded). This is the *desired* behavior for most counters (e.g. clock seconds counters),
not a bug — contrast with the ripple-carry-adder project, where the overflow bit is explicitly
needed and captured via `cout`.

## Synchronous vs Asynchronous (ripple) counters
- **Synchronous** (this design): every flip-flop shares the same clock directly — all bits
  change at exactly the same instant.
- **Asynchronous/ripple**: only the first flip-flop uses the real clock; each subsequent stage
  is clocked by the previous stage's output, causing propagation delay to accumulate through
  the chain. Simpler to build, but bits don't all change at once — risky if other logic reads
  the count mid-ripple.

Synchronous is preferred in most modern designs for this reason.
