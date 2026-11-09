typedef enum logic [1:0] {
RED,GREEN,YELLOW} state_t;

module traffic_light (
input logic clk, reset,
output logic [2:0] light
);
state_t state;
state_t next_state;
logic [2:0] counter ;
always_comb begin
case(state)
RED: next_state=state_t'((counter==3'd3) ? GREEN:RED);
GREEN: next_state=state_t'((counter==3'd2) ? YELLOW:GREEN);
YELLOW: next_state=state_t'((counter==3'd1) ? RED:YELLOW);
default: next_state=RED;
endcase
end

always_ff@(posedge clk or posedge reset) begin
if (reset==1) counter <= 3'b0;
else if (state==RED && counter==3'd3) counter <=3'd0;
else if (state==GREEN && counter==3'd2) counter <=3'd0;
else if (state==YELLOW && counter==3'd1) counter <=3'd0;
else counter <= counter +1;
end

always_ff @(posedge clk or posedge reset) begin
if (reset) state<=RED;
else state<=next_state ;
end

always_comb
    begin
        case (state)
            RED:     light = 3'b100;
            GREEN:   light = 3'b010;
            YELLOW:  light = 3'b001;
            default: light = 3'b000;
        endcase
    end
endmodule
