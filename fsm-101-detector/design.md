# Overlapping "101" Sequence Detector — Design Notes

## Status: Complete — design, Boolean derivation, and Verilog all verified.

## Machine type: Mealy, not Moore
A sequence detector's "just detected" signal depends on the *current input bit* combined with
*how much of the pattern was already matched* — a Mealy machine can flag detection in the same
cycle the deciding bit arrives, whereas a Moore machine would need an extra dedicated state for
"just completed" and would report detection one cycle later. Chose Mealy for immediate output
timing.

## States
- `s0` (2'b00) — no progress / mismatch reset point
- `s1` (2'b01) — matched a single leading "1"
- `s2` (2'b10) — matched "1,0" (one bit away from completing the pattern)
- `s3` (2'b11) — just completed "1,0,1" (reached the cycle after detection)

## Transition table

| Current state | Input | Next state | Output (Mealy) |
|----------------|-------|------------|--------|
| s0 | 0 | s0 | 0 |
| s0 | 1 | s1 | 0 |
| s1 | 0 | s2 | 0 |
| s1 | 1 | s1 | 0 |
| s2 | 0 | s0 | 0 |
| s2 | 1 | s3 | 1 |
| s3 | 0 | s2 | 0 |
| s3 | 1 | s1 | 0 |

Note this uses 4 states rather than the more commonly taught 3-state minimal version — it adds a
distinct state for "just detected" (s3) separate from "mid-pattern progress" (s2). This is a
valid alternative design choice: confirmed functionally equivalent to a standard 3-state
overlapping detector via exhaustive Python simulation against every possible input sequence up
to 8 bits long (zero mismatches), and via hand-tracing `1,0,1,0,1`, which correctly detects
twice.

## Boolean equation derivation (bit-level, Q1 Q0 = state encoding)

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

Derived using the standard method throughout: find every row where the target output is 1,
write one AND term per row (using the complement of a variable where it's 0 in that row), OR
all the terms together, then simplify with K-map grouping where possible.

**NQ1** — unsimplified SOP: Q1'Q0X' + Q1Q0'X + Q1Q0X'. K-map grouping: Q1'Q0X' and Q1Q0X' differ
in only Q1, so they combine into Q0X'; the remaining term Q1Q0'X differs from both by more than
one variable and stays separate.
**Simplified: NQ1 = Q0X' + Q1Q0'X** — cross-verified two independent ways (algebraic factoring
and K-map grouping both arrived at the same result) and confirmed against all 8 truth-table rows.

**NQ0** — unsimplified SOP: Q1'Q0'X + Q1'Q0X + Q1Q0'X + Q1Q0X. Factoring out X and applying the
complement law (Q0'+Q0=1, then Q1'+Q1=1) collapses this all the way down to a single variable.
**Simplified: NQ0 = X** — i.e. the next value of Q0 is always just the current input bit,
regardless of state.

**Z** — only one row has Z=1: (Q1=1, Q0=0, X=1). Since this is a single minterm, no
simplification is needed or possible.
**Z = Q1·Q0'·X**

Notable finding: Z is identical to one of the two terms inside NQ1's expression, meaning that
same AND-gate output could be reused for both signals in a gate-level implementation.

### Lessons learned during derivation
- A K-map grouping mistake was caught mid-derivation: two terms were grouped that actually
  differed in *two* variables (not one), producing an expression that failed 2 of 8 test rows
  when checked. Fixed by explicitly comparing each variable between candidate terms one at a
  time before accepting any grouping — never group just because two terms "look similar."
- Two proposed expressions for Z were checked and rejected (`Q1Q0+X`, `Q1Q0'+X`) before landing
  on the correct single-minterm form — both wrongly included an extra OR'd term when the truth
  table only had one row where Z=1, meaning the correct expression needed exactly one AND term,
  nothing more.

## Verilog implementation
Built using the conventional two-always-block FSM pattern (state register clocked on
`posedge clk`, output logic combinational `always @(*)`), using named `parameter` states and
nested if/else per state rather than the raw gate-level equations above — more readable and
maintainable for a state machine of this size.

### A real Mealy-vs-Moore timing bug caught during verification
An early version computed `z` based on `state==s3` (checking if the FSM had *already* transitioned
into the "detected" state). This produces the right value once observed after a clock edge, but
is actually **Moore-style timing** — it defeats the entire reason Mealy was chosen, since it
reports detection one cycle late rather than immediately. Caught by simulating a "mid-cycle"
check: sampling `z` right when `x` changes but *before* the next clock edge. The buggy version
showed `z=0` at that instant (wrong); the corrected version, checking `state==s2 && x==1` (the
condition *while still in the pre-detection state*, per the truth table), correctly showed `z=1`
immediately, matching true Mealy behavior.

## Verification
- Design exhaustively simulated in Python against a brute-force overlapping-"101" reference
  across all input sequences up to 8 bits — zero mismatches.
- Boolean equations verified against all 8 truth-table rows via Python.
- Final Verilog compiled with Icarus Verilog and its Mealy output logic verified directly against
  all 8 (state, input) combinations from the truth table — exact match, including the
  mid-cycle (pre-clock-edge) timing check confirming true Mealy (not Moore) behavior.
