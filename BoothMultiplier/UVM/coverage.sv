class Coverage;
  Booth_covergroup cg;
  function new();
    cg = new();
  endfunction
  task run(ref Transaction monToCvg[$]);
    foreach begin
      wait(monToCvg.size() > 0);
      Transaction tr = monToCvg.pop_front();
      cg.sample(tr);
    end
  endtask
  function void display();
    $display("Coverage report:");
    $display("BEGIN: %0f%%", cg.BEGIN.get_coverage());
    $display("END: %0f%%", cg.END.get_coverage());
    $display("cross BEGIN/END: %0f%%", cg.get_inst_coverage());
  endfunction
endclass