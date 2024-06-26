# Execute
<img src="https://github.com/coolnikitav/coding-lessons/assets/30304422/c8fb7e73-74b7-4dc5-8f65-19579ac40f5b" alt="image" width="425"/>

## Design and Verification
- Design: [execute.sv](execute.sv), [extension.sv](extension.sv), [alu.sv](alu.sv)
- Testbench: [execute_tb.sv](execute_tb.sv)
- Simulation output: [simulation_output.md](simulation_output.md)

## LC3 Execute Behavior
- sr1 & sr2 = source register addresses, dr = destination register address
- VSR1 & VSR2 = values of RF[sr1] & RF[sr2] created asynchronously in Writeback
- aluout = result of alu operation (ADD, NOT, AND), pcout = result of pc related operation (LD, LDR, LDI, LEA, ST, STR, STI, BR, JMP), M_Data = contents of RegFile[SR], which will be written to memory for stores
- On reset, synchronous outputs go to 0

## Dependencies
Example:
- A: @PC = 16'h3005, Instruction = AND R5, R4, R3 (16'h5B03)
- B: @PC = 16'h3006, Instruction = ADD R6, R5, #4 (16'h1D64)

Instruction B is dependent on instruction A. A has not written to R5 when B needs it, thus the last ALU value needs to be bypassed in. In this example, bypass_alu_1 would go high.

If instruction A was a load, a memory value would need to be bypassed in by setting bypass_mem_1 or bypass_mem_2 to 1.

## Register Control
<img src="https://github.com/coolnikitav/coding-lessons/assets/30304422/c29bb76d-553b-40bf-b330-b2329df5ea6f" alt="image" width="500"/>

## LC3 Execute Internals
<img src="https://github.com/coolnikitav/coding-lessons/assets/30304422/715c6de5-eb06-4f5f-9d1c-c8580e566d5a" alt="image" width="500"/>
