# Testbench Ladder - Step 5: 3-State Process FSM - Design Notes

## The DUT
A 3-state FSM (IDLE -> RUNNING -> DONE -> IDLE) driven by two independent inputs (`start`,
`stop`), the most input-dependent and multi-stage design in the ladder.

## Design pattern: precondition checks
Rather than assuming the DUT is in a specific state before driving an input meant to transition
it, each stage first checks the *current* state and branches accordingly (proceed with the
intended test / flag that a precondition wasn't met / flag a genuinely unexpected state). This
was the student's own idea, independently proposed as a way to make the testbench robust against
silently testing the wrong thing if the DUT were ever in an unexpected state.

**A real structuring bug caught along the way:** an early attempt wrote the precondition as
`if (state != IDLE) ... else if (state == RUNNING) ...`, which is dead code - once the first
branch's negated condition is known false, `state` is already known to equal `IDLE`, so it can
never simultaneously equal `RUNNING` in the `else if`. Restructured to a positive-first check
(`if (state==IDLE) ... else if (state==RUNNING) ... else ...`), making every branch reachable.

## Real bugs caught while building this
- `$display` format strings with more `%b` placeholders than arguments supplied (silently prints
  garbage/misaligned values rather than erroring).
- Enum value referenced in the wrong case (`running` instead of `RUNNING`) - caught via a real
  compiler elaboration error ("Unable to bind wire/reg/memory `running`").
- Module instantiation missing the `state` port connection entirely - left the testbench's
  `state` signal permanently floating/unknown (`x`), with no compile error, only a confusing
  all-`x` runtime result that had to be traced back to the instantiation line.
- An unmatched `begin`/`end` pair (8 `begin`s but only 7 `end`s), causing a syntax error reported
  at the very last line of the file (`endmodule`) rather than anywhere near the actual missing
  `end` - diagnosed by counting `begin`/`end` occurrences directly rather than guessing.
- **A genuine design-vs-testbench logic bug, caught by the student independently**: the stop-test
  stage set `expected_state=RUNNING` after driving `stop=1`, but the DUT's own logic
  (`RUNNING: if (stop) state <= DONE;`) means asserting `stop` while `RUNNING` should transition
  to `DONE`, not stay at `RUNNING` - the expected value contradicted the very design being tested
  for the condition being exercised. Fixed to `expected_state=DONE`.

## Verification
Final version compiled and run via EDA Playground: all 4 stages (reset, start, stop, auto-return
to IDLE from DONE) passed.
