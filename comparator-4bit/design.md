# 4-bit Comparator — Design Notes

## Two implementations, deliberately contrasted

**Behavioral** — uses Verilog's built-in `>`, `<`, `==` operators directly on the 4-bit buses.
Simple, one line per output.

**Structural/priority-based** — mirrors real hardware comparator architecture: compares from the
most significant bit (bit 3) downward. If a bit differs, that immediately decides the result
(higher-significance bits always override lower ones); only on a tie does the logic fall through
to check the next bit down. This is the same "priority" principle as a priority encoder — first
match wins, ties defer to the next level.

Traced by hand: A=1001 (9), B=1010 (10). Bits 3 and 2 tie (both 1,0 respectively); bit 1 decides
it (a[1]=0 < b[1]=1), so LT=1 is set and bit 0 is never even examined — correctly mirroring how
real priority/comparator hardware short-circuits once a deciding bit is found.

## Verification
Both versions compiled with Icarus Verilog and exhaustively tested against all 256 possible
(a,b) combinations with a self-checking testbench comparing against Verilog's native `<`, `>`,
`==` as the reference — zero mismatches on the structural version.

## A real bug caught by the compiler
Declaring `output LT,GT,EQ;` and then separately `reg LT,GT,EQ;` causes a genuine compile error
("already declared... as a net") since it redeclares the same signals with conflicting types.
Fixed by combining into a single `output reg LT, GT, EQ;` declaration — the cleaner, less
error-prone modern style.

## A real nesting bug caught along the way
Early attempts placed `end` immediately after an `else if` branch's action, which incorrectly
closed the block before the following `else` — breaking the if/else chain. Correct pattern: each
`begin` block's matching `end` goes at the very end of everything it contains (including nested
sub-blocks), closing innermost-first, only once all nested content is written out.
