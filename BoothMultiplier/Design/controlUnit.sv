module controlUnit (
    input logic CLK,
    input logic BEGIN,          
    input logic END_ext,        
    input logic Q0, Q_minus1,
    input logic COUNT7,
    
    output logic c0, 
    output logic c1, 
    output logic c2, 
    output logic c3, 
    output logic c4, 
    output logic c5, 
    output logic c6 
);
    typedef enum logic [2:0] {
        S_BEGIN      = 3'b000,
        S_INPUT      = 3'b001,
        S_TEST1      = 3'b010,
        S_TEST2      = 3'b011,
        S_RIGHTSHIFT = 3'b100,
        S_OUTPUT     = 3'b101,
        S_END        = 3'b110
    } state_t;
    state_t state, next;
    always_ff @(posedge CLK) begin
        if(BEGIN)
            state <= S_BEGIN;
        else
            state <= next;
    end
    always_comb begin
        c0=0; c1=0; c2=0; c3=0; c4=0; c5=0; c6=0;
        next = state;
        case(state)
          S_BEGIN: begin
            c0 = 1;                  
            next = S_INPUT;
          end
          S_INPUT: begin
            c1 = 1;                 
            next = S_TEST1;
          end
          S_TEST1: begin
            if(Q0==1'b0 && Q_minus1==1'b1)begin
              c2 = 1;
              c3 = 0;
            end
            else if(Q0==1'b1 && Q_minus1==1'b0)begin
              c2 = 1;
              c3 = 1; 
            end
            next = S_TEST2;
          end
          S_TEST2: begin
            if(COUNT7)  next = S_OUTPUT;
            else        next = S_RIGHTSHIFT;
          end
          S_RIGHTSHIFT: begin
            c4 = 1;        
            next = S_TEST1;
          end
          S_OUTPUT: begin
            c5 = 1; c6 = 1;        
            next = S_END;
          end
          S_END: begin
            c6 = 1;
            if(END_ext) next = S_BEGIN;
            else next = S_BEGIN;
          end
          default: next = S_BEGIN;
        endcase
    end
endmodule
