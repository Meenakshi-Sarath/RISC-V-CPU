A RISC-V CPU has 40 instructions.
<img width="1250" height="760" alt="image" src="https://github.com/user-attachments/assets/030be80d-3113-4ff5-b65c-2f571840aecd" />

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
