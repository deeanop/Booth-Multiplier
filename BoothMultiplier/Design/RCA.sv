module RCA(
  input logic [7:0]A, [7:0]B,
  output logic [7:0]S,
  output logic cout
);
  logic [7:0] intern;
  genvar i;
  generate
    for(i=0;i<=7;i=i+1) begin: gen_sum
      if(i==7) begin
        HAC half(
          .a(A[i]),
          .b(B[i]),
          .s(S[i]),
          .cout(intern[i])
        );
      end
      else begin
        FAC full(
          .a(A[i]),
          .b(B[i]),
          .s(S[i]),
          .cout(intern[i]),
          .cin(intern[i+1])
        );
      end
    end
  endgenerate
  assign cout = intern[0];
endmodule
    