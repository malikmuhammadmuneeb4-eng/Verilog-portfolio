# Priority Encoder Testbench — Design Notes

## Purpose
Rebuilding testbench fundamentals from scratch after realizing they were weak going into a mock
interview — starting from module instantiation itself (what a port connection `.port(signal)`
actually means), then a full self-checking, loop-based testbench for the priority encoder.

## Instantiation, clarified
`module_type instance_name (.port_name(your_signal), ...)` connects the *design's* fixed port
names (left side of each pair, never renamed) to *your own* signal names (right side). Once
connected, both sides are electrically the same node — changing the driving signal is reflected
instantly on the design's internal port, with no extra code needed. Confirmed by tracing through
a MUX instantiation example before writing any testbench.

## Testbench module declaration: two valid forms
Both `module testbench;` (no parentheses at all) and `module testbench();` (empty parentheses)
are valid SystemVerilog and behave identically - a testbench is a top-level module with no
ports, so the port list is either omitted entirely or left empty. Confirmed by compiling both
forms - this was specifically checked against an existing, already-uploaded testbench in this
repo (full-adder-testbench) which uses the no-parentheses form, rather than assuming.

## `reg`/`wire` roles in a testbench (recap)
Signals the testbench drives into the DUT (inputs) are `reg` (or `logic`); signals the DUT drives
out (outputs) are `wire` (or `logic`) - the opposite of the roles those types play inside a design.

## Exhaustive, self-checking testbench pattern (the reusable template built here)
```systemverilog
for (i=0; i<16; i=i+1) begin
    {i0,i1,i2,i3} = i;
    #10;
    // compute expected_a, expected_b independently, using plain if/else-if
    // (NOT casez - that belongs in the design, not the testbench)
    if (a==expected_a && b==expected_b)
        $display("PASS: ...");
    else
        $display("FAIL: ...");
end
```

Key discipline: the testbench re-derives the expected output using its own independent logic
(here, a priority if/else-if chain mirroring the encoder's priority order) rather than reusing
the DUT's own `casez` - an independent expected-value calculation is what actually catches bugs;
copying the DUT's own logic into the testbench would just agree with itself even if both were
wrong the same way.

A neat technique used for the expected-value assignment: `{expected_a,expected_b} = 2'b11;`
(concatenation) sets both bits in one statement, avoiding the need for `begin...end` around a
single-statement `if` branch.

## Real bugs caught while building this, entirely independently by the student
- Missing `begin...end` around a two-statement `if` branch
- `i3=0` (assignment) instead of `i3==0` (comparison) inside a condition
- A copy-paste bug where the `else` (FAIL) branch's `$display` string still said "PASS" instead
  of "FAIL" - caught before running, by proofreading against the branch's actual meaning

## Verification — run independently, outside any AI tool, specifically to build interview-ready
## self-sufficiency
Compiled and run locally with Icarus Verilog + VS Code (no AI assistance for the compile/run
step itself, deliberately, since an interview setting won't have that available). Two real
command-line mistakes were hit and self-diagnosed: a typo in a filename passed to `iverilog`
(confirmed via `dir` rather than guessing), and literal `< >` placeholder brackets mistakenly
included from an example instruction rather than being replaced with an actual filename.

All 16 exhaustive test cases passed.
