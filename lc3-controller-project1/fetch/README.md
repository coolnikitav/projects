# LC3 Fetch
![image](https://github.com/coolnikitav/coding-lessons/assets/30304422/ededf866-5fda-4685-9657-f4175535e364)

### Design and Verification
- Design: [fetch.v](https://github.com/coolnikitav/nikitas-notebook/blob/main/engineering/lc3-controller-project1/fetch/fetch.v)
- Testbench: [fetch_tb.sv](https://github.com/coolnikitav/nikitas-notebook/blob/main/engineering/lc3-controller-project1/fetch/fetch_tb.sv)
- Simulation output: [simulation-output.md](https://github.com/coolnikitav/nikitas-notebook/blob/main/engineering/lc3-controller-project1/fetch/simulation-output.md)

### LC3 Fetch Behavior:
- On reset: pc = 3000, npc = 3001
- If br_taken = 1, PC = taddr, else PC = PC+1
- PC, npc, update only when enable_updatePC = 1
- If enable_fetch = 1, then set Imem_rd = 1 asynchronously else Imem_rd = Z (High impedance)

### LC3 Fetch Internals
![image](https://github.com/coolnikitav/coding-lessons/assets/30304422/db861a19-5a0b-416b-8353-7dfb2a9304eb)
