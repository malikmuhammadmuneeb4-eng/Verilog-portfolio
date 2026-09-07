# 4-bit Ripple Carry Adder — Design Notes

## Concept
Chains 4 full adders together to add two 4-bit numbers (A[3:0] and B[3:0]) plus an initial
carry-in, producing a 4-bit Sum[3:0] and a final Cout.

Each full adder handles one bit position. The carry-out of one stage becomes the carry-in of
the next — exactly like carrying over in manual addition.

```
Bit 0: FA0(A[0], B[0], Cin)     -> Sum[0], c0
Bit 1: FA1(A[1], B[1], c0)      -> Sum[1], c1
Bit 2: FA2(A[2], B[2], c1)      -> Sum[2], c2
Bit 3: FA3(A[3], B[3], c2)      -> Sum[3], Cout
```

## Worked example
A = 0011 (3), B = 0001 (1), Cin = 0

| Bit | A | B | Cin | Sum | Carry out |
|-----|---|---|-----|-----|-----------|
| 0   | 1 | 1 | 0   | 0   | 1         |
| 1   | 1 | 0 | 1   | 0   | 1         |
| 2   | 0 | 0 | 1   | 1   | 0         |
| 3   | 0 | 0 | 0   | 0   | 0         |

Result: Sum = 0100 (4), Cout = 0. Check: 3 + 1 = 4. Correct.

## Overflow handling
Since two 4-bit numbers can sum to a value needing 5 bits (max 15+15=30 = 11110), the top bit
is captured explicitly in Cout rather than being lost. E.g. 15+15+0 -> Sum=1110 (14), Cout=1,
and {Cout,Sum} = 11110 = 30, correctly recovering the full result.

## Two implementations

**1. Structural** — instantiates the existing `fulladder` module 4 times, explicitly wiring the
carry chain. This is the version that reflects real hardware architecture and is the one worth
practicing for design/verification purposes, since it teaches module hierarchy and instantiation.

**2. Behavioral** — uses the `+` operator directly (`{cout, sum} = a + b + cin;`). Functionally
identical, but hides the internal structure. Useful for quick simulation, but doesn't teach or
show the actual gate-level architecture.
