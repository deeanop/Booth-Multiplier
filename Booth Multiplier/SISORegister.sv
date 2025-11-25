module SISORegister(
  input logic serialInput, clk,
  output logic serialOutput, nSerialOutput
);
  logic [7:0] intern;
  logic [7:0] nintern;
  genvar i;
  generate
    for(i=0;i<=7;i=i+1) begin: gen_sr
      if(i == 7) begin
      	SRFlipFlop sr(
          .S(serialInput),
          .R(~serialInput),
          .clk(clk),
          .Q(intern[i]),
          .nQ(nintern[i])
        );
      end
      else begin
        SRFlipFlop sr(
          .S(intern[i+1]),
          .R(nintern[i+1]),
          .clk(clk),
          .Q(intern[i]),
          .nQ(nintern[i])
        );
      end
    end
  endgenerate
  assign serialOutput = intern[0];
  assign nSerialOutput = nintern[0];
endmodule
        
           
        
    