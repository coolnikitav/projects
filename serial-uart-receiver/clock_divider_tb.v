`timescale 1ns / 1ps

module clock_divider_tb;

    reg clk,areset;
    wire clk_div;
    
    integer clk_counter;
    integer pos_edge_counter = 0;
    
    clock_divider clk_div0(
        .clk(clk),
        .areset(areset),
        .clk_div(clk_div)
        );
        
    initial begin
        clk = 0;
        areset = 1;
    end
    
    always #5 clk = ~clk;  // 100 MHz
    
    initial begin
        #50_000; 
        areset = 0;
        clk_counter = 0;
        #10_000_000;
        $display("clk_div cycle count : %0d", pos_edge_counter);
        $display("Frequency : %0d", pos_edge_counter*(10**9/10_000_000));
        $finish;
    end
    
    always @ (posedge clk_div)
        pos_edge_counter = pos_edge_counter + 1;
        
    always @ (posedge clk)
        clk_counter = clk_counter + 1;
    
endmodule
