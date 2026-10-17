# Mini ALU v2 — Wokwi demonstration

This is a separate C behavioral model for an interactive presentation with switches and LEDs. It does not execute or synthesize mini_alu.v, and is not a Tiny Tapeout submission package. The Verilog design and its regression tests remain the authoritative implementation.

## Setup

In a copy of the Wokwi project, add a Custom Chip named `mini-alu`, selecting C. Replace the generated `mini-alu.chip.c` and `mini-alu.chip.json` contents with the matching files here. Replace `diagram.json` with the supplied diagram, then start the simulation.

Seven switches control A0, A1, B0, B1, OP0, OP1, OP2. Left connects to GND (0); right connects to VCC (1). A1/B1 and OP2 are the most significant bits. Five LEDs display R0, R1, CARRY, BORROW, ZERO. No clock or reset is needed.

| OP2 OP1 OP0 | Operation |
| --- | --- |
| 000 | A + B |
| 001 | A AND B |
| 010 | A OR B |
| 011 | A XOR B |
| 100 | A - B |
| 101 | NOT A |
| 110 | A shifted left by one |
| 111 | A shifted right by one |

Results wrap to two bits. CARRY is only used for addition; BORROW is only used for subtraction. ZERO reflects the two-bit result. Unary operations ignore B.

## Checks before taking screenshots

- A=3, B=1, OP=0: R1/R0 off, CARRY on, BORROW off, ZERO on.
- A=0, B=1, OP=4: R1/R0 on, CARRY off, BORROW on, ZERO off.
- A=1, OP=5: result=2; OP=6: result=2; OP=7: result=0.

Status: the user loaded and ran the model in Wokwi. The saved screenshot shows the initial zero-input state with ZERO illuminated. The other checks listed above and exhaustive equivalence remain unverified. Verilog test results do not validate this separate C model.

Reference: https://docs.wokwi.com/chips-api/getting-started
