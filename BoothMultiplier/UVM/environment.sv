class Environment;
  logic BEGIN;
  logic END;
  logic CLK;
  logic [7:0] inbus;
  logic [15:0] outbus;
  Generator gen;
  Driver driv;
  Monitor mon;
  Compare cmp;
  Coverage cov;
  Reference ref_model;
  Transaction genToDriv[$];
  Transaction monToCmp[$];
  function new();
    ref_model new();
    gen = new();
    driv = new(this);
    mon = new(this);
    cmp = new(ref_model);
    cov = new();
    inbus = 8'd0;
    BEGIN = 0;
    CLK = 0;
    END = 0;
    outbus = 16'd0;
  endfunction
  task pre_test();
    BEGIN = 0;
    END = 0;
    inbus = 8'd0;
  endtask
  task test();
    fork
      gen.run(genToDriv);
      driv.run(genToDriv);
      mon.run(monToCmp);
      cov.run(monToCmp);
      cmp.run(monToCmp);
    join_any
  endtask
  task post_test();
    $display("Test finished. Final coverage: ");
    cov.display();
  endtask
  task run();
    pre_test();
    test();
    post_test();
    $finish;
  endtask
endclass
      