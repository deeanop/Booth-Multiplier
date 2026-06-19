module RCA(
  input logic [7:0]A, [7:0]B,
  input logic cin,
  output logic [7:0]S,
  output logic cout
);
  logic [8:0] intern;
  assign intern[0] = cin;
  genvar i;
  generate
    for(i=0;i<8;i=i+1) begin: gen_sum
        FAC full(
          .a(A[i]),
          .b(B[i]),
          .s(S[i]),
          .cin(intern[i]),
          .cout(intern[i+1])
        );
    end
  endgenerate
  assign cout = intern[8];
endmodule
    