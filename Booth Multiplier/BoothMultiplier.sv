module BoothMultiplier(
  input logic[7:0] inbus,
  input logic BEGIN,
  input logic END,
  input logic CLK,
  output logic [15:0] outbus
);
  logic[6:0] controls;
  logic[7:0] toMultiplicand;
  logic[7:0] fromMToXor;
  logic[7:0] fromXorToAdder;
  logic[7:0] fromAdderToAcc;
  logic[7:0] fromMultiplierToOutbus;
  logic[7:0] fromAccToOutbus;
  logic[2:0] CounterToCU;
  logic fromQ0ToCU, fromQ_1ToCU;
  logic COUNT7;
  assign COUNT7 = &CounterToCU;
  controlUnit cu(
    .CLK(CLK),
    .BEGIN(BEGIN),
    .END_ext(END),
    .Q0(fromQ0ToCU),
    .Q_minus1(fromQ_1ToCU),
    .c0(controls[0]),
    .c1(controls[1]),
    .c2(controls[2]),
    .c3(controls[3]),
    .c4(controls[4]),
    .c5(controls[5]),
    .c6(controls[6]),
    .COUNT7(COUNT7)
  );
  assign toMultiplicand = controls[0] ? inbus : 8'b0;
  PIPONoShiftRegister M(
    .D(toMultiplicand),
    .Q(fromMToXor),
    .clk(CLK)
  );
  genvar i;
  generate
    for(i=0;i<=7;i=i+1) begin: gen_xor
      xorGate xg(
        .A(fromMToXor[i]),
        .B(controls[3]),
        .Z(fromXorToAdder[i])
      );
    end
  endgenerate
  logic [7:0] A_D;
  assign A_D =
    controls[0]? 8'b0:
    controls[4]? {fromAccToOutbus[7], fromAccToOutbus[7:1]}: 
    controls[2]? fromAdderToAcc: fromAccToOutbus;
  PIPOShiftRegister A(
    .Shift_nLoad(1'b1),
    .serial_in(1'b0),
    .D(A_D),
    .Q(fromAccToOutbus),
    .clk(CLK)
  );
  logic [7:0] Q_D;
  assign Q_D = 
    controls[1]? inbus:
    controls[4]? {fromAccToOutbus[0], fromMultiplierToOutbus[7:1]}:
    controls[5]? {fromMultiplierToOutbus[7:1], 1'b0}:
    fromMultiplierToOutbus;
  PIPOShiftRegister Q(
    .Shift_nLoad(1'b1),
    .serial_in(1'b0),
    .D(Q_D),
    .Q(fromMultiplierToOutbus),
    .clk(CLK)
  );
  assign fromQ0ToCU = controls[5]? 1'b0: fromMultiplierToOutbus[0];
  assign outbus = (controls[6]==1'b1)? {fromAccToOutbus, fromMultiplierToOutbus} : 16'h0000;
  logic Q1_D;
  assign Q1_D =
    controls[1]? 1'b0:
    controls[4]? fromMultiplierToOutbus[0]: 
    		     fromQ_1ToCU;
  DFlipFlop Q_1(
    .D(Q1_D),
    .Q(fromQ_1ToCU),
    .clk(CLK)
  );
  RCA ParallelAdder(
    .A(fromAccToOutbus),
    .B(fromXorToAdder),
    .S(fromAdderToAcc),
    .cin(controls[3])
  );
  asynchronousCounter AC(
    .Q(CounterToCU),
    .clk(CLK),
    .enable(controls[4]),
    .reset(controls[0])
  );
endmodule