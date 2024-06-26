`timescale 1ns / 1ps

module clock_divider(
    input clk,
    input areset,
    output reg clk_div
    );
    
    reg [9:0] counter = 10'd0;
    parameter DIVISOR = 10'd325; // 100 MHz/153.6 KHz = 651, so need 325 half period
    
    always @ (posedge clk, posedge areset) begin
        if (areset) begin
            counter <= 0;
            clk_div <= 0;
        end 
        else if (counter == (DIVISOR-1)) begin
            counter <= 0;
            clk_div <= ~clk_div;
        end
        else begin
            counter <= counter + 1;
        end
     end
     
endmodule
