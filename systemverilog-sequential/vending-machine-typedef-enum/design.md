# Vending Machine — `typedef enum` + Edge Detector — Design Notes

## Rebuild goals
Reimplements the earlier vending machine FSM using `typedef enum` for states, and re-derives the
edge-detector (`coin_pulse`) concept from first principles with a deep dive into *why* it works
and several genuine testbench debugging sessions.

## Real bugs and misconceptions caught along the way

**1. `coin_pulse = coin_in & coin_in_prev` (missing the NOT) was proposed and tested.**
Verified by direct simulation that this is backwards: it detects "held high" (both current and
previous are 1) rather than "just arrived" (current 1, previous 0). The `~` on `coin_in_prev` is
the essential part of the formula — without it, the logic is inverted from what's needed.

**2. Delta-cycle timing artifacts in the testbench (not the design) — hit repeatedly.**
Multiple testbench checks appeared to show designs failing when they were actually correct. Root
cause: changing a signal with a blocking assignment (`=`) and then immediately checking a
combinationally-derived value (via `assign` or `always_comb`) in the same statement, with no
delay, captures the *stale* value from before the combinational logic has a chance to
re-evaluate (which happens in a later delta cycle within the same simulation time). Fixed by
adding a small delay (`#0` or `#1`) between changing a signal and checking anything that depends
on it combinationally.

**3. A race condition from changing testbench stimulus right after `@(posedge clk)`.**
The DUT's own `always_ff @(posedge clk)` block is triggered by the same clock edge the testbench
is also reacting to; changing an input signal in the testbench immediately after that same edge
(with no separation) can race with the DUT's own evaluation of that signal, since simulators
don't guarantee execution order between multiple processes triggered by the same event. Standard
fix (and general convention): drive testbench stimulus at `@(negedge clk)` instead, safely away
from the DUT's `posedge`-triggered sampling point.

All of this was worked through by writing test after test and asking "is this a bug in my design
or a bug in my testbench?" — every single time, it turned out to be the testbench, and the
original design (once the edge-detector `~` was correctly in place) was right from very early on.
This is a genuine, repeated lesson in verification thinking: don't assume the DUT is wrong just
because a test fails.

## Verification
Confirmed correct with a properly-constructed testbench using a clean one-cycle pulse generator
task (`send_one_pulse`) and appropriate delta-cycle/negedge-safe timing.
