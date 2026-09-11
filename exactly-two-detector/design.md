# "Exactly 2 of 3" Detector — Design Notes

## Function
Output = 1 only when exactly 2 of the 3 inputs (A, B, C) are 1.

## Truth Table

| A | B | C | Output |
|---|---|---|--------|
| 0 | 0 | 0 | 0 |
| 0 | 0 | 1 | 0 |
| 0 | 1 | 0 | 0 |
| 0 | 1 | 1 | 1 |
| 1 | 0 | 0 | 0 |
| 1 | 0 | 1 | 1 |
| 1 | 1 | 0 | 1 |
| 1 | 1 | 1 | 0 |

## SOP
Output = A'BC + AB'C + ABC'

## K-map analysis
Each of the three 1-cells is isolated (no two are adjacent, including wraparound), so no further
simplification is possible.

Important distinction learned here: this is **not** a checkerboard/XOR pattern (verified both by
checking that not every adjacent pair in the K-map alternates, and by the odd/even parity test —
this function's true-cases have an *even* count of 1s, the opposite of what a genuine XOR would
require). "Can't simplify via K-map" is a general symptom; "checkerboard/XOR" is only one possible
cause of it, not the only one.

## Circuit
3 NOT gates (for A', B', C'), 3 three-input AND gates (one per SOP term), 1 three-input OR gate
combining them. Verified by hand-tracing two test cases (A=0,B=1,C=1 -> 1; A=B=C=1 -> 0) through
a hand-drawn gate diagram.
