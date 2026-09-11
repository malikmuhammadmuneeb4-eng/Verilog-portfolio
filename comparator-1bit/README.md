# 1-bit Magnitude Comparator

Compares two single bits and outputs GT, EQ, LT flags. Designed and verified independently
(truth table -> per-output SOP -> gate reuse analysis -> built and simulated in Logisim across
all 4 cases -> two independent Verilog implementations).

- **Inputs:** `a`, `b`
- **Outputs:** `lt`, `gt`, `eq`

See [design.md](./design.md) for the full derivation, including confirming EQ is a genuine XNOR
function via two independent checks (K-map adjacency + odd/even parity).

## Files
- `comparator.v` — two equivalent Verilog implementations (boolean-expression style and
  case/concatenation style)
