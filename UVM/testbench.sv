`include "interface.sv"
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "reference.sv"
`include "compare.sv"
`include "coverage.sv"
`include "environment.sv"
`include "test.sv"
module BoothMultiplier_top;
  bit CLK;
  initial begin
    CLK = 0;
    forever #5 CLK = ~CLK;
  end
  Booth_interface inter(CLK);
  BoothMultiplier dut(
    .CLK(inter.clk), 
    .BEGIN(inter.BEGIN),
    .END(inter.END),
    .inbus(inter.inbus),
    .outbus(inter.outbus)
  );
  test t1(inter);

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, BoothMultiplier_top);
    #5000;
    $finish;
  end
endmodule