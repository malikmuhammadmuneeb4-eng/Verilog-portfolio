# Full Adder — Design Notes

## Truth Table

| A | B | Cin | Sum | Cout |
|---|---|-----|-----|------|
| 0 | 0 | 0   | 0   | 0    |
| 0 | 0 | 1   | 1   | 0    |
| 0 | 1 | 0   | 1   | 0    |
| 0 | 1 | 1   | 0   | 1    |
| 1 | 0 | 0   | 1   | 0    |
| 1 | 0 | 1   | 0   | 1    |
| 1 | 1 | 0   | 0   | 1    |
| 1 | 1 | 1   | 1   | 1    |

## SOP Expressions (unsimplified)

- Sum = A'B'Cin + A'BCin' + AB'Cin' + ABCin
- Cout = A'BCin + AB'Cin + ABCin' + ABCin

## K-map Observations

**Sum** forms a checkerboard pattern on the K-map — every 1-cell is isolated, with no adjacent
1s in any direction. This is the signature of a pure XOR function, so no further K-map
simplification is possible; it's recognized directly as:

**Sum = A ⊕ B ⊕ Cin**

Verified via the odd/even parity check: Sum=1 exactly when the number of 1s among (A,B,Cin)
is odd (1 or 3), confirming this is a genuine 3-input XOR, not a coincidental checkerboard shape.

**Cout** groups cleanly into 3 overlapping pairs on the K-map, simplifying to the "majority
function" (1 whenever at least 2 of the 3 inputs are 1):

**Cout = AB + ACin + BCin**

## Circuit
Can be built two equivalent ways:
1. Two XOR gates (chained) for Sum + three AND gates and one OR gate for Cout (direct from
   the equations above)
2. Two half adders + one OR gate (Sum = HA2 output, Cout = OR of both half adders' carry outputs)
