# Execute
<img src="https://github.com/coolnikitav/coding-lessons/assets/30304422/c8fb7e73-74b7-4dc5-8f65-19579ac40f5b" alt="image" width="425"/>

## Design and Verification
- Design: [execute.sv](execute.sv), [extension.sv](extension.sv), [alu.sv](alu.sv)
- Testbench: [execute_tb.sv](execute_tb.sv)
- Simulation output: [simulation_output.md](simulation_output.md)

## LC3 Execute Behavior
- sr1 & sr2 = source register addresses
- dr = destination register address
- VSR1 & VSR2 = values of RF[sr1] & RF[sr2] created asynchronously in Writeback
- aluout = result of alu operation (ADD, NOT, AND)
- pcout = result of pc related operation (BR, JMP, LEA)
- M_Data = contents of RegFile[SR]
- W_Control_out: reflects synchronously W_Control_in
- On reset, aluout, pcout, W_control_out, dr go to 0

## Understanding Dependencies
<img src="https://github.com/coolnikitav/coding-lessons/assets/30304422/fcbfc29f-33ee-4241-a152-a48ee547d4b2" alt="image" width="500"/>

<img src="https://github.com/coolnikitav/coding-lessons/assets/30304422/2e409569-c86f-4911-8147-80b9e67d2d11" alt="image" width="500"/>

Typically, execute block would get SR1 and SR2 values from writeback. But if there are dependencies, it will need to bypass and grab values from previous aluout or memory.

## aluout and pcout
<img src="https://github.com/coolnikitav/coding-lessons/assets/30304422/2c30ff0a-48fc-43ff-96d4-f132963f9148" alt="image" width="300"/>

