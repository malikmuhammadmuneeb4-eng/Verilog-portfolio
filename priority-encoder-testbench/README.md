# Priority Encoder Testbench

Rebuilt testbench fundamentals from scratch (starting from module instantiation itself) after
identifying this as a weak area during mock interview prep. Culminates in a full,
exhaustive, self-checking testbench for the priority encoder.

- **DUT:** `priority_encoder` (i0-i3 in, a/b priority-encoded out)
- **Testbench:** loops through all 16 input combinations, independently computes the expected
  output via its own if/else-if priority chain, and reports PASS/FAIL per case

See [design.md](./design.md) for the instantiation fundamentals worked through first, the two
valid testbench module declaration forms, the reusable exhaustive-testing template, and several
real bugs (both SystemVerilog and command-line) caught and self-diagnosed along the way.

## Verification
Compiled and run **locally, without AI assistance for the compile/run step itself** — Icarus
Verilog + VS Code, deliberately practiced this way to build interview-ready self-sufficiency.
All 16 exhaustive test cases passed.

## Files
- `priority_encoder.sv`
- `testbench_priority_encoder.sv`
