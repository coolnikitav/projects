# Execute
![image](https://github.com/coolnikitav/coding-lessons/assets/30304422/c8fb7e73-74b7-4dc5-8f65-19579ac40f5b)

## Design and Verification
- Design: [execute.sv](execute.sv), [extension.sv](extension.sv), [alu.sv](alu.sv)
- Testbench: [execute_tb.sv](execute_tb.sv)
- Simulation output: [simulation_output.md](simulation_output.md)

## Understanding Dependencies
![image](https://github.com/coolnikitav/coding-lessons/assets/30304422/fcbfc29f-33ee-4241-a152-a48ee547d4b2)

![image](https://github.com/coolnikitav/coding-lessons/assets/30304422/2e409569-c86f-4911-8147-80b9e67d2d11)

Typically, execute block would get SR1 and SR2 values from writeback. But if there are dependencies, it will need to bypass and grab values from previous aluout or memory.

## aluout and pcout
![image](https://github.com/coolnikitav/coding-lessons/assets/30304422/2c30ff0a-48fc-43ff-96d4-f132963f9148)

