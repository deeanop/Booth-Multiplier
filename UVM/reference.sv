class Reference;
  function Transaction process(Transaction transA, Transaction transB);
    Transaction ref_trans = new();
    ref_trans.outbus = $signed(transA.inbus) * $signed(transB.inbus);
    ref_trans.BEGIN = 0;
    ref_trans.END = 1;
    ref_trans.inbus = transB.inbus;
    return ref_trans;
  endfunction
endclass