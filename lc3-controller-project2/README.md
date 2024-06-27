# LC-3 Project 2: Pipelined LC3 Microcontroller With A Comprehensive Instruction Set

## Description
This project is inspired by NC State's ECE 745 course: ASIC Verification. The second part of the course is designing and verifying a full LC-3 controller.

LC-3 is a computer architecture with the following characteristics:
- 15 instructions: ADD, AND, NOT, LD, LDR, LDI, LEA, ST, STR, STI, BR, JMP
- Supports pipelining and bypassing. Addresses control and data dependencies
- Instructions take between 4 and 7 cycles
- Interacts with instruction and data memories
- 16-bit architecture
- Fixed instruction length
- 8 general purpose registers

## Modules
This LC3 Microcontroller consists of 6 modules: Fetch, Decode, Execute, Memaccess, Writeback, Controller. Modules were designed and verified individually. Then they were combined into a main LC3 module and it was verified that all stages of the pipeline worked cohesively. 

Each of the folders has specifications, intended module behavior, schematics, design files, testbench files, and simulation outputs:
- [LC3](%20%20%20%20%20%20LC3) - Combines the 6 modules into a full pipelined processor. **Examine this module first, then proceed to the rest.**
- [Fetch](%20%20%20%20%20fetch)
- [Decode](%20%20%20%20decode)
- [Execute](%20%20%20execute)
- [Memaccess](%20%20memaccess)
- [Writeback](%20writeback)
- [Controller](controller)
  
## Skills
- Design and testbench files were written in SystemVerilog.
- Testbenches utilized the following:
  - UVM
  - Function coverage: transaction, sequence, sequencer, driver, monitor, scoreboard, agent, environment, test
  - Random stimulus
- Understanding of a processor pipeline, control and data dependencies, bypassing, and uniprocessor architecture.
  
## Challenges
- Could not get a sequence library to work. Created a method to randomly execute sequences.
- It was very difficult to get the correct timing for the enable signals because I used always blocks triggered on posedge clk. Learned that always blocks triggered on specific inputs activate a clock edge earlier, allowing to implement all enable signals according to specs.
- Unclear sections/contradicting information in the specification document. I created my own specifications based on my knowledge of computer architecture.
