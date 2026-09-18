# Verilog Syntax Quick Reference

## 1. Module Structure

```verilog
module module_name (
    input  wire a, b,      // inputs
    output reg  y          // outputs
);
    // body goes here
endmodule
```

## 2. Data Types

| Type | Used for | Example |
|---|---|---|
| `wire` | Signal driven by `assign` or a module output | `wire y;` |
| `reg` | Signal assigned inside `always` or `initial` | `reg y;` |
| `integer` | Loop counters, general-purpose whole numbers | `integer i;` |
| `parameter` | Named constant | `parameter RED = 2'b00;` |

**Rule:** anything assigned inside `always` or `initial` must be `reg` (or `output reg` combined). Anything assigned with plain `assign` is `wire`.

## 3. Number Literals

```verilog
4'b1010     // 4-bit binary
8'hFF       // 8-bit hex
4'd10       // 4-bit decimal
1'b0        // single bit
```
Format: `<width>'<base><value>` — base is `b` (binary), `h` (hex), `d` (decimal), `o` (octal).

## 4. Operators

| Operator | Meaning |
|---|---|
| `&` | AND |
| `\|` | OR |
| `~` | NOT |
| `^` | XOR |
| `~^` or `^~` | XNOR |
| `==` | equal to (comparison) |
| `!=` | not equal to |
| `>`, `<`, `>=`, `<=` (in expressions) | greater/less than |
| `<=` (in `always`) | non-blocking assignment |
| `=` | blocking assignment |
| `?:` | ternary: `y = sel ? a : b;` |
| `{}` | concatenation: `{a,b,c}` |

## 5. `assign` (continuous assignment — combinational only)

```verilog
assign y = a & b;
assign y = sel ? a : b;
```

## 6. `always` blocks

**Combinational** (no clock — output depends only on current inputs):
```verilog
always @(*)
begin
    y = a & b;   // use reg, blocking assignment (=)
end
```

**Sequential** (clocked — output updates only at clock edge):
```verilog
always @(posedge clk)
begin
    q <= d;      // use reg, non-blocking assignment (<=)
end
```

**Rule of thumb:** `always @(*)` + `=` for combinational logic. `always @(posedge clk)` + `<=` for sequential (registers, state machines).

## 7. `if / else`

```verilog
if (condition)
    statement;
else if (another_condition)
    statement;
else
    statement;
```

**What "statement" actually means:** it's a placeholder for any single executable line — most often
an assignment, e.g. `y = 1;` or `state <= s0;`. It can also be a nested `if`, a `case`, or a
`begin...end` block containing several statements (see below).

**What "condition" actually means — and the mistake to watch for:**
A condition must be a **comparison** or a signal being checked for truth, never a plain assignment.

| Written as | What it does | Correct here? |
|---|---|---|
| `if (i==q)` | Compares i and q — true if they're equal | ✅ Correct for a condition |
| `if (i=q)` | Assigns q's value INTO i (blocking assignment) | ❌ Wrong — this is not a comparison at all |

`=` is **assignment** (sets a value). `==` is **equality comparison** (checks if two things are
equal, returns true/false). Every `if (...)`, `else if (...)`, and `while (...)` condition needs
`==` (or `>`, `<`, `>=`, `<=`, `!=`) — never a bare `=`. Writing `if (i=q)` is a very common typo
and either causes a compile warning/error or, worse, silently does the wrong thing (assigns
instead of compares) in some contexts — always double-check for the double `==` in any condition.

**Multiple statements need `begin...end`:**
```verilog
if (condition) begin
    statement1;
    statement2;
end
else begin
    statement3;
end
```

**Nested if/else** (each `begin` closes with its own `end`, innermost last):
```verilog
if (cond1) begin
    if (cond2)
        y = 1;
    else begin
        if (cond3)
            y = 2;
        else
            y = 3;
    end
end
```

## 8. `case` statement

```verilog
case (selector)
    value1: statement;
    value2: statement;
    value3: begin
        statement1;
        statement2;
    end
    default: statement;
endcase
```

