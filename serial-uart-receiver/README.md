# UART Receiver

## Initial design

### Goal
I would like for my FPGA to receive data from my PC by developing a UART module to enable serial communication.

### UART Background
Before writing the code, I must understand how the UART receiver module should function.

1. Two wires between transmitter and receiver to communicate in both directions.
2. Asynchronous - receiver and transmitter do not share a common signal. However, they must transmit at the same speed, and have the same frame structure and parameters.

### Design
I will design a UART with 1 start bit, 8 data bits, 1 odd parity bit, and 1 stop bit.

### Code && Testing
[uart.v](uart.v) [parity.v](parity.v)

[testbench](uart_tb.v)  [waveforms](uart_tb_waveform.md)

### Analysis
The UART module successfully receives messages.
