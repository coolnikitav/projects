`timescale 1ns / 1ps

module uart
    #(parameter DATA_WIDTH = 8)
    
    (input clk,
     input data,
     input reset,
     output [DATA_WIDTH-1:0] out_byte,
     output done
     );
     
     parameter IDLE=0,START=1,DATA=2,PARITY=3,STOP=4,ERROR=5;
     reg [2:0] state,next_state;
     
     reg [7:0] out_byte_reg;
     
     wire parity_bit_reg;  // Odd parity
     parity p0(clk,state!=DATA && state!=PARITY,data,parity_bit_reg);
     
     always @ (*)
        case (state)
            IDLE: next_state = (!data) ? START : IDLE;
            START: next_state = DATA;
            DATA: next_state = (count == 3'd7) ? PARITY : DATA;
            PARITY: next_state = data ? STOP : ERROR;
            STOP: next_state = (!data) ? START : IDLE;
            ERROR: next_state = data ? IDLE : ERROR;
        endcase
        
     reg [2:0] count = 0;   // will need to be adjusted if DATA_WIDTH changes
     
     always @ (posedge clk)
        if (state == DATA)
            count <= count + 1;
        else
            count <= 0;
     
    always @ (posedge clk)
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
            
    always @ (posedge clk)
        if (next_state == DATA) begin
            out_byte_reg[0] <= out_byte_reg[1];
            out_byte_reg[1] <= out_byte_reg[2];
            out_byte_reg[2] <= out_byte_reg[3];
            out_byte_reg[3] <= out_byte_reg[4];
            out_byte_reg[4] <= out_byte_reg[5];
            out_byte_reg[5] <= out_byte_reg[6];
            out_byte_reg[6] <= out_byte_reg[7];
            out_byte_reg[7] <= data;
        end   
            
     // parity_bit_reg will be 1 after data and parity bits.
     assign done = (state == STOP && parity_bit_reg);    
     assign out_byte = done ? out_byte_reg : 8'b0;
     
endmodule
