# 1-to-4 Demultiplexer (coding drill)

Routes a single data input `d` to one of four outputs based on select lines `s1,s0`; all other
outputs stay 0.

## A real bug caught and fixed here
First attempt hardcoded the selected output to a constant `1` (copying the decoder's one-hot
pattern), which silently produces wrong results whenever `d=0` — the selected output would be
forced to 1 regardless of the actual data value. This compiles fine and looks structurally
correct, but is a genuine logic bug (as opposed to a syntax error), since it passes casual
inspection but fails on real data. Fixed by using concatenation to place the actual `d` signal
(not a hardcoded constant) into the selected output position, e.g.
`{y0,y1,y2,y3} = {d,1'b0,1'b0,1'b0};`
