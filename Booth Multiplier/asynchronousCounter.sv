module asynchronousCounter(
  input logic clk,
  input logic reset,
  input logic enable,
  output logic [2:0] Q
);
  genvar i;
  generate
    for(i=0;i<3;i=i+1) begin: gen_jk
      if(i == 2) begin
        JKFlipFlop jk(
          .J(1'b1),
          .K(1'b1),
          .clk(clk),
          .Q(Q[i])
        );
      end
      else begin
        JKFlipFlop jk(
          .J(1'b1),
          .K(1'b1),
          .clk(Q[i+1]),
          .Q(Q[i])
        );
      end
    end
  endgenerate
endmodule
