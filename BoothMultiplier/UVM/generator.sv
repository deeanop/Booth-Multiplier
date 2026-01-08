class Generator;
  task run(ref Transaction genToDriv[$]);
    int num_trans;
    num_trans = $urandom_range(5, 10);
    for(int i=0;i<num_trans;i++) begin
      Transaction trans = new();
      trans.BEGIN = $urandom_range(0, 1);
      trans.END = $urandom_range(0, 1);
      trans.inbus = $signed($urandom())
      genToDriv.push_back(trans);
    end
    $display("Generator: %0d transactions created", num_trans);
  endtask
endclass