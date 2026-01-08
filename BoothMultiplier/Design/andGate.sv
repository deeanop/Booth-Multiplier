module andGate(
  input logic A, B, C,
  output logic Z
);
  logic partialZ;
  assign partialZ = A & B;
  assign Z = partialZ & C;
endmodule