# 16B FIFO Memory Buffer Design + Verification

## Design
I have designed a FIFO memory buffer, capable of holding 16 8-bit elements. It supports read and write modes.

The FIFO utilizes a pointer-based system to manage its internal storage.

Code: [fifo.v](https://github.com/coolnikitav/nikitas-notebook/blob/main/engineering/fifo/fifo.v)

## Verification
The testbench goes through a comprehensive verification process. Utilizing components like generator, driver, monitor, scoreboard, and environment, the testbench is scalable.

It does 100 runs and checks whether the output is expected.

Code: [fifo_tb.sv](https://github.com/coolnikitav/nikitas-notebook/blob/main/engineering/fifo/fifo_tb.sv)

The output from the testbench can be seen here: [verification-output](https://github.com/coolnikitav/nikitas-notebook/blob/main/engineering/fifo/verification-output.md).
