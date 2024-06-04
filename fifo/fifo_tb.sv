///////////////////////////////

class transaction;  // stores variables used throughout the verification process
  rand bit op;
  bit wr, rd;
  bit [7:0] din, dout;
  bit empty, full;
  
  constraint op_cntrl {
    op dist {[0:1] :/ 100}; 
  }
endclass

///////////////////////////////

class generator;  // generates random stimulus
  transaction trans;
  mailbox #(transaction) mbx;  // gen -> drv
  
  event next;
  event done;
  
  int count = 0;
  int i = 0;
  
  function new (mailbox #(transaction) mbx);
    this.mbx = mbx;
    trans = new();
  endfunction
  
  task run();
    repeat(count) begin
      assert(trans.randomize) else $error("RANDOMZATION FAILED");
      i++;
      mbx.put(trans);
      $display("[GEN] : op : %0d iteration : %0d", trans.op, i);
      @(next);  // wait till the result gets to the scoreboard
    end
    -> done;
  endtask
endclass

///////////////////////////////

class driver;  // drives generated stimulus to the dut
  virtual fifo_if fif;
  transaction trans;
  mailbox #(transaction) mbx;  // gen -> drv
  
  function new (mailbox #(transaction) mbx);
    this.mbx = mbx;
  endfunction
  
  task reset();
    fif.rst <= 1'b1;
    fif.wr <= 1'b0;
    fif.rd <= 1'b0;
    fif.din <= 1'b0;
    repeat(5) @(posedge fif.clk);
    fif.rst <= 1'b0;
    $display("[DRV] : RESET DONE");
    $display("---------------------------");
  endtask
  
  task write();
    @(posedge fif.clk);
    fif.rst <= 1'b0;
    fif.wr <= 1'b1;
    fif.rd <= 1'b0;
    fif.din <= $urandom_range(1,10);
    @(posedge fif.clk);
    fif.wr <= 1'b0;
    $display("[DRV] : DATA WRITE data : %0d", fif.din);
    @(posedge fif.clk);
  endtask
  
  task read();
    @(posedge fif.clk);
    fif.rst <= 1'b0;
    fif.wr <= 1'b0;
    fif.rd <= 1'b1;
    @(posedge fif.clk);
    fif.rd <= 1'b0;
    $display("[DRV] : DATA READ");
    @(posedge fif.clk);
  endtask
  
  // applying random stimulus to DUT
  task run();
    forever begin
      mbx.get(trans);
      if (trans.op == 1'b1) begin
        write();
      end
      else begin
        read();
      end
    end  
  endtask
endclass

///////////////////////////////

class monitor;  // monitors design activity
  virtual fifo_if fif;
  transaction trans;
  mailbox #(transaction) mbx;  // mon -> sco
  
  function new (mailbox #(transaction) mbx);
    this.mbx = mbx;
  endfunction
  
  task run();
    trans = new();
    forever begin
      repeat(2) @(posedge fif.clk);  // sync with driver
      trans.wr = fif.wr;
      trans.rd = fif.rd;
      trans.din = fif.din;
      trans.full = fif.full;
      trans.empty = fif.empty;
      @(posedge fif.clk);
      trans.dout = fif.dout;
      
      mbx.put(trans);
      $display("[MON] : wr: %0d rd: %0d din: %0d dout: %0d full:%0d empty: %0d",trans.wr,trans.rd,trans.din,trans.dout,trans.full,trans.empty);
    end
  endtask
endclass

///////////////////////////////

class scoreboard;  // compares actual and expected outputs
  transaction trans;
  mailbox #(transaction) mbx;  // mon-> sco
  
  event next;
  
  // golden data
  bit [7:0] fifo[$];
  bit [7:0] temp;
  int err = 0;
  
  function new (mailbox #(transaction) mbx);
    this.mbx = mbx;
  endfunction
  
  task run();
    forever begin
      mbx.get(trans);
      $display("[SCO] : wr: %0d rd: %0d din: %0d dout: %0d full:%0d empty: %0d",trans.wr,trans.rd,trans.din,trans.dout,trans.full,trans.empty);
      
      if (trans.wr == 1'b1) begin
        if (trans.full == 1'b0) begin
          fifo.push_front(trans.din);
          $display("[SCO] : DATA STORED IN QUEUE : %0d", trans.din);
        end
        else begin
          $display("[SCO] : FIFO IS FULL");
        end
        $display("---------------------------");
      end
      
      if (trans.rd == 1'b1) begin
        if (trans.empty == 1'b0) begin
          temp = fifo.pop_back();
          if (trans.dout == temp) begin
            $display("DATA MATCH");
          end
          else begin
            $dispay("DATA MISMATCH");
            err++;
          end
        end
        else begin
          $display("[SCO] : FIFO IS EMPTY");
        end
        $display("---------------------------");
      end
      -> next;
    end
  endtask
endclass

///////////////////////////////

class environment;  // combines all verification modules
  virtual fifo_if fif;
  
  generator gen;
  driver drv;
  monitor mon;
  scoreboard sco;
  
  mailbox #(transaction) gdmbx;  // gen -> drv
  mailbox #(transaction) msmbx;  // mon -> sco
  
  event nextgs;
  
  function new(virtual fifo_if fif);
    gdmbx = new();
    msmbx = new();
    
    gen = new(gdmbx);
    drv = new(gdmbx);
    mon = new(msmbx);
    sco = new(msmbx);
    
    this.fif = fif;
    drv.fif = fif;
    mon.fif = fif;
    
    gen.next = nextgs;
    sco.next = nextgs;
  endfunction
  
  task pre_test();
    drv.reset();
  endtask
  
  task test();
    fork
      gen.run();
      drv.run();
      mon.run();
      sco.run();
    join_any
  endtask
  
  task post_test();
    wait(gen.done.triggered);
    $display("---------------------------");
    $display("error count : %0d", sco.err);
    $display("---------------------------");
    $finish();
  endtask
  
  task run();
    pre_test();
    test();
    post_test();
  endtask
endclass

///////////////////////////////

module fifo_tb;
  fifo_if fif();
  FIFO dut(.clk(fif.clk),.rst(fif.rst),.wr(fif.wr),.rd(fif.rd),.din(fif.din),.dout(fif.dout),.empty(fif.empty),.full(fif.full));
  
  initial begin
    fif.clk <= 0;
  end
  
  always #10 fif.clk <= ~fif.clk;
  
  environment env;
  
  initial begin
    env = new(fif);
    env.gen.count = 100;
    env.run();
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
endmodule
