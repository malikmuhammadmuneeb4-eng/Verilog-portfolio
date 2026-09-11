# 4-bit Equality Checker

Checks whether two 4-bit numbers are exactly equal, using the bitwise XNOR+AND trick: XNOR each
corresponding bit pair (1 = that bit pair matches), then AND all 4 results together (1 only if
*every* bit pair matched).

Deliberately built and compared against a nested if/else bit-by-bit version (structurally
identical in spirit to the comparator's priority logic) to demonstrate that when only equality
is needed — not also GT/LT — the flat bitwise technique is far simpler and less error-prone than
adapting the full priority-comparator structure. Both versions were verified to produce
identical, correct results; the bitwise version needs no nesting at all.
