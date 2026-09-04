# 2-to-1 Multiplexer — Design Notes

## Truth Table

| S | Output Y |
|---|----------|
| 0 | I0       |
| 1 | I1       |

## Boolean Expression

Y = S'·I0 + S·I1

## Explanation
The select line `s` chooses which of the two data inputs (`i0` or `i1`) is passed through to
the output `y`. When `s=0`, the term `S'·I0` is active and passes `i0` through. When `s=1`, the
term `S·I1` is active and passes `i1` through.
