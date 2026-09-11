# 1-bit Magnitude Comparator — Design Notes

## Truth Table

| A | B | GT | EQ | LT |
|---|---|----|----|----|
| 0 | 0 | 0  | 1  | 0  |
| 0 | 1 | 0  | 0  | 1  |
| 1 | 0 | 1  | 0  | 0  |
| 1 | 1 | 0  | 1  | 0  |

## Expressions
- GT = A·B' (single minterm, already minimal)
- LT = A'·B (single minterm, already minimal)
- EQ = A'B' + AB — verified as a genuine XNOR (checkerboard confirmed both structurally, by
  checking every adjacent K-map cell alternates in both directions including wraparound, and by
  the odd/even parity test: EQ=1 exactly when the count of 1s among inputs is even)

## Gate reuse
Only 2 NOT gates needed total (one for A', one for B') since each complemented signal is used
by exactly one of GT/LT, and both are reused again inside EQ's two AND terms — no duplicate NOT
gates required.

## Verification
Built and simulated in Logisim; all 4 input combinations manually toggled and checked against
the truth table above before coding.
