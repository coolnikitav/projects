# Writeback
![image](https://github.com/coolnikitav/learning/assets/30304422/8d64e478-994c-4b83-aa88-33a59d0f672b)

## Design and Verification
- Design: [writeback.sv](writeback.sv), [reg_file.v](reg_file.sv)
- Testbench: [writeback_tb.sv](writeback_tb.sv)
- Simulation output: [simulation-output.md](simulation_output.md)

## LC3 Writeback Behavior
- Writes either aluout, pcout or memout based on W_Control value. This project only addresses aluout and pcout operations
- Synchronous writes to RF with dr: RegFile[dr] = DR_in
- Asynchronous reads from RF usign sr1 & sr2

## PSR
The psr register is encoded based on the value being written to the register file and follows the encoding psr[2] = 1 for negative values, psr[1] = 1 for values equal to 0 and psr[0] = 1 for positive values.

## RegFile
<img src="https://github.com/coolnikitav/coding-lessons/assets/30304422/571263a9-298d-4e3d-8583-f816980c0bf8" alt="image" width="325"/>

## LC3 Writeback Internals
<img src="https://github.com/coolnikitav/projects/assets/30304422/745b60d7-eeb2-435f-90b7-3e3eaff50d48" alt="image" width="550"/>
