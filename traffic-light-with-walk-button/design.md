# Traffic Light with Pedestrian Walk Button — Design Notes

## Concept
Extends the earlier Moore traffic light FSM (RED -> GREEN -> YELLOW -> RED, cycling
automatically) with a `walk_button` input and a new `walk_signal` output, without changing the
automatic cycling behavior at all.

## Key design insight: mixed Moore and Mealy outputs on the SAME FSM

A single FSM can have multiple outputs, and different outputs can independently be Moore-style
or Mealy-style — this is not an all-or-nothing property of the whole machine, but a property of
each individual output:

- **State transitions** (RED->GREEN->YELLOW->RED): completely unchanged, automatic, and do not
  reference `walk_button` at all.
- **`light` output** (red/green/yellow): still Moore — depends only on current `state`, exactly
  as in the original design.
- **`walk_signal` output**: genuinely Mealy — its condition directly references both the current
  state AND the current input (`state==RED && walk_button==1`), so it can fire immediately, in
  the same cycle the button is pressed, without waiting for a state change.

## Spec
`walk_signal=1` only when the current state is RED (cars stopped) AND `walk_button=1`. Pressing
the button during GREEN or YELLOW has no effect (unsafe to walk, and does not alter the light
cycle in any way).

## Verification
Compiled with Icarus Verilog and tested with a self-checking testbench confirming:
- Normal automatic cycling (RED->GREEN->YELLOW->RED) is completely unaffected by the button,
  even when held down through an entire GREEN cycle
- `walk_signal` stays 0 during GREEN even with the button held (correct — unsafe to walk)
- `walk_signal` fires immediately during RED when the button is pressed (correct Mealy timing)
- `walk_signal` stays 0 during RED if the button is not pressed

10/10 test assertions passed.
