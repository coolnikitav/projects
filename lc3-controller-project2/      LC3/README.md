# LC3
<img src="https://github.com/coolnikitav/learning/assets/30304422/28a4dc9e-65af-4c24-a04c-d40f763849bf" alt="image" width="600"/>

### Detailed diagram:

<img src="https://github.com/coolnikitav/projects/assets/30304422/3e488864-1087-4c78-9f14-780e42288820" alt="image" width="2400"/>

## Design and Verification
- Design: [LC3.sv](LC3.sv)
- Testbench: [LC3_tb.sv](LC3_tb.sv)
- Simulation output: [simulation_output.md](simulation_output.md)

## LC3 Behavior
The LC3 interacts with an instruction memory and a data memory
- When an instruction is ready to be read, instrmem_rd is set to 1. The instruction memory return instruction at PC and indicates a successful fetch
by setting complete_instr to 1
- The LC3 needs to interact with data memory during loads and stores. Data_rd is set to 1 to write Data_din to data memory at Data_addr. Data_rd is set to 0 to read Data_dout from data memory at Data_addr.
### Startup Timing
<img src="https://github.com/coolnikitav/projects/assets/30304422/d138cbc7-c94d-4a0e-99ba-a919e69115ca" alt="image" width="650"/>

### Timing for ALU Operations
<img src="https://github.com/coolnikitav/projects/assets/30304422/284af01b-f7ff-4055-8e5a-97a421033231" alt="image" width="650"/>

### Timing for Control Operations
<img src="https://github.com/coolnikitav/projects/assets/30304422/4aa3954e-a674-4057-b09f-08aa889bf341" alt="image" width="650"/>

## Instruction Pipeline
<img src="https://github.com/coolnikitav/learning/assets/30304422/86ad7201-15b8-4469-98e5-bf6054b28570" alt="image" width="650"/>

## Instruction Operation

### ALU Instructions: (AND, ADD, NOT)
<img src="https://github.com/coolnikitav/projects/assets/30304422/31ce2376-13ea-4607-ac6e-7f0aa863777c" alt="image" width="550"/>

AND/ADD:
- Immediate: [DR] <- [SR1] +/& imm5(sign extended)
- Register: [DR] <- [SR1] +/& [SR2]

NOT: 
- [DR] <- ~[SR1]

### Memory Instructions: (LD, LDR, LDI, LEA, ST, STR, STI)
<img src="https://github.com/coolnikitav/projects/assets/30304422/75bbe4f8-71f6-4d03-8c28-972c09de867a" alt="image" width="550"/>

LD/ST (PC Relative):
- Mem_Addr = PCmem + 1 + sign-extended(PCoffset9)
- LD: [DR] <- DMem[Mem_Addr]
- ST: DMem[Mem_Addr] <- [SR]

LDR/STR (Register Relative):
- Mem_Addr = [BaseR] + sign-extended(PCoffset6)
- LDR: [DR] <- DMem[Mem_Addr]
- STR: DMem[Mem_Addr] <- [SR]

LDI/STI (Indirect):
- Mem_Addr1 = PCmem + 1 + sign-extended(PCoffset9)
- Mem_Addr = DMem[Mem_Addr1]
- LDI: [DR] <- DMem[Mem_Addr]
- STI: DMem[Mem_Addr] <- [SR]

LEA (Load Effective Address):
- Mem_Addr = PCmem + 1 + sign-extended(PCoffset9)
- [DR] <- Mem_Addr

### Control Instructions: (BR, JMP)
<img src="https://github.com/coolnikitav/projects/assets/30304422/0af9e11f-f4ad-43ee-8938-5e576cf285c6" alt="image" width="550"/>

BR:
- PCnext = PCbranch + 1 + sign-extended(PCoffset9)

JMP:
- PCnext <- [BaseR]

## Test Plan
Instruction memory:
- 3000: 5020 (R0 <- R0 & 0) AND imm
- 3001: 2C20 (R6 <- DMem[3023] == 3008): LD
- 3002: 1422 (R2 <- R0 + 2): ADD imm
- 3003: 12A1 (R1 <- R2 + 1): ADD imm with bypass_alu_1
- 3004: 5A81 (R5 <- R2 & R1): AND reg with bypass_alu_2
- 3005: C180 (JMP R6): JMP
- 3008: 967F (R3 <- ~R1): NOT
- 3009: 3600 (R3 -> DMem[300B]): ST
- 300A: 1AA5 (R5 <- R2 + 5): ADD imm
- 300B: A802 (R4 <- DMem[DMem[300F]=3011] = 0016): LDI
- 300C: 5B01 (R5 <- R4 & R1): AND reg with bypass_mem_1
- 300D: 1421 (R2 <- R0 + 1): ADD imm
- 300E: 0A04 (R4 != 0): BR to 3012  // R5 hasn't been written yet
- 3014: 12A4 (R1 <- R2 + 4): ADD imm
- 3015: EBF8 (R5 <- 300f): LEA
- 3016: 6F82 (R7 <- DMem[[R6]=300A]=300B): LDR
- 3017: 1207 (R1 <- R0 + R7): ADD reg with bypass_mem_2
- 3018: B804 (R4 -> DMem[DMem[301e]=3020]): STI 
- 3019: 7545 (R2 -> DMem[[R5]=300f] + 5]): STR

Data memory:
- 300A: 300B
- 300F: 3011
- 3011: 0016
- 301e: 3020
- 3023: 3008
