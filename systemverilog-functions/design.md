# SystemVerilog `function` — Practice Notes

## Purpose
First hands-on practice with SystemVerilog `function` constructs: reusable combinational
calculations that can be called like an expression, rather than repeating logic inline.

## Key syntax learned

```systemverilog
function <return_type> function_name(input <type> param1, param2, ...);
    function_name = <expression or if/else logic that assigns to the function's own name>;
endfunction
```

- The return value is produced by assigning to the **function's own name** inside its body
  (not a `return` statement, and never to some other declared signal name).
- Inside the body, ordinary `if/else`, nested `if/else`, and `begin...end` blocks all work
  exactly as they do in `always` blocks — a real, tested misconception ("functions can't use
  if/else") was checked and found to be false.
- Always use blocking assignment (`=`) inside a function, matching combinational-logic
  convention — never `<=`.
- The return type must match the actual width/type of value being produced (e.g. a 3-bit
  concatenated result needs `logic [2:0]`, not plain 1-bit `logic`).
- Called exactly like an expression: `result = function_name(actual_arg1, actual_arg2);` — the
  actual argument names at the call site do not need to match the function's own parameter
  names; only the **order** and **type/width** matter.

## Where a function lives
Three options, in order of typical use:
1. **Inside the module that uses it** (used here) — simplest, right choice when the function is
   only needed by one module.
2. **At the top of a file, outside any module** — same idea as declaring `typedef enum` outside
   a module so it can be used in a port list; useful when a few modules in the same file need it.
3. **Inside a `package`, imported where needed** — the right choice once a function is genuinely
   shared across multiple files/modules.

## Two functions built and verified

**`is_equal`** — bitwise XNOR+AND equality check (rebuilt from the earlier 4-bit equality
checker), as a first simple function with a 1-bit return type. Exhaustively tested: 0 mismatches
across all 256 (a,b) combinations.

**`comparator`** — the full 4-bit priority-based (MSB-first) comparator, rebuilt as a function
returning a 3-bit `{LT,GT,EQ}`-style value from its own name. Required correcting two real
mistakes: initially tried assigning to undeclared `{LT,GT,EQ}` signals instead of the function's
own name, and had the wrong (1-bit) return type before widening it to `logic [2:0]`. Exhaustively
tested: 0 mismatches across all 256 combinations.

## Applied to the XYZ lock FSM
The `next_state_logic` function (see [xyz-sequence-lock-fsm](../xyz-sequence-lock-fsm)) applies
this same pattern to encapsulate an entire FSM's next-state decision tree, called from a single
line inside `always_ff` — confirmed to produce identical behavior to the inline version.
