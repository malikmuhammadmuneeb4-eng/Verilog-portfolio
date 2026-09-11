# 1-bit ALU — Design Notes

## Concept
Recognized independently as a MUX-based structure: four parallel operation blocks (AND, OR,
XOR, NOT) all computed simultaneously, with a 4-to-1 MUX selecting which result becomes the
final output, based on `sel[1:0]`.

| sel | Operation |
|-----|-----------|
| 00  | a AND b   |
| 01  | a OR b    |
| 10  | a XOR b   |
| 11  | NOT a (b ignored) |

## Verification methodology
Built and simulated in CircuitVerse. Verified using *discriminating* test cases — deliberately
chosen so each operation's output differs from what the other three operations would produce for
the same inputs, rather than relying on cases where multiple operations coincidentally agree
(which would not actually prove the MUX select logic is wired correctly). E.g. sel=10 (XOR) was
tested with a=1,b=1, where XOR=0 but AND=OR=1 and NOT=0 — a case that specifically distinguishes
"XOR correctly selected" from "NOT accidentally selected instead."

All four operations confirmed individually correct via this method before coding.
