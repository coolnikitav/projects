# Decode
<img src="https://github.com/coolnikitav/coding-lessons/assets/30304422/eb24dfa4-efc0-4286-adaa-a5ea079033f1" alt="image" width="375"/>

### Design and Verification
- Design: [decode.sv](decode.sv), [control_decode.sv](control_decode.sv)
- Testbench: [decode_tb.sv](decode_tb.sv)
- Reference model: [e_w_control_pkg.sv](e_w_control_pkg.sv)
- Simulation output: [simulation-output.md](simulation-output.md)

## LC3 Decode Behavior
- On reset, all outputs go to logic 0
- npc_out is equal to npc_in (passing to execute unit)
- enable_decode is the master enable
- IMem_dout = IMem[PC] = IR

### W_Control
W_Control signal is a function of IR[15:12]:

<img src="https://github.com/coolnikitav/coding-lessons/assets/30304422/40a2bb9c-5580-4b2b-824f-1b5f7e2f35ba" alt="image" width="250"/>

### E_Control
E_Control signal is the concatenation of {alu_control, pcselect1, pcselect2, op2select}:

<img src="https://github.com/coolnikitav/coding-lessons/assets/30304422/43c910b6-5b4e-4633-b671-152e67ca83c5" alt="image" width="550"/>

For example, if IR[15:12] decodes to ADD and IR[5] = 0, then E_Control = 6'b000001.

### Mem_Control
Mem_Controls let's us know whether we are trying to write or read to memory:

<img src="https://github.com/coolnikitav/projects/assets/30304422/059d6b46-7240-42d5-a547-c48370937a7d" alt="image" width="250"/>

## LC3 Decode Internals
<img src="https://github.com/coolnikitav/coding-lessons/assets/30304422/3fb97ea6-a669-485c-819b-0f3335a9b292" alt="image" width="500"/>
