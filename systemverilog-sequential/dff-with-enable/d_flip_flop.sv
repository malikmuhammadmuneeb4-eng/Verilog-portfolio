module d_flip_flop(
    input logic d,clk,reset,enable,
    output logic q
);
always_ff @(posedge clk)
begin
    if (reset)q<= 1'b0;
    else if (enable) q<= d;
    else q<=q;
end
endmodule
