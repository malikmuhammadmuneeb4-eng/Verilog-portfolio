# 4-bit-wide 2-to-1 MUX

Extends the single-bit 2-to-1 MUX pattern to full 4-bit buses (`a[3:0]`, `b[3:0]` -> `y[3:0]`),
selected by a single-bit `s`. Confirms the same select-logic pattern applies unchanged when
signals become multi-bit — Verilog handles the bus-width assignment automatically.
