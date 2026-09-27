module four_bit_register (
    input logic clk,reset,enable,
    input logic [3:0]d,
    output logic [3:0]q
);
always_ff @(posedge clk)
begin
    if (reset)
    q<=4'b0000;
    else if(enable) q<=d;
    else q<=q;
end
endmodule
