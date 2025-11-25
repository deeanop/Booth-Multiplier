module xorGate(
  input logic A, B,
  output logic Z
);
  assign Z = A ^ B;
endmodule