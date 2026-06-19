class Monitor;
  virtual Booth_interface.MON vif;
  function new(virtual Booth_interface.MON vif_in);
    this.vif = vif_in;
  endfunction
  task run(ref Transaction monToCmp[$], ref Transaction monToCvg[$]);
    Transaction trans;
    forever begin
      @(vif.monitor);
      if(vif.monitor.BEGIN === 1'b1) begin
        trans = new();
        trans.inbus = vif.monitor.inbus;
        trans.BEGIN = 1;
        trans.END = 0;
        monToCmp.push_back(trans);
        monToCvg.push_back(trans);
        $display("Monitor: Sent operand A: %0d", $signed(trans.inbus));
        @(vif.monitor);
        trans = new();
        trans.inbus = vif.monitor.inbus;
        trans.BEGIN = 0;
        wait(vif.monitor.END === 1'b1);
        @(vif.monitor);
        trans.outbus = vif.monitor.outbus;
        trans.END = 1;
        monToCmp.push_back(trans);
        monToCvg.push_back(trans);
        $display("Monitor: Sent operand B: %0d and Result: %0d", $signed(trans.inbus), $signed(trans.outbus));
      end
    end
  endtask
endclass