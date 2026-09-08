# 4-bit Down Counter — Design Notes

## Concept
Mirror image of the up counter: decrements by 1 each clock edge, resets to `1111` (max value,
since counting down conventionally starts from the top) instead of `0000`.

## Underflow / wraparound
`0000 - 1` wraps to `1111` — the 4-bit equivalent of an odometer rolling from `000000` back to
`999999` when going in reverse past zero. This mirrors the up counter's overflow behavior.

## Connection to 2's complement subtraction
Decrementing is really just `count + (2's complement of 1)`. Since 2's complement of 1 (in
4 bits) is `1111`, `count - 1` and `count + 1111` produce identical hardware results — this is
exactly why a single adder can be reused for both addition and subtraction in a real ALU, by
conditionally complementing one operand.
