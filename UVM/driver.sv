class Driver;
  virtual Booth_interface.DRV vif;
  function new(virtual Booth_interface.DRV vif_in);
    this.vif = vif_in;
  endfunction
  task run(ref Transaction genToDriv[$]);
    vif.driver.BEGIN <= 0;
    vif.driver.inbus <= 8'd0;
    @(vif.driver);
    forever begin
      if(genToDriv.size() > 0) begin
        Transaction trans = genToDriv.pop_front();
        vif.driver.BEGIN <= 1;
        vif.driver.inbus <= trans.inbus;
        $display("Driver: In = %0d, BEGIN = %b", $signed(trans.inbus), trans.BEGIN);
        @(vif.driver);
        vif.driver.BEGIN <= 0;
        wait(vif.driver.END == 1);
        @(vif.driver);
      end else begin
        @(vif.driver);
      end 
    end 
  endtask
endclass