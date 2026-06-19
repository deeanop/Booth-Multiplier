class Coverage;
  Transaction transA;
  Transaction transB;
  covergroup Booth_covergroup;
    CP_A: coverpoint $signed(transA.inbus){
      bins negative = {[-128: -1]};
      bins zero = {0};
      bins positive = {[1: 127]};
    }
    CP_B: coverpoint $signed(transB.inbus){
      bins negative = {[-128: -1]};
      bins zero = {0};
      bins positive = {[1: 127]};
    }
    CROSS_AB: cross CP_A, CP_B;
  endgroup
  function new();
    Booth_covergroup = new();
  endfunction
  task run(ref Transaction monToCvg[$]);
  	forever begin
      wait(monToCvg.size() >= 2);
      transA = monToCvg.pop_front();
      transB = monToCvg.pop_front();
      Booth_covergroup.sample();
    end
  endtask
endclass
    