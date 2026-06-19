class Transaction;
  logic BEGIN;
  logic END;
  logic [7:0] inbus;
  logic [15:0] outbus;

  function new();
    BEGIN = 0;
    END = 0;
    inbus = 8'd0;
    outbus = 16'd0;
  endfunction

  function void display(string component_name = "");
    $display("%s Transaction: BEGIN = %b, END = %b, inbus = %d, outbus = %d", component_name, BEGIN, END, inbus, outbus);
  endfunction

  function void doCopy(Transaction trans);
    BEGIN = trans.BEGIN;
    END = trans.END;
    inbus = trans.inbus;
    outbus = trans.outbus;
  endfunction

  function bit doCompare(Transaction trans);
    if(trans == null) return 0;
    return (BEGIN === trans.BEGIN) && (END === trans.END) && (inbus === trans.inbus) && (outbus === trans.outbus);
  endfunction
endclass