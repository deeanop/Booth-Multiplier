`timescale 1ns/1ps
module BoothMultiplier_top;
  logic CLK;
  Booth_interface inter(CLK);
  BoothMultiplier dut(
    .CLK(inter.CLK);
    .BEGIN(inter.BEGIN);
    .END(inter.END);
    .inbus(inter.inbus);
    .outbus(inter.outbus)
  );
  test t1(inter);
  initial begin
    CLK = 0;
    forever #5 CLK = ~CLK;
  end
endmodule