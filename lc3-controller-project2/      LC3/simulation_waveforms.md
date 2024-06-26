## Startup Timing
### Expected (the specs indicate that all enables go to 0 on reset, but the provided waveform contradicts that):
<img src="https://github.com/coolnikitav/projects/assets/30304422/60027659-7d48-4a1d-b8c7-0cd67654d588" alt="image" width="550"/>

### Actual (I made my enables go to 0 on reset):
<img src="https://github.com/coolnikitav/projects/assets/30304422/f81dbb84-b911-4e07-8706-d8799c08c951" alt="image" width="550"/>

## Timing for Control Instructions
### Expected:
<img src="https://github.com/coolnikitav/projects/assets/30304422/fbc453fb-9f2d-443d-a716-c84bbb3a644d" alt="image" width="650"/>

### Actual:
<img src="https://github.com/coolnikitav/projects/assets/30304422/e129036d-8891-4695-8a52-472e3e78a65b" alt="image" width="650"/>

## Timing for Memory Instructions
### Expected:
<img src="https://github.com/coolnikitav/projects/assets/30304422/74b3ddbf-866a-4176-a43e-d143f8a7ccee)" alt="image" width="700"/>

### Actual:
<img src="https://github.com/coolnikitav/projects/assets/30304422/b19ab58b-70e1-40ec-ad4d-d9887d8b3cb9" alt="image" width="700"/>

## Bypassing (click to expand)
<img src="https://github.com/coolnikitav/projects/assets/30304422/961c8e37-4929-4f27-a66d-06d9691dcd2a" alt="image" width="2000"/>

## Complete Waveform (click to expand)
<img src="https://github.com/coolnikitav/projects/assets/30304422/da78b491-6216-4d51-ac28-6b93ef44ba1c" alt="image" width="2000"/>

- 3000: 5020 (R0 <- R0 & 0) AND imm
- 3001: 2C20 (R6 <- DMem[3023] == 3008): LD
- 3002: 1422 (R2 <- R0 + 2): ADD imm
- 3003: 12A1 (R1 <- R2 + 1): ADD imm with bypass_alu_1
- 3004: 5A81 (R5 <- R2 & R1): AND reg with bypass_alu_2
- 3005: C180 (JMP R6): JMP
- 3008: 967F (R3 <- ~R1): NOT with bypass_alu_2
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
