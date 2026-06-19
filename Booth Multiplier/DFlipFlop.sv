module DFlipFlop(
  input logic D, clk,
  output logic Q
);
  always_ff @(posedge clk) begin
    Q <= D;
  end
endmodule
    