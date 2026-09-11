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
| 9 | [Exactly-2-of-3 Detector](./exactly-two-detector) | Independent design practice, K-map judgment calls | ✅ Done |
| 10 | [1-bit Comparator](./comparator-1bit) | Independent design, built & verified in Logisim | ✅ Done |
| 11 | [4-to-1 MUX drill](./mux-4to1-drill) | Coding fluency drill | ✅ Done |
| 12 | [1-to-4 DEMUX](./demux-1to4) | Coding fluency drill, caught a real logic bug | ✅ Done |
| 13 | [4-to-2 Encoder drill](./encoder-4to2-drill) | Coding fluency drill | ✅ Done |
| 14 | [3-to-8 Decoder](./decoder-3to8) | Coding fluency drill, scaling up pattern | ✅ Done |
| 15 | [4-bit-wide 2-to-1 MUX](./mux-4bit-2to1) | Multi-bit bus signals | ✅ Done |
| 16 | [4-bit Comparator](./comparator-4bit) | Priority logic, structural vs behavioral, compiler-verified | ✅ Done |
| 17 | [4-bit Equality Checker](./equality-checker-4bit) | Bitwise XNOR technique vs nested if/else | ✅ Done |
| 18 | [1-bit ALU](./alu-1bit) | MUX-based design, discriminating test-case verification | ✅ Done |
| 19 | [Overlapping "101" Detector (FSM)](./fsm-101-detector) | Mealy FSM, boolean equation derivation from truth table | 🔜 In progress |
| 20 | First UVM Testbench | Verification methodology | 🔜 Planned |

## How each project is documented
Every project folder contains:
- `design.md` — the truth table and Boolean expression(s), derived by hand
- `<name>.v` — the Verilog design file
- `README.md` — a short explanation of the design and what it does

Several of the later projects (comparator-4bit, alu-1bit) were also compiled and exhaustively
tested with Icarus Verilog self-checking testbenches, not just manually reviewed.

## Why this repo exists
I'm building this portfolio to demonstrate hands-on digital design ability while transitioning
from a Power Engineering background. Feedback and suggestions are welcome — feel free to open
an issue.
