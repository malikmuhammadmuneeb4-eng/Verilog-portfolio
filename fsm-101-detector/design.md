# Overlapping "101" Sequence Detector — Design Notes (in progress)

## Status
Design fully derived and exhaustively verified in simulation. Boolean equation derivation for
the next-state/output logic started but not yet finished (paused mid-derivation of NQ0 and Z).
Verilog coding not yet started. Picking this up in the next session.

## Machine type: Mealy, not Moore
Initially assumed Moore ("output depends only on state"), but on reflection this doesn't fit a
sequence detector well: whether a match completes depends on the *current input bit* combined
with *how much of the pattern was already matched* — a Mealy machine can flag detection in the
same cycle the deciding bit arrives, whereas a Moore machine would need an extra dedicated state
for "just completed" and would report detection one cycle later. Chose Mealy for immediate
output timing.

## States (self-defined encoding)
- `00` — no progress / mismatch reset point
- `01` — matched a single leading "1"
- `10` — matched "1,0" (one bit away from completing the pattern)
- `11` — just completed "1,0,1" (detected!)

## Transition table

| Current state | Input | Next state | Output |
|----------------|-------|------------|--------|
| 00 | 0 | 00 | 0 |
| 00 | 1 | 01 | 0 |
| 01 | 0 | 10 | 0 |
| 01 | 1 | 01 | 0 |
| 10 | 0 | 00 | 0 |
| 10 | 1 | 11 | 1 |
| 11 | 0 | 10 | 0 |
| 11 | 1 | 01 | 0 |

Note this uses 4 states rather than the more commonly taught 3-state minimal version — it adds a
distinct state for "just detected" separate from "mid-pattern progress." This is a valid
alternative design choice (not a mistake): confirmed functionally equivalent to a standard
3-state overlapping detector via exhaustive simulation (see below), just with different internal
state bookkeeping.

## Truth table (bit-level, Q1 Q0 = current state encoding)

| Q1 | Q0 | X | Q1' | Q0' | Z |
|----|----|---|----|----|---|
| 0 | 0 | 0 | 0 | 0 | 0 |
| 0 | 0 | 1 | 0 | 1 | 0 |
| 0 | 1 | 0 | 1 | 0 | 0 |
| 0 | 1 | 1 | 0 | 1 | 0 |
| 1 | 0 | 0 | 0 | 0 | 0 |
| 1 | 0 | 1 | 1 | 1 | 1 |
| 1 | 1 | 0 | 1 | 0 | 0 |
| 1 | 1 | 1 | 0 | 1 | 0 |

## Verification
Simulated in Python against a brute-force reference overlapping-"101"-detector across every
possible input sequence up to 8 bits long — zero mismatches. Also hand-traced and confirmed
against the specific example `1,0,1,0,1`, which correctly detects twice (at the first "1,0,1"
and again reusing the trailing "0,1" as the start of a new match), exactly matching the
overlapping-detection requirement.

## Equation derivation (in progress)

**NQ1** — derived and verified:
Unsimplified SOP: NQ1 = Q1'Q0X' + Q1Q0'X + Q1Q0X'
(using ' for NOT here since this file predates settling on clearer notation)

K-map grouping: the pair Q1'Q0X' and Q1Q0X' differ in only one variable (Q1), and group into
Q0X'. The remaining term Q1Q0'X differs from both in more than one variable and cannot be
grouped further.

**Simplified: NQ1 = Q0X' + Q1Q0'X**

Verified by exhaustive check against all 8 truth table rows — no mismatches.

**Important lesson learned during this derivation:** an initial simplification attempt
incorrectly grouped two terms that actually differed in *two* variables (not one), producing an
expression that failed on 2 of the 8 rows. Lesson: always verify a proposed K-map grouping by
explicitly comparing each variable between the two terms one at a time, confirming exactly one
differs, before accepting the simplification — don't group terms just because they "look similar."

**NQ0 and Z** — not yet derived. To do next session.
