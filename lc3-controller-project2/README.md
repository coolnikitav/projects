# LC-3 Project 2: Pipelined LC3 Microcontroller With A Comprehensive Instruction Set

## Description
This project is inspired by NC State's ECE 745 course: ASIC Verification. The second part of the course is designing and verifying a full LC-3 controller.

LC-3 is a computer architecture with the following characteristics:
- 16-bit architecture
- Fixed instruction length
- 15 instructions: ADD, AND, NOT, LD, LDR, LDI, LEA, ST, STR, STI, BR, JMP
- 8 general purpose registers
- Supports pipelining and bypassing. Addresses control and data dependencies
- Instructions take between 4 and 7 cycles
- Interacts with instruction and data memories

## Modules
This LC3 Microcontroller consists of 6 modules: Fetch, Decode, Execute, Memaccess, Writeback, Controller. Modules were designed and verified individually. Then they were combined into a main LC3 module and it was verified that all 5 stages of the pipeline worked cohesively. 

Each of the folders has specifications, intended module behavior, schematics, design files, testbench files, and simulation outputs:
- [LC3](LC3) - Combines the 6 modules into a full pipelined processor
- [Controller](controller)
- [Fetch](fetch)
- [Decode](decode)
- [Execute](execute)
- [Memaccess](memaccess)
- [Writeback](writeback)
  
## Skills
- Design and testbench files were written in SystemVerilog.
- Testbenches utilized the following:
  - UVM
  - Function coverage: transaction, sequence, sequencer, driver, monitor, scoreboard, agent, environment, test
  - Random stimulus
- Understanding of a processor pipeline, control and data dependencies, bypassing, and uniprocessor architecture.
## Challenges
