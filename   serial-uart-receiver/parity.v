`timescale 1ns / 1ps

module parity(
    input clk,
    input reset,
    input data,
    output reg odd
    );

    always @ (posedge clk)
        if (reset)
            odd <= 0;
        else if (data)
            odd <= ~odd;           
            
endmodule
