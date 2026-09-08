# Moore FSM — Traffic Light Controller — Design Notes

## Moore vs Mealy
- **Moore machine:** output depends only on the current state.
- **Mealy machine:** output depends on current state AND current input.

This design is a **Moore machine** — the light color is entirely determined by which state the
FSM is in, with no dependency on any additional input at that instant.

## States and encoding

| State  | Encoding | Light output |
|--------|----------|---------------|
| RED    | 2'b00    | 3'b100 (red on)   |
| GREEN  | 2'b01    | 3'b010 (green on) |
| YELLOW | 2'b10    | 3'b001 (yellow on)|

(2'b11 is unused.)

## State diagram
RED -> GREEN -> YELLOW -> RED, cycling on every clock edge (simplified version; a real traffic
light would hold each state for many cycles using a timer, not transition every single edge).

## The two-always-block FSM pattern
This is the standard, widely-used coding style for FSMs in real RTL:

1. **Sequential block** (`always @(posedge clk)`) — holds and updates the *state register*.
   Only this block should be clocked; it decides what state comes next.
2. **Combinational block** (`always @(*)`) — decodes the *current* state into the actual output
   (`light`). This must be combinational, not clocked, so the output reflects the state
   immediately rather than lagging by a cycle (which would break the Moore-machine property).

Keeping these two concerns separate (state transition vs output decoding) avoids accidental
latches and matches how synthesis tools expect FSMs to be described — this pattern is reused
for essentially every FSM in real design and verification work.

## `parameter` usage
`RED`, `GREEN`, `YELLOW` are declared with `parameter` — named constants that are purely a
readability aid (functionally identical to using the raw binary values directly, but far less
error-prone and easier to maintain).
