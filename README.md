A RISC-V CPU has 40 instructions.
Remember, the control unit here also has branch and opcode control signals.
The ALU control you see below is the ALU decoder and the other signals are handled in the main decoder.
<img width="1250" height="760" alt="image" src="https://github.com/user-attachments/assets/030be80d-3113-4ff5-b65c-2f571840aecd" />

funct3 (3 bits) = operation group: tells the ALU (and decoder) which operation
- funct3 values are fixed by the RISC-V specification.
- Each funct3 code ALWAYS corresponds to the same arithmetic/logic operation.
- Your alu_decoder MUST follow this exact mapping.
-       3'b000 → ADD/SUB
        3'b001 → SLL
        3'b010 → SLT
        3'b011 → SLTU
        3'b100 → XOR
        3'B101 → SRA/ SRL
        3'b110 → OR
        3'b111 → AND


funct7 (7 bits) = operation variant: further refines OR differentiates between similar operations- ONLY present in R type instructions

imm = literal constant value

<img width="1190" height="436" alt="image" src="https://github.com/user-attachments/assets/a4cf4d98-ffc7-4f52-807a-f2356908986e" />

R-type (Register-Register): For register-to-register operations (e.g., add, sub). Uses rs1, rs2 for sources, rd for destination, plus function fields.

I-type (Immediate/Load): For instructions with a short immediate value or memory loads (e.g., addi, lw). Uses rs1, rd, and a 12-bit immediate.

S-type (Store): For memory store operations (e.g., sw). Uses rs1, rs2, and a 12-bit immediate, but the immediate is split across fields.

B-type (Branch): For conditional branches (e.g., beq, bne). Uses rs1, rs2, and a signed 12-bit immediate offset, PC-relative.

U-type (Upper Immediate): For loading 20-bit immediate values into the upper part of a register (e.g., lui, auipc).

J-type (Jump): For unconditional jumps (e.g., jal). Uses rd, ra, and a 20-bit immediate offset


IMMEDIATE GENERATION
- Here, the MSB (sign bit) is repeated x times to fill in the empty gaps on the left side of the already present immediate bits.
- Because RISC-V branch and jump targets are 2-byte aligned, so we append a 0 at the end of immediate value for both these instruction types.
- Branch target address = PC + (imm << 1) [same for JAL]
