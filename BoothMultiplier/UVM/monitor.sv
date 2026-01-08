class Monitor;
  Environment env_ref;
  function new(Environment env_ptr);
    this.env_ref = env_ptr;
  endfunction
  task run(ref Transaction monToCmp[$]);
    forever begin
      @(posedge env_ref.CLK);
      Transaction trans = new();
      trans.BEGIN = env_ref.BEGIN;
      trans.END = env_ref.END;
      trans.inbus = env_ref.inbus;
      trans.outbus = env_ref.outbus;
      monToCmp.push_back(trans);
      $display("Monitor: inbus = %d, outbus = %d", trans.inbus, trans.outbus);
    end
  endtask
endclass