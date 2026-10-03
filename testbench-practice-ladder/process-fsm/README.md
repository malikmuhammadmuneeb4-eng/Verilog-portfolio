# Testbench Ladder - Step 5: 3-State Process FSM

The most advanced drill in the ladder: a multi-stage, two-input FSM (IDLE -> RUNNING -> DONE ->
IDLE), tested with self-designed precondition checks at each stage.

See [design.md](./design.md) for the precondition-check design pattern (including a dead-code
structuring bug caught and fixed), several real bugs (mismatched `%b` format placeholders, wrong
enum case, a missing instantiation port, an unmatched `begin`/`end` pair), and — most
notably — a genuine design-vs-testbench logic bug the student caught independently, where the
expected value for the "stop" test stage contradicted the DUT's own documented transition logic.

See the [ladder overview](../design.md) for the full set of lessons across all five steps.

## Files
- `process_fsm.sv`
- `testbench.sv`
