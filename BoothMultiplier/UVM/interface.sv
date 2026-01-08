interface Booth_interface(input logic clk);
  logic BEGIN;
  logic END;
  logic [7:0] inbus;
  logic [15:0] outbus;
  function void do_reset();
    BEGIN = 0;
    END = 0;
    inbus = 8'd0;
  endfunction
  task send_sig(Transaction trans);
    BEGIN = trans.BEGIN;
    END = trans.END;
    inbus = trans.inbus;
  endtask
  function Transaction get_sig();
    automatic Transaction trans = new();
    trans.BEGIN = BEGIN;
    trans.END = END;
    trans.inbus = inbus;
    trans.outbus = outbus;
    return trans;
  endfunction
endinterface