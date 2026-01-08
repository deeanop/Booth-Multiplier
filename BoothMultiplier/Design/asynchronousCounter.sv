module asynchronousCounter(
  input logic clk,
  input logic reset,
  input logic enable,
  output logic [2:0] Q
);
  JKFlipFlop jk0(
    .J(enable), .K(enable),
    .clk(clk), 
    .reset(reset),
    .Q(Q[0])
  );

  JKFlipFlop jk1(
    .J(1'b1), .K(1'b1),
    .clk(Q[0]), 
    .reset(reset),
    .Q(Q[1])
  );

  JKFlipFlop jk2(
    .J(1'b1), .K(1'b1),
    .clk(Q[1]), 
    .reset(reset),
    .Q(Q[2])
  );
endmodule