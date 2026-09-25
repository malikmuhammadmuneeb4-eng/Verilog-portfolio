# SystemVerilog Basics — Practice Notes

## Purpose
First hands-on practice converting existing Verilog designs (MUX, Decoder, Priority Encoder) to
SystemVerilog syntax, focused purely on the language-level differences rather than new design
concepts — all three designs were already built and verified in plain Verilog earlier in this
repo.

## Key SystemVerilog differences learned

| Verilog | SystemVerilog | Notes |
|---|---|---|
| `reg` / `wire` (choose based on context) | `logic` | Works for both driven-by-assign and driven-by-always signals in most cases |
| `always @(posedge clk)` | `always_ff @(posedge clk)` | Explicitly marks sequential intent |
| `always @(*)` | `always_comb` | No sensitivity list needed at all — SystemVerilog infers it automatically; writing `always_comb @(*)` together is invalid |

## Tooling note
Icarus Verilog compiles SystemVerilog with the `-g2012` flag (enables SystemVerilog-2012
language features). Files use the `.sv` extension.

## A real corrected misconception: `casez` wildcards

While converting the priority encoder, `X`/`x` was used as the don't-care character inside
`casez` patterns (e.g. `4'bXXX1`), based on earlier (incorrect) guidance in this learning
journey that `casez` treats both `x` and `?` as wildcards.

**This was verified — and found to be wrong — by actually compiling and simulating both
versions side by side:**
- `casez` with `X`/`x` patterns: does NOT match as a wildcard; only matches if the compared
  signal is also literally unknown (`x`), which real 0/1 signals never are. Result: no case
  branch matches, and with no `default`, the output stays undefined (`x`).
- `casez` with `?` patterns: correctly matches any value (0 or 1) in that bit position, exactly
  as intended for a priority encoder's don't-care positions.

**Corrected rule:** in `casez`, only `z` and `?` in the case item act as don't-care wildcards.
`x`/`X` is a literal "unknown" value, not a wildcard — this holds in both plain Verilog and
SystemVerilog compilation modes (confirmed identical behavior in both via `iverilog` with and
without `-g2012`).

This is a good example of the core verification mindset: verify a claim by actually running it,
rather than trusting it — even when the claim came from earlier "confirmed" guidance in this same
learning journey.

## Also learned: missing `default` in a `casez`/`case`
Without a `default` branch, an input combination that matches no case item leaves the output
undefined (a form of unintended latch/undefined-value behavior) — the priority encoder now
includes an explicit `default: {y0,y1}=2'b00;` for the "no input active" case.
