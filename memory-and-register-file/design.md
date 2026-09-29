# Arrays / Memory & Register File — Design Notes

## Concept: SystemVerilog arrays for memory

```systemverilog
logic [N-1:0] mem [0:15];
```

`mem` is a full array of 16 locations, each N bits wide - like a cupboard with 16 drawers.
`addr` is just a number identifying *which* drawer to access; `mem[addr]` reaches into the
array at that specific index. Address width follows `log2(number of locations)` - 16 locations
needs 4 address bits, since 2^4=16 exactly matches, confirmed by working through the reasoning
independently (and generalizing correctly to log2(32)=5 for a hypothetical 32-location memory).

Confirmed via direct simulation that `logic [N-1:0] mem [0:15];` and `logic [N-1:0] mem [15:0];`
(ascending vs descending array declaration order) are both valid and behave identically when
accessed via `mem[addr]` - purely a style/convention difference, not a functional one.

## `simple_memory` module
Single read/write address, synchronous write (`always_ff`), combinational/asynchronous read
(`always_comb`) - the standard "async read, sync write" pattern for basic single-port RAM.

Clarified through discussion: the `always_ff` write block runs on *every* clock edge for the
life of the simulation/hardware - it doesn't "consume" a couple of writes and stop. On each edge
it checks `write_enable` fresh; if high, it commits whatever `write_addr`/`write_data` currently
are, if low, that edge is simply skipped (the register/memory location holds).

## `register_file` module
Extends the single-port memory concept to a CPU-style register file: one write port, but
**two independent, simultaneous read ports** (`read_addr1`/`read_addr2` -> `read_data1`/
`read_data2`), motivated by needing to read two operands at once for an instruction like
`R5 = R1 + R2`.

Key distinction worked through: `write_addr` is independent of both read addresses, since a
real instruction's source registers (read) and destination register (write) are frequently
different (e.g. `R5 = R1 + R2` reads R1 and R2 but writes an unrelated register R5). An early
attempt mistakenly named the read-address ports `write_addr1`/`write_addr2`, which was itself
the source of confusion about "why are there 3 write addresses?" - renamed to `read_addr1`/
`read_addr2` once the naming (not the logic) was identified as the actual problem.

**Important clarification worked through:** the register file only stores and retrieves values -
it never performs arithmetic. Reading R1 and R2 simultaneously does not mean they get added; that
requires routing `read_data1`/`read_data2` into a separate ALU module's inputs, and then writing
the ALU's output back via `write_data`/`write_addr`. This wiring (register file -> ALU -> back to
register file) is the natural next step, planned for the Computer Architecture module.

**Also discussed:** why the register file exposes only two addressed read ports rather than all
8 locations simultaneously as one wide output - real memories can have thousands of locations,
and exposing all of them as separate output wires would require an impractically large pin/wire
count; addressed reads let the same small number of output wires "point at" any location on
demand.

## Verification
Both modules compiled with Icarus Verilog and tested with self-checking testbenches.
`simple_memory`: write/read-back at multiple locations, confirmed `write_enable=0` prevents
overwrite (4/4 assertions passed). `register_file`: simulated realistic CPU-style access
patterns - reading two different registers at once, both read ports pointing at the same
register, and reading two registers while a write to a third unrelated register happens in the
same cycle (confirming reads and writes to different addresses don't interfere) (4/4 assertions
passed).
