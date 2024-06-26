# LC3 Memaccess
<img src="https://github.com/coolnikitav/learning/assets/30304422/deb5902e-6924-4fef-bef7-3ba75cf778c4" alt="image" width="400"/>

## Design and Verification
- Design: [memaccess.sv](memaccess.sv)
- Testbench: [memaccess_tb.sv](memaccess_tb.sv)
- Simulation output: [simulation_output.md](simulation_output.md)

## LC3 Memaccess Behavior
<img src="https://github.com/coolnikitav/projects/assets/30304422/740fe6d6-7873-4ed4-9d7d-c3725583b6b5" alt="image" width="450"/>

When
- mem_state = 0 (reading memory for loads) DMem_addr = M_addr for LDR, LD and DMem_dout for LDI (prev value read in is used as address), DMem_din = 0
- mem_state = 2 (writing memory for stores) DMem_addr = M_addr for STR, ST and DMem_dout for STI (prev value read in is used as address), DMem_din = M_data;
- mem_state = 1 (reading from memory for indirect addressing) DMem_addr = M_addr, DMem_din = 0
- mem_state = 3, DMem_rd = z, DMem_dout = z, DMem_addr = z

DMem_rd = 0 for writes and 1 for reads.
