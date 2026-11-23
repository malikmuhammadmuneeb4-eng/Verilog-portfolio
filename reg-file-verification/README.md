# Register File — Constrained-Random Verification (SystemVerilog)

A self-checking, constrained-random verification environment built around a small register-file
DUT (8 x 8-bit registers, single write/read port, with an explicit error flag for an illegal
simultaneous write+read). Rather than another hand-written directed testbench, this project
covers the core building blocks of a real verification flow, all built from scratch: a
randomized transaction class, a reference (golden) model, a scoreboard, and functional coverage.

- **DUT (`design.sv`):** `reg_file` — `din`/`addr`/`wr`/`rd` in, `dout`/`error` out. On
  `wr=1,rd=1` simultaneously, the write is blocked and `error` is asserted instead.
- **Testbench (`testbench.sv`):**
  - `packet` class — `rand` fields (`din`, `addr`, `wr`, `rd`) with a weighted `dist` constraint
    on `{wr,rd}` so the error case gets deliberately stress-tested rather than appearing at a
    flat 25%.
  - Reference model (`update_ref` task) — a behavioral shadow copy of the register array that
    predicts the expected `dout`/`error` for every randomized transaction before the DUT
    produces a result.
  - Scoreboard (`check_result` task) — compares the DUT's actual `dout`/`error` against the
    reference model's prediction every cycle and reports any mismatch.
  - Functional coverage (`covergroup cg`) — cross-coverage of `addr` x `{wr,rd}`, confirming
    every address / operation-type combination (write, read, error, idle) was actually
    exercised by the random stimulus, not just assumed from the `dist` weighting.

## Result

255 randomized transactions, **0 mismatches**, **100% functional coverage** (all 32
address x operation-type combinations hit). Verified on Siemens Questa, including a waveform
check confirming `dout`/`error` track the reference model's predictions cycle-for-cycle.

## How to run (Questa / any SystemVerilog simulator)

```
vlog design.sv testbench.sv
vsim -voptargs=+acc tb
run -all
```

## Concepts covered

Constrained-random stimulus (`rand`, `randc`, `dist`, `inside`, `solve...before`, `soft`
constraints), reference-model/scoreboard-based self-checking, functional coverage
(`covergroup`, `coverpoint`, `cross`).

## Files

- `design.sv` — DUT
- `testbench.sv` — transaction class, reference model, scoreboard, coverage, top-level test loop
