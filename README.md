# 32-bit Single-Cycle RISC-V Processor (RV32I) <br>

## Overview <br>
This project implements a 32-bit single-cycle RISC-V processor in Verilog, supporting the RV32I Base Integer Instruction Set Architecture (ISA). The processor executes every instruction in a single clock cycle and follows the load-store architecture defined by the RISC-V specification.
The design is modular, with separate RTL implementations for the datapath, control unit, ALU, register file, instruction memory, data memory, and immediate generation logic.

## Features <br>
* RV32I Base Integer ISA
* 32 × 32-bit General Purpose Registers
* Single-Cycle Datapath
* Load-Store Architecture
* Branch and Jump Support
* Modular Verilog RTL Design
* Instruction and Data Memory
* Simulation Testbenches

## Processor Specifications <br>
| Features | Specification |
| --- | --- |
| ISA | RV32I |
| Architecture | Single Cycle |
| Register File | 32 X 32bits |
| Data Memory | 64 bit RAM |
| Instruction Memory | 64 bit ROM |
| Word size | 32 bits |

