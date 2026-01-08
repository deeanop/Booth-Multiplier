module PIPOShiftRegister(
  input logic Shift_nLoad, clk,
  input logic [7:0] D,
  output logic [7:0] Q
);
  genvar i;
  generate
    for(i = 0;i<7;i=i+1) begin: gen_D
      DFlipFlop dff(
        .D(Shift_nLoad? Q[i+1]: D[i]),
        .Q(Q[i]),
        .clk(clk)
      );
    end
  endgenerate
  DFlipFlop final(
    .D(D[7]),
    .Q(Q[7]),
    .clk(clk)
  );
endmodule
           
              