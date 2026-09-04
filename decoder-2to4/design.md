# 2-to-4 Decoder — Design Notes

## Truth Table

| A | B | Y0 | Y1 | Y2 | Y3 |
|---|---|----|----|----|----|
| 0 | 0 | 1  | 0  | 0  | 0  |
| 0 | 1 | 0  | 1  | 0  | 0  |
| 1 | 0 | 0  | 0  | 1  | 0  |
| 1 | 1 | 0  | 0  | 0  | 1  |

## Boolean Expressions

- Y0 = A'B'
- Y1 = A'B
- Y2 = AB'
- Y3 = AB

## Explanation
The 2-bit input `{a,b}` is treated as a binary index, and exactly one output line (Y0-Y3) is
driven high to match that index — all others stay low. This is implemented using concatenation:
`{a,b}` forms the case selector, and `{y3,y2,y1,y0}` is assigned a one-hot 4-bit pattern in a
single line per case.
