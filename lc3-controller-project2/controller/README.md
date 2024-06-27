# LC3 Controller
<img src="https://github.com/coolnikitav/learning/assets/30304422/bef42f9f-6492-4fa8-a03a-e05b792df75a" alt="image" width="450"/>

## Design and Verification
- Design: [controller.sv](controller.sv)
- Testbench: [controller_tb.sv](controller_tb.sv)
- Simulation output: [simulation_output.md](simulation-output.md)

## LC3 Controller Behavior
- On reset all enables and bypass signals go to 0 but mem_state = 3

### br_taken
The br_taken is created for the control instructions using the logic br_taken = |(psr & NZP). NZP comes from the Execute block and psr comes from the Writeback block.

### Bypassing for stores
To allow bypassing for SR and BaseR, the following mapping is used:
- sr1 = IR[8:6] = BaseR (valid for STR only)
- sr2 = IR[11:9] SR (valid for all stores)

For reference, store instructions:

<img src="https://github.com/coolnikitav/projects/assets/30304422/89b6318d-6679-4358-abae-c81220fabf96" alt="image" width="500"/>

### Behavior for Control Operations
A control operation (BR/JMP) is detected by analyzing Instr_dout signal from the instruction memory. The instruction is sent through the pipeline while nothing is fetched/decoded/executed until th eresult of the execute
unit provides the requisite NZP and PCnext value to make a decision on whether the branch is take or not.

### Behavior for Memory Operations (except LEA)
Memory operations are detected at the output of the Execute block by analyzing the IR_Exec signal (LEA is treated as an ALU type of instruction). The entire pipeline is then stalled by making all enables move down to
zero until the memory read or write is complete.
