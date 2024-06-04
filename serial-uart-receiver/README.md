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
[uart.v](https://github.com/coolnikitav/nikitas-notebook/blob/main/engineering/serial-uart/uart.v) [parity.v](https://github.com/coolnikitav/nikitas-notebook/blob/main/engineering/serial-uart/parity.v)

[testbench](https://github.com/coolnikitav/nikitas-notebook/blob/main/engineering/serial-uart/uart_tb.v)  [waveforms](https://github.com/coolnikitav/nikitas-notebook/blob/main/engineering/serial-uart/uart_tb_waveform.md)

### Analysis
The UART module successfully receives messages.

## FPGA Integration

Since the UART module is successfully receiving sample messages during testing, I will adjust it to work with my Basys 3 FPGA.

### Clock divider for Baud Rate

The Basys 3 clock is 100 MHz (10 ns period): 
```
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]
```
This UART receiver module should sample the incoming serial data at a 9600 baud rate. It is best to sample in the middle of the transmitted bit. To provide higher resolution, it will be sampled at 16 times the baud rate, or 153_600 Hz. Once a new bit is detected, the code will wait for 8 out of 16 sample ticks until it takes a measurement. Thus, a clock divider circuit is needed.

Clock divider code: [clock divider.v](https://github.com/coolnikitav/nikitas-notebook/blob/main/engineering/serial-uart-receiver/clock_divider.v)

Clock divider testbench: [clock_divider_tb.v](https://github.com/coolnikitav/nikitas-notebook/blob/main/engineering/serial-uart-receiver/clock_divider_tb.v)

After the reset is switched to 0, the simulation is run for 10_000_000 ns. During that time, clk_div goes through 1538 cycles, resulting in a frequency of 153_800 Hz.

### Adjusting UART Receiver module for FPGA ports

The [Basys-3-Master.xdc] constraints file indicates that the FPGA is receiving data through pin B18:
```
##USB-RS232 Interface
set_property -dict { PACKAGE_PIN B18   IOSTANDARD LVCMOS33 } [get_ports RsRx]
```
RsRx will be the data bit.

