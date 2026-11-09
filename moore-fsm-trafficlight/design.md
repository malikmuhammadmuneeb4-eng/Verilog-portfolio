# Moore FSM Traffic Light — Design Notes (timed revision)

## Purpose
Revision/cold-recall exercise: rebuild the traffic-light Moore FSM from scratch, this time
adding a real timed hold per state (the original version switched state on every clock edge,
with "add a timer" listed as a known next step — see git history / README).

## Key design decisions
- **4 always blocks instead of 3.** With a plain state machine, 3 blocks suffice (next-state
  logic, state register, output logic). Adding per-state timing needs a 4th: a `counter` register
  (its own `always_ff`) that increments every cycle and resets to 0 exactly when a state
  transition happens. The next-state `always_comb` block checks `counter` against each state's
  target hold count (RED=3, GREEN=2, YELLOW=1 as the *trigger* value, since counting starts at 0
  — e.g. RED's counter sequence `0,1,2,3` is 4 distinct cycles, so the transition condition is
  `counter==3`, not `counter==4`).
- **Counter reset condition.** The counter resets to 0 not just on `reset`, but also whenever its
  own state's hold target is reached (checked per-state: `state==RED && counter==3`, etc.) —
  otherwise a state's leftover counter value would carry into the next state and desync the
  timing.

## An Icarus-specific tooling quirk (not a design bug)
`next_state = (counter==3'd3) ? GREEN : RED;` fails to compile under Icarus Verilog (`-g2012`)
with "This assignment requires an explicit cast" when assigning a ternary of enum values to an
enum-typed variable — even though this is valid, unambiguous SystemVerilog. The fix is casting
the **entire ternary expression**, not each arm individually:
```systemverilog
// fails in Icarus:
next_state = (counter==3'd3) ? GREEN : RED;
// works (and is valid everywhere, not just a workaround):
next_state = state_t'((counter==3'd3) ? GREEN : RED);
```

## Real bugs caught while building the design and testbench
- Port declared `state` as a module **input** instead of an internal register — a Moore FSM must
  track its own state internally, not receive it from outside.
- `reg next_state;` (implicit 1-bit) instead of `state_t next_state;` — would silently truncate
  enum values.
- Missing `always_ff` for the state register entirely (only next-state logic + counter were
  written at first) — `state` was never actually updated.
- Mismatched sensitivity lists between the two `always_ff` blocks — the counter block had
  `posedge reset` (asynchronous reset), the state-register block initially didn't, which would
  desync the two on an async reset edge.
- Three `else if` branches in the state-register block that were all functionally identical
  (`state<=next_state` regardless of which named state), simplified to a single `else`.
- Enum-scalar-vs-array confusion in the testbench: `state_t [1:0] expected_state;` doesn't widen
  `state_t` (its width is already fixed by its own `typedef`) — it declares an **array** of 2
  `state_t` elements instead, which silently broke `%s`/`.name()` printing.
- `%s` applied directly to an enum variable doesn't print its name in Icarus — needs the enum's
  built-in `.name()` method (`expected_state.name()`, not bare `expected_state`, inside
  `$display`).
- `always_ff` sensitivity list missing `clk`/`reset` as module inputs; a stray `:` after
  `case(state)`.
