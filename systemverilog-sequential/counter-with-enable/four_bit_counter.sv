module four_bit_counter(
    input logic clk,reset,enable,
    output logic [3:0]count
);
always_ff @(posedge clk)
begin
    if(reset) count<= 4'd0;
    else if (enable) count <= count+1;
    else count <= count;
end
endmodule
