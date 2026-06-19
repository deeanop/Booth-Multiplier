interface Booth_interface(input logic clk);
  logic BEGIN;
  logic END;
  logic [7:0] inbus;
  logic [15:0] outbus;
  clocking driver @(posedge clk);
    default input #1ns output #1ns;
    output BEGIN;
    input END;
    output inbus;
    input outbus;
  endclocking
  clocking monitor @(posedge clk);
    default input #1ns output #1ns;
    input BEGIN;
    input END;
    input inbus;
    input outbus;
  endclocking
  modport DRV(clocking driver, input clk);
  modport MON(clocking monitor, input clk);
  property noSimultaneousBeginEnd;
    @(posedge clk) not (BEGIN && END);
  endproperty
  noSimultaneousBeginEndAssertion: assert property(noSimultaneousBeginEnd)
    else $error("BEGIN and END are active sumultaneously");
  property endAfterBegin;
    @(posedge clk) BEGIN |-> ##[1:15] END;
  endproperty
  endAfterBeginAssertion: assert property(endAfterBegin)
    else $error("END appeared too late");
  property outbusValidAtEnd;
    @(posedge clk) END |-> !$isunknown(outbus);
  endproperty
  outbusValidAtEndAssertion: assert property(outbusValidAtEnd)
    else $warning("Outbus contains bits of Z and X when END is active"); 
  property inbusValid;
    @(posedge clk) BEGIN |-> !$isunknown(inbus) && !$isunknown($past(inbus));
  endproperty
  inbusValidAssertion: assert property(inbusValid)
    else $error("One of the operands on inbus is unknown at start");
  property stableInbusCalcul;
    @(posedge clk) BEGIN |=> $stable(inbus) throughout (##0 END[->1]);
  endproperty
  stableInbusCalculAssertion: assert property(stableInbusCalcul)
    else $warning("Inbus changed during calculation");
endinterface