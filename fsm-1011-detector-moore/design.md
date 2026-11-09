# "1011" Sequence Detector — Design Notes (Moore)

## Purpose
A second FSM revision exercise, deliberately built as **Moore** (output depends only on current
state) rather than Mealy, as a direct contrast with the existing `fsm-101-detector` (which is
Mealy, for a different target pattern "101"). Detects "1011" with overlap allowed.

## State/transition table
| State | Meaning | x=0 | x=1 |
|---|---|---|---|
| s0 | nothing matched | s0 | s1 |
| s1 | "1" matched | s2 | s1 |
| s2 | "10" matched | s0 | s3 |
| s3 | "101" matched | s2 | s4 |
| s4 | "1011" matched (output=1) | s2 | s1 |

`y = 1` iff `state == s4` — a pure function of state, no dependence on `x`, which is what makes
this a Moore machine rather than Mealy.

## The overlap subtlety (s3's `x==0` transition)
The one non-obvious transition is `s3` on `x==0`. Naively it might seem s3 should fall back to
`s0` (reset) or stay at `s3`, but neither is correct: after "101" + a `0`, the trailing sequence
is "1010", whose **last two bits** ("10") already match the first two characters of the target
pattern "1011" — so the correct next state is `s2` ("10" matched), not `s0` or `s3`. Missing this
(an early draft had `s3` stay at `s3` on `x==0`) would under-count overlapping matches.

## Real bugs caught while building the design
- **Moore-vs-Mealy output contradiction.** After explicitly stating the Moore definition
  ("output depends only on current state"), the first output-logic draft was
  `if (state==s3 && x==1) y=1;` — depending on the *current input* `x`, which is Mealy behavior,
  contradicting the stated design choice. Fixed to `if (state==s4) y=1;` — state alone.
- The `s3`, `x==0` transition bug described above (`s3` instead of `s2`).
- Reserved-keyword collisions: tried to name a module output port `output` and reference an
  input as `input` — both are SystemVerilog keywords, not usable as identifiers.
- `typedef enum [3:0] {...} state_t;` — missing the base-type keyword (`logic`) before the
  packed-dimension range; `enum [3:0] {...}` alone is a syntax error, needs
  `enum logic [3:0] {...}`.
- The same Icarus ternary-with-enum cast quirk as the traffic-light FSM (see that module's
  design notes) — fixed by casting the whole ternary expression:
  `next_state = state_t'((x==1) ? s1 : s0);`.
- `module` and `always_ff` declared without the `clk`/`reset` ports actually present in the port
  list on an earlier draft; a stray `:` after `case(state)`.
