module FIFO(input clk, rst, wr, rd,
            input [7:0] din, output reg [7:0] dout,
            output empty, full);
  
  reg [3:0] wrptr = 0, rdptr = 0;
  reg [4:0] cnt = 0;
  reg [7:0] mem [15:0];
         
  always @ (posedge clk) begin
    if (rst == 1'b1) begin
      wrptr <= 0;
      rdptr <= 0;
      cnt <= 0;
    end
    else if (wr == 1'b1 && full == 1'b0) begin
      mem[wrptr] <= din;
      wrptr++;
      cnt++;
    end
    else if (rd == 1'b1 && empty == 1'b0) begin
      dout <= mem[rdptr];
      rdptr++;
      cnt--;
    end
  end
  
  assign empty = (cnt == 0) ? 1'b1 : 1'b0;
  assign full = (cnt == 16) ? 1'b1 : 1'b0;
endmodule

interface fifo_if;
  logic clk, rst, wr, rd;
  logic [7:0] din, dout;
  logic empty, full;
endinterface
