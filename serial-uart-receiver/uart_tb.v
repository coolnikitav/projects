`timescale 1ns / 1ps

module uart_tb();

    parameter DATA_WIDTH = 8;
    
    reg clk=0,reset=0,data=0;
    wire [DATA_WIDTH-1:0] out_byte;
    wire done;
    
    uart UUT(.clk(clk),
             .data(data),
             .reset(reset),
             .out_byte(out_byte),
             .done(done)
             );
             
    always #5 clk = ~clk;  // 100 MHz
    
    initial begin
        reset = 1;
        #20;
        reset = 0;
    end
    
    initial begin
        #20;
        data = 1; #20;
        
        // Successful message (a9)
        data = 0; #10;  // start bit
        data = 1; #10;  // bit0
        data = 0; #10;  // bit1
        data = 0; #10;  // bit2
        data = 1; #10;  // bit3
        data = 0; #10;  // bit4
        data = 1; #10;  // bit5
        data = 0; #10;  // bit6
        data = 1; #10;  // bit7
        data = 1; #10;  // odd parity bit
        data = 1; #10;  // stop bit
        
        #30;
        
        // Wrong parity
        data = 0; #10;  // start bit
        data = 0; #10;  // bit0
        data = 0; #10;  // bit1
        data = 1; #10;  // bit2
        data = 1; #10;  // bit3
        data = 0; #10;  // bit4
        data = 1; #10;  // bit5
        data = 0; #10;  // bit6
        data = 1; #10;  // bit7
        data = 0; #10;  // odd parity bit
        
        #40;  // ERROR state
        data = 1;  #20 // Back to IDLE state
        
        // Wrong STOP bit
        data = 0; #10;  // start bit
        data = 1; #10;  // bit0
        data = 0; #10;  // bit1
        data = 1; #10;  // bit2
        data = 0; #10;  // bit3
        data = 0; #10;  // bit4
        data = 1; #10;  // bit5
        data = 1; #10;  // bit6
        data = 0; #10;  // bit7
        data = 1; #10;  // odd parity bit
        data = 0; #10;  // stop bit
        
        #40;  // ERROR state
        data = 1;  #20 // Back to IDLE state
        
        // Successful message again (a9)
        data = 0; #10;  // start bit
        data = 1; #10;  // bit0
        data = 0; #10;  // bit1
        data = 0; #10;  // bit2
        data = 1; #10;  // bit3
        data = 0; #10;  // bit4
        data = 1; #10;  // bit5
        data = 0; #10;  // bit6
        data = 1; #10;  // bit7
        data = 1; #10;  // odd parity bit
        data = 1; #10;  // stop bit
        
        #30;
        
        // RESET after start bit
        data = 0; #10;  // start bit
        reset = 1;  // reset
        
        #30; reset = 0;
        
        // RESET in the middle of data
        data = 0; #10;  // start bit
        data = 1; #10;  // bit0
        data = 0; #10;  // bit1
        data = 0; #10;  // bit2
        data = 1; #10;  // bit3
        data = 0; #10;  // bit4
        reset = 1;
        
        #30; reset = 0;
        
        // RESET after parity bit
        data = 0; #10;  // start bit
        data = 1; #10;  // bit0
        data = 0; #10;  // bit1
        data = 0; #10;  // bit2
        data = 1; #10;  // bit3
        data = 0; #10;  // bit4
        data = 1; #10;  // bit5
        data = 0; #10;  // bit6
        data = 1; #10;  // bit7
        data = 1; #10;  // odd parity bit
        reset = 1;
        
        #30; reset = 0;
        
        // Successful message again (a9)
        data = 0; #10;  // start bit
        data = 1; #10;  // bit0
        data = 0; #10;  // bit1
        data = 0; #10;  // bit2
        data = 1; #10;  // bit3
        data = 0; #10;  // bit4
        data = 1; #10;  // bit5
        data = 0; #10;  // bit6
        data = 1; #10;  // bit7
        data = 1; #10;  // odd parity bit
        data = 1; #10;  // stop bit
        
        #30;
        
        $finish;
    end
    
endmodule
