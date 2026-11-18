# RISC-V Processor on FPGA

32-bit RISC-V processor written in Verilog, in two microarchitectures: single-cycle and 5-stage pipeline. Developed for the Computer Architecture course at Universidad Industrial de Santander (UIS) and targeted at Digilent Artix-7 boards (Basys 3 / Nexys 4 DDR).

## Designs

| | Single-cycle | Pipeline |
|---|---|---|
| Stages | Fetch, decode, execute, memory and write-back in one cycle | IF, ID, EX, MEM, WB with pipeline registers |
| Hazards | Not applicable | Data forwarding (EX/MEM and MEM/WB) and load-use stall |
| Control flow | Branch and jump resolved in the same cycle | Branch resolved in EX, with IF/ID and ID/EX flush |

## Supported instructions

- **R-type:** `add`, `sub`, `and`, `or`, `xor`, `sll`, `srl`, `sra`, `slt`
- **I-type:** immediate arithmetic and logic, `lw`
- **S-type:** `sw`
- **B-type:** `beq`
- **U/J-type:** `lui`, `jal`

The pipeline decoder also covers `jalr` and additional branch conditions.

## Architecture

- Instruction memory: 16 words, built from four byte-wide memories and initialized in source
- Data memory: 32 words, synchronous write
- Register file: 32 × 32-bit
- ALU with zero and comparison flags, driven by a two-level decoder (main decoder and ALU decoder)

## Repository structure

```
single_cycle/   Verilog sources, testbench and constraints
pipeline/       Verilog sources, hazard unit and testbench
basys3_top/     Top-level wrapper for the Basys 3 board
```

## Running it

**Simulation.** Open the project in Vivado (developed with 2025.1), set the testbench as the simulation top (`tb_main` for single-cycle, `tbmain` for pipeline) and run a behavioral simulation. Both generate a `.vcd` waveform.

**On the board.** In the Basys 3 wrapper (`conex`), `BTNC` acts as reset and the lower 16 bits of the write-back result are shown on the LEDs. Synthesize, implement and program the bitstream from Vivado.

## Tools

Verilog · Vivado · Vivado Simulator (xsim) · Basys 3 (Artix-7 XC7A35T)

## Author

Daniel Morelos — Electronic Engineering, Universidad Industrial de Santander
