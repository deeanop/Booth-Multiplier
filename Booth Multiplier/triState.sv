module triState(
  input logic X, E,
  output logic Y
);
  always_comb begin
    if(E == 1'b0) 
      Y = 1'bZ;
    else if(X == 1'b0)
      Y = 1'b0;
    else
      Y = 1'b1;
  end
endmodule
     
       