**`casez`** (same as `case`, but allows `?` as don't-care in the pattern):
```verilog
casez (input_bits)
    4'b1???: y = 1;   // matches 1xxx, any value for the ?'s
    4'b01??: y = 2;
    default: y = 0;
endcase
```

## 9. Concatenation for multi-signal assignment

```verilog
{y3,y2,y1,y0} = 4'b0001;         // assign a constant pattern
{a,b,c} = 3'b101;                 // same idea
{sum, cout} = a + b + cin;        // combine arithmetic result into two signals
wire [3:0] combined = {a,b,c,d};  // build a 4-bit bus from 4 single bits
```
Order matters: leftmost in `{}` = most significant bit.

## 10. Bit-width / buses

```verilog
input  [3:0] a;      // 4-bit bus, bits 3,2,1,0
output [7:0] y;       // 8-bit bus, bits 7..0
wire   [3:0] a, b;     // width applies to all names listed after it
```
Accessing a single bit: `a[2]`. Accessing a range: `a[3:1]`.

## 11. Module instantiation (structural design — connecting sub-modules)

```verilog
fulladder FA0 (.a(a[0]), .b(b[0]), .cin(cin), .sum(sum[0]), .cout(c0));
```
Format: `module_type instance_name ( .port_name(signal_connected_to_it), ... );`
Each instance needs a **unique** instance name. Cannot be done inside `always` — only directly in the module body.

## 12. `parameter` (named constants)

```verilog
parameter RED = 2'b00, GREEN = 2'b01, YELLOW = 2'b10;
```
Purely a readability aid — functionally identical to using the raw value directly.

## 13. `for` loop (used in testbenches; also usable in synthesizable code with limits)

```verilog
integer i;
for (i = 0; i < 8; i = i + 1) begin
    // body
end
```
Same three parts as most languages: start value; continue condition; increment.

## 14. Nested `for` loop

```verilog
integer i, j;
for (i = 0; i < 4; i = i + 1) begin
    for (j = 0; j < 4; j = j + 1) begin
        // runs 16 times total, once per (i,j) pair
    end
end
```

## 15. Testbench-only constructs

**`initial` block** — runs once, from time 0, top to bottom:
```verilog
initial begin
    a = 0; b = 0;
    #10;              // wait 10 time units
    a = 1;
    #10;
end
```
⚠️ Multiple separate `initial` blocks all start at the same time (parallel) — put a sequence of steps in ONE `initial` block.

**`$display`** — print to console:
```verilog
$display("a=%b b=%b -> y=%b", a, b, y);
```
Format specifiers: `%b` binary, `%d` decimal, `%h` hex, `%s` string, `%t` simulation time.

**`$monitor`** — like `$display`, but auto-prints every time any listed signal changes (only need to call once):
```verilog
$monitor("time=%0t a=%b b=%b y=%b", $time, a, b, y);
```

**`$finish`** — ends the simulation:
```verilog
$finish;
```

## 16. Self-checking testbench pattern

```verilog
if (actual_output == expected_value)
    $display("PASS: ...");
else
    $display("FAIL: got %b, expected %b", actual_output, expected_value);
```

## 17. Module instantiation inside a testbench (DUT = Design Under Test)

```verilog
module testbench;
    reg a, b;          // reg: testbench DRIVES these (inputs to DUT)
    wire y;             // wire: DUT DRIVES this (output from DUT) — testbench only observes

    my_design DUT (.a(a), .b(b), .y(y));   // instantiate the design being tested

    initial begin
        // test steps here
    end
endmodule
```

## Quick decision guide

| I need to... | Use |
|---|---|
| Describe pure combinational logic | `assign` or `always @(*)` |
| Describe a register/flip-flop/state machine | `always @(posedge clk)` |
| Select between values based on a code, with don't-cares | `casez` |
| Select between values based on an exact code | `case` |
| Build a bigger design from smaller pre-built modules | instantiation (never inside `always`) |
| Set several signals to a known pattern at once | concatenation `{}` |
| Give a value a readable name | `parameter` |
| Run a sequence of test steps once | `initial` |
| Repeat a test across many input combinations | `for` loop inside `initial` |
| Print/check simulation results | `$display`, `if/else` comparison |
