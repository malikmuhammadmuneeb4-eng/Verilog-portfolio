# 4-to-2 Priority Encoder — Design Notes

## Priority Rule
i3 = highest priority, then i2, then i1, then i0 (lowest).

## Priority Table (X = don't care)

| i3 | i2 | i1 | i0 | a | b | valid |
|----|----|----|----|---|---|-------|
| 1  | X  | X  | X  | 1 | 1 | 1     |
| 0  | 1  | X  | X  | 1 | 0 | 1     |
| 0  | 0  | 1  | X  | 0 | 1 | 1     |
| 0  | 0  | 0  | 1  | 0 | 0 | 1     |
| 0  | 0  | 0  | 0  | 0 | 0 | 0     |

## Explanation
Unlike a plain encoder (which assumes only one input is active at a time), a priority encoder
correctly handles multiple simultaneous active inputs by always encoding for the highest-priority
one, ignoring lower-priority inputs. `casez` with `?` wildcards implements this directly: case
items are checked top to bottom, so listing the highest-priority pattern first naturally gives
it priority over the rest.

The `valid` output distinguishes "no input active" (encodes 000) from "i0 active" (also would
otherwise encode as 00) — without `valid`, these two cases would be indistinguishable.
