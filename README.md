
# 16-bit MIPS (Microprocessor Without Interlocked Pipleline Stages)
This repository is Verilog description of a 16 bit MIPS processor. There are eight main blocks:
- Execution Block
- Program Memory Block
- Register Bank Block
- Data Memory Block
- Writeback Block
- Jump Control Block
- Stall Control Block
- Dependency Check Block

The repository contains test bench for every block, as well as for main modules (debug_1.v and debug_2.v).

Complete block diagram:
![block_diagram](https://github.com/PrayagS/MIPS_16bit/blob/master/block_diagram.png?raw=true)

## Instructions supported
| Code | Description |
| ------ | -------- |
| ADD | Addition |
| SUB | Subtraction |
| MUL | Multiplication using Booth's algorithm |
| MOV | Move |
| AND | Logical |
| OR | Logical |
| XOR | Logical |
| NOT | Logical |
| ADI | Add with one immediate value |
| SBI | Subtract with one immediate value |
| MVI | Move immediate value |
| ANI | Logical with one immediate value |
| ORI | Logical with one immediate value |
| XRI | Logical with one immediate value |
| NTI | Logical with one immediate value |
| RET | Return from an interrupt |
| HLT | Halt |
| LD | Load from data memory |
| ST | Store to data memory |
| IN | Take serial data in |
| OUT | Give serial data out |
| JMP | Unconditional jump |
| LS | Left shift |
| RS | Right shift |
| RSA | Right shift arithmetic |
| JV | Jump if overflow |
| JNV | Jump if not overflow |
| JZ | Jump if zero |
| JNZ | Jump if not zero |

## Floating-point operations (Work in progress)
floating_point.v contains code for performing floating point addition. Numbers are represented using IEEE-754 standard. The code works so far only for addition of positive numbers.

## Cache: Direct mapping scheme
We use the following scheme:
![cache_structure](https://github.com/PrayagS/MIPS_16bit/blob/master/cache_structure.png?raw=true) 

Following is the block diagram of the implementation:
![cache_diagram](https://github.com/PrayagS/MIPS_16bit/blob/master/cache_diagram.png?raw=true)

## Regarding memory blocks
The project was made in Xilinx ISE 14.7. 'Program Memory' and 'Data Memory' blocks use modules called 'PMem' and 'DMem' respectively which were essentially Xilinx memory blocks generated using IPCore. 

