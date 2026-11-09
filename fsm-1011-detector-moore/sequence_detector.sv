typedef enum logic [3:0]
{s0,s1,s2,s3,s4}
state_t;

module sequence_detector(
  input logic reset, clk,
  input logic x,
  output logic y
);
state_t state;
state_t next_state;
always_comb begin
  case(state)
    s0: next_state = state_t'((x==1) ? s1:s0);
    s1: next_state = state_t'((x==1) ? s1:s2);
    s2: next_state = state_t'((x==1) ? s3:s0);
    s3: next_state = state_t'((x==1) ? s4:s2);
    s4: next_state = state_t'((x==1) ? s1:s2);
    default: next_state = s0;
  endcase
end

always_ff @(posedge clk or posedge reset) begin
  if (reset) state<=s0;
  else state<=next_state;
end

always_comb begin
  if (state==s4) y=1'b1;
  else y=1'b0;
end
endmodule
