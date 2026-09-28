# Parameterized Counter — Sync & Async Reset — Design Notes

## Concept: `parameter` for reusable, configurable width

```systemverilog
module counter #(parameter N = 4) (...);
```

A single module definition can be instantiated at multiple widths without rewriting any code:

```systemverilog
counter #(.N(4)) dut4 (...);
counter #(.N(8)) dut8 (...);
```

Width throughout the module is expressed as `[N-1:0]` instead of a hardcoded `[3:0]`.

## Natural overflow vs. explicit wraparound

Realized independently (connecting back to a mock-interview question about a Mod-6 counter):
when a counter uses its **full** bit-width (e.g. a 4-bit counter counting 0-15), `count <= count+1`
naturally wraps at `2^N - 1` with no extra logic needed - the overflow bit is simply discarded by
the fixed-width register.

An **explicit** wraparound check (`if (count==5) count<=0; else count<=count+1;`) is only needed
when the desired range is *not* a full power-of-two of the bit-width - e.g. a Mod-6 counter using
a 3-bit register (which naturally spans 0-7) but only wanting states 0-5. Verified via the
mock-interview bonus question: without the explicit check, a Mod-6 counter that glitches into an
invalid state (6 or 7) would continue counting through those extra states before eventually
wrapping back into the valid range - the explicit check is what forces immediate recovery.

Confirmed via simulation: instantiating the same parameterized counter at N=4 and N=8
simultaneously, both wrapped correctly at their own natural limits (15 and 255 respectively)
using identical code with no manual range-checking.

## Synchronous vs Asynchronous Reset

**Synchronous** (only reacts on a clock edge):
```systemverilog
always_ff @(posedge clk)
begin
    if (reset) count <= 0;
    else if (en) count <= count+1;
end
```

**Asynchronous** (reacts immediately, independent of the clock):
```systemverilog
always_ff @(posedge clk or posedge reset)
begin
    if (reset) count <= 0;
    else if (en) count <= count+1;
end
```

Confirmed via simulation: asserting `reset` in the middle of a clock period (with no clock edge
occurring) caused `count` to drop to 0 within 1 time unit for the async version - the defining,
observable difference from synchronous reset, which would only take effect on the next clock edge.

## Why async reset matters (real-world reasoning, derived through discussion)
- **Power-up**: the clock itself may not be stable/clean in the first moments after power-on: a
  synchronous reset depending on that same unreliable clock edge may fail to fire in time, so the
  chip needs a way to reach a known state independent of clock health.
- **Clock-stopped scenarios** (e.g. power-saving modes): if the clock can stop entirely, a
  synchronous reset can never fire at all, since it has no edge to trigger on - self-derived
  during this session as the clearest justification for needing async reset.
- **Trade-off noted**: async reset is more susceptible to glitches on the reset line itself
  (since there's no clock edge to filter/sample it), which is why many real designs use
  "asynchronous assert, synchronous de-assert" to get the safety of async assertion with
  glitch-free, clock-aligned de-assertion.

## Verification
Both versions compiled with Icarus Verilog. Sync version's overflow behavior verified at two
widths (N=4, N=8) simultaneously. Async version verified with a testbench asserting reset mid-cycle
(no clock edge in the window) and confirming immediate effect.
