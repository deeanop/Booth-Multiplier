class Compare;
  int total = 0;
  int passed = 0;
  int failed = 0;
  Reference ref_model;
  function new(Reference refer);
    this.ref_model = refer;
    this.total = 0;
    this.passed = 0;
    this.failed = 0;
  endfunction
  task run(ref Transaction monToCmp[$]);
    Transaction act_trans;
    Transaction exp_trans;
    forever begin
      wait(monToCmp.size() > 0);
      act_trans = monToCmp.pop_front();
      total++;
      exp_trans = ref_model.predict(act_trans);
      $display("Comparator: Transaction %0d check", total);
      if(act_trans.doCompare(exp_trans)) begin
        passed++;
        $display("PASS: Total = %d, Passed = %d", total, passed);
      end
      else begin
        failed++;
        $display("FAIL: Total = %d, Failed = %d", total, failed);
      end
    end
  endtask
endclass