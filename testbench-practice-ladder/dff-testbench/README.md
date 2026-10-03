# Testbench Ladder - Step 3: D Flip-Flop

First sequential testbench in the ladder: clock generation, `@(posedge clk)`, reset behavior,
and a toggling reset-in-the-middle scenario.

**Real bugs caught:**
- Instantiation missing its instance name (`dff_simple(...)` instead of `dff_simple DS0(...)`).
- An invalid literal `0'b1` (zero-width value) instead of `1'b0`.
- `d` was declared but never assigned a value before use.
- `$finish` placed outside the `initial begin...end` block.
- A **silent, misleading bug**: `$display` printed the testbench's own input (`d`) instead of
  the DUT's actual output (`q`) - functionally correct-looking output that would have hidden a
  real DUT bug had one existed, since it wasn't actually observing the DUT.

See the [ladder overview](../design.md) for the full set of lessons across all five steps.
