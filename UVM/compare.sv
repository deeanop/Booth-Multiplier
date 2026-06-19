class Compare;
  int total = 0;
  int passed = 0;
  int failed = 0;
  Reference ref_model; 
  function new(Reference refer);
    this.ref_model = refer;
  endfunction
  task run(ref Transaction monToCmp[$]);
    Transaction transA, transB;
    Transaction ref_trans;
    forever begin
      wait(monToCmp.size() >= 2);
      transA = monToCmp.pop_front();
      transB = monToCmp.pop_front();
      total++;
      ref_trans = ref_model.process(transA, transB);
      $display("Comparator: Checking Multiplication %0d ---", total);
      $display("Input A: %0d, Input B: %0d", $signed(transA.inbus), $signed(transB.inbus));
      $display("DUT Result: %0d | Expected: %0d", $signed(transB.outbus), $signed(ref_trans.outbus));
      if(transB.doCompare(ref_trans)) begin
        passed++;
        $display("[PASS] Result matches!");
      end
      else begin
        failed++;
        $display("[FAIL] Mismatch detected!");
      end
      $display("Stats: Total=%0d, Passed=%0d, Failed=%0d", total, passed, failed);
    end
  endtask
endclass