program test(Booth_interface inter);
  Environment env;
  initial begin
    env = new(inter);
    env.run();
  end
endprogram