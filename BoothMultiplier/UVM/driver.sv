class Driver;
  Environment env_ref;
  function new(Environment env_ptr);
    this.env_ref = env.ptr;
  endfunction
  task run(ref Transaction genToDriv[$]);
    env_ref.BEGIN = 0;
    env_ref.END = 0;
    env.inbus = 8'd0;
    #20;
    while(genToDriv.size() > 0) begin
      Transaction trans;
      trans = genToDriv.pop_front();
      $display("Driver: Applying transaction, BEGIN = %b, END = %b, inbus = %d", trans.BEGIN, trans.END, trans.inbus);
      env_ref.BEGIN = trans.BEGIN;
      env_ref.END = trans.END;
      env_ref.inbus = trans.inbus;
      @(posedge end_ref.CLK);
    end
  endtask
endclass