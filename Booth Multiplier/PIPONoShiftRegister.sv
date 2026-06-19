module PIPONoShiftRegister(
  input logic clk,
  input logic [7:0] D,
  output logic [7:0] Q
);
  genvar i;
  generate
    for(i=0;i<=7;i=i+1) begin: gen_D
      DFlipFlop dff(
        .D(D[i]),
        .Q(Q[i]),
        .clk(clk)
      );
    end
  endgenerate
endmodule