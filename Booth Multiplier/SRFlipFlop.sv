module SRFlipFlop(
  input logic S, R, clk,
  output logic Q, nQ
);
  always_ff @(posedge clk) begin
    if(S && !R)
    	Q <= 1'b1;
    else if(~S && R)
      	Q <= 1'b0;
    else if(~S && ~R)
      	Q <= Q;
    else
      	Q <= 1'bX;
  end 
  assign nQ = ~Q;
endmodule