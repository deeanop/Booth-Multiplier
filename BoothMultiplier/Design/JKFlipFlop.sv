module JKFlipFlop(
  input logic J, K, clk,
  output logic Q
);
  always_ff @(posedge clk) begin
    Q <= (J & ~Q) | (~K & Q);
  end
endmodule