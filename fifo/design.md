# Synchronous FIFO — Design Notes (SystemVerilog revision)

## Purpose
Revision/cold-recall exercise: rebuild a synchronous FIFO from scratch (design + testbench,
no reference code) to check retention of the full/empty-ambiguity problem, pointer arithmetic,
and clocked-logic assignment discipline, months after first learning the topic.

## Key design decisions

- **Full/empty detection — counter vs extra-bit pointers.** The classic alternative to a counter
  is widening `read_ptr`/`write_ptr` by one extra bit so pointer *comparison itself* (including
  the extra "lap" bit) distinguishes full from empty, with no separate counter. This design
  started down that path, then recognized that once a `counter` register already exists and
  already drives `full`/`empty` directly (`counter==depth` / `counter==0`), the extra pointer bit
  is redundant — `read_ptr`/`write_ptr` only need the minimum bits to address `mem` (2 bits for a
  depth-4 FIFO). Picking one approach (not both) avoids an array-size/pointer-width mismatch.
- **Pointer wraparound is free.** `write_ptr <= write_ptr + 1;` on a fixed-width 2-bit register
  needs no explicit `if (write_ptr==3) write_ptr<=0;` — incrementing `2'b11` overflows and the
  extra bit is simply discarded by the assignment, landing back on `2'b00`. This is a general
  property of fixed-width unsigned arithmetic, not FIFO-specific.
- **Simultaneous read+write.** A first attempt used a plain `if/else if/else if` chain for
  reset/write/read, which made write and read mutually exclusive — only one could happen per
  cycle. Rewritten so the *combined* (`write_en && !full && read_en && !empty`) case is checked
  **first** (an `else if` chain earlier in the list intercepts the combined case otherwise,
  since the write-only condition alone is also true whenever both are asserted), with the
  individual write-only/read-only cases checked after. When both happen, `counter` must stay
  unchanged — not `+1` in one statement and `-1` in another, since two non-blocking assignments
  to the same signal in one `always_ff` resolve to whichever is written **last** in program order
  (overwrite, not addition), not a net cancel-out.

## Real bugs caught while building the design
- `mem [4:0]` (5 locations) instead of `[3:0]` (4) — an off-by-one in the array-size declaration,
  the same class of mistake as the earlier `regs[255:0]` "255 vs 256 drawers" discussion.
- Mixed blocking (`=`) and non-blocking (`<=`) assignments inside the same `always_ff` block —
  inconsistent, should be `<=` throughout for clocked/sequential logic.
- `empty!=0` instead of `empty==0` as the read-enable guard — backwards: as written, it only
  allowed a read *while the FIFO was empty*, and blocked reads whenever it wasn't.
- Simultaneous-read+write branch: missing `if` keyword after `else`, `begin` placed before the
  condition instead of after it, and a missing `end` — three separate syntax slips while adding
  the combined-case branch.
- A testbench "failure" that was actually correct DUT behavior: testing simultaneous read+write
  starting from an *empty* FIFO expected `data_out` to immediately reflect the just-written value
  and `empty` to stay `1` — but the combined-case guard (`empty==0`) correctly blocks reading from
  an empty FIFO, so only the write happened and `data_out` held its previous value. Fixed by
  testing the simultaneous case from a partially-filled FIFO instead.
