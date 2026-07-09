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

## Register File

The processor implements the standard RV32I register file.
| Register | Description |
| --- | --- |
| x0 | Hardwired to 0 |
| x1 | Return address |
| x2 | Stack Pointer |
| x3 - x31 | General Purpose Registers |

## Processor Architecture <br>
(Insert datapath image here.)
The processor consists of the following major modules: <br>

* Program Counter
* Instruction Memory
* Register File
* Immediate Generator
* ALU
* ALU Decoder
* Main Decoder
* Data Memory
* Branch and Jump Logic

## Instruction Flow <br> 
Each instruction passes through the following stages during a single clock cycle:

1) Fetch instruction from Instruction Memory
2) Decode instruction fields
3) Read source registers
4) Generate immediate (if required)
5) Perform ALU operation
6) Access Data Memory (Load/Store)
7) Write result back to Register File
8) Update Program Counter

## Control Unit

The control logic is divided into two independent modules.

### Main Decoder

Generates the primary control signals:

RegWrite
MemWrite
MemRead
ALUSrc
ResultSrc
Branch
Jump
ALUOp

### ALU Decoder

Uses ALUOp, funct3, and funct7 fields to determine the ALU operation.

## Immediate Generator

The Immediate Generator extracts and sign-extends immediates for all supported instruction formats.

Supported formats:

* I-Type
* S-Type
* B-Type
* U-Type
* J-Type

For branch and jump instructions, the least significant bit is appended as zero since target addresses are aligned.

## Branch and Jump Support

Implemented instructions include: <br>

BEQ   
BNE  
BLT  
BGE  
BLTU  
BGEU  
JAL  
JALR  

## License <br>
This project is licensed under the MIT License.
