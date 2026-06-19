class Environment;
  Generator gen;
  Driver driv;
  Monitor mon;
  Compare cmp;
  Coverage cov;
  Reference ref_model;

  Transaction genToDriv[$];
  Transaction monToCmp[$];
  Transaction monToCvg[$];

  virtual Booth_interface vif;

  function new(virtual Booth_interface vif_in);
    this.vif = vif_in;
    gen = new();
    driv = new(vif_in);
    mon = new(vif_in);
    ref_model = new();
    cmp = new(ref_model);
    cov = new();
  endfunction

  task pre_test();
    vif.BEGIN = 0;
    vif.inbus = 8'd0;
    @(posedge vif.clk);
  endtask

  task test();
    fork
      gen.run(genToDriv);
      driv.run(genToDriv);
      mon.run(monToCmp, monToCvg);
      cov.run(monToCvg);
      cmp.run(monToCmp);
    join_none
    wait(genToDriv.size() > 0);
  	wait(genToDriv.size() == 0);
    repeat(15) @(posedge vif.clk);
    disable fork;
  endtask

  task post_test();
    $display("Test finished. Final coverage: %0.2f%%", cov.Booth_covergroup.get_inst_coverage());
  endtask
  task run();
    pre_test();
    test();
    post_test();
    #1000;
    $finish;
  endtask
endclass