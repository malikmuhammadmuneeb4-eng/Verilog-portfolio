# Arrays / Memory & Register File

First hands-on practice with SystemVerilog arrays (`logic [N-1:0] mem [0:M-1]`), building up from
a basic single-port RAM to a CPU-style register file with two simultaneous read ports - the core
storage building block needed for a future simple RISC-V processor.

- **`simple_memory`** — single address, synchronous write / combinational read
- **`register_file`** — separate write address plus two independent read addresses
  (`read_addr1`, `read_addr2`), motivated by needing two operands at once for instructions like
  `R5 = R1 + R2`

See [design.md](./design.md) for the full reasoning behind address width (`log2(locations)`),
why write and read addresses must be independent, a clarified misconception (the register file
never performs arithmetic - that's the ALU's job, wired in separately), and why addressed reads
are used instead of exposing an entire memory as one wide output.

## Verification
Both compiled with Icarus Verilog; self-checking testbenches confirmed correct write/read-back,
write-protection when disabled, and realistic simultaneous dual-read / independent-write CPU
access patterns (8/8 total assertions passed).

## Files
- `memory_and_regfile.sv` — both `simple_memory` and `register_file`
