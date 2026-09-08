# Digital Design & Verification Portfolio

Hi, I'm Muhammad Muneeb Malik — an Electrical Engineering graduate (Power) transitioning into
Digital Design / Hardware Verification. This repo documents my learning journey, starting from
digital logic fundamentals and building up toward SystemVerilog, UVM, and full verification
environments.

## Background
- BSc Electrical Engineering (Power), UET Lahore, 2022
- Currently self-studying: Digital Logic, Boolean Algebra, Verilog/SystemVerilog, UVM fundamentals
- Goal: Junior Verification / Hardware Design Engineer role

## Projects (in learning order)

| # | Project | Concepts Covered | Status |
|---|---------|-------------------|--------|
| 1 | [2-to-1 MUX](./mux-2to1) | Combinational logic, `assign`, `always/case` | ✅ Done |
| 2 | [2-to-4 Decoder](./decoder-2to4) | Concatenation, one-hot outputs | ✅ Done |
| 3 | [4-to-2 Priority Encoder](./priority-encoder-4to2) | `casez`, don't-cares, priority logic | ✅ Done |
| 4 | [Full Adder](./full-adder) | XOR chains, K-map analysis, gate-level design | ✅ Done |
| 5 | [4-bit Ripple Carry Adder](./ripple-adder-4bit) | Structural instantiation, module hierarchy | ✅ Done |
| 6 | [4-bit Up Counter](./counter-4bit) | Registers, synchronous counters, overflow/wraparound | ✅ Done |
| 7 | [4-bit Down Counter](./downcounter-4bit) | Underflow, 2's complement subtraction via adders | ✅ Done |
| 8 | [Moore FSM - Traffic Light](./moore-fsm-trafficlight) | Moore vs Mealy, `parameter`, two-always-block FSM pattern | ✅ Done |
| 9 | Simple ALU | Combining blocks, control logic | 🔜 Planned |
| 10 | First UVM Testbench | Verification methodology | 🔜 Planned |

## How each project is documented
Every project folder contains:
- `design.md` — the truth table and Boolean expression(s), derived by hand
- `<name>.v` — the Verilog design file
- `README.md` — a short explanation of the design and what it does

## Why this repo exists
I'm building this portfolio to demonstrate hands-on digital design ability while transitioning
from a Power Engineering background. Feedback and suggestions are welcome — feel free to open
an issue.
