class Reference;
  logic [7:0] data_input [$];
  logic [15:0] data_output;
  function new();
    data_output = 16'd0;
  endfunction
  function Transaction process(Transaction trans);
    Transaction ref_trans = new();
    if(trans.BEGIN) begin
      data_input.push_back(trans.inbus);
    end
    if(trans.END) begin
      if(data_input.size() >= 2) begin
        logic signed [7:0] A, B;
        A = data_input.pop_front();
        B = data_input.pop_front();
        data_output = A * B;
      end
      data_input.delete();
    end
    ref_trans.doCopy(trans);
    ref_trans.outbus = data_output;
    return ref_trans;
  endfunction
endclass
 