class Generator;
  task run(ref Transaction genToDriv[$]);
    int numOperations = $urandom_range(5, 10);
    for(int i=0;i<numOperations;i++) begin
      Transaction transA = new();
      Transaction transB = new();
      transA.BEGIN = 1;
      transA.END = 0;
      transA.inbus = $urandom_range(-128, 127);
      genToDriv.push_back(transA);
      transB.BEGIN = 0;
      transB.END = 0;
      transB.inbus = $urandom_range(-128, 127);
      genToDriv.push_back(transB);
    end
    $display("Generator: Created %0d multiplication pairs", numOperations);
  endtask
endclass