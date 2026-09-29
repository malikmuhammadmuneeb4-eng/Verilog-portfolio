// Basic single-port memory: one address, synchronous write, combinational read
module simple_memory#(parameter N=8)(
    input logic clk, write_enable,
    input logic [3:0]addr,
    input logic [N-1:0]data_in,
    output logic [N-1:0]data_out
);
logic [N-1:0] mem [15:0];
always_ff @(posedge clk)
begin
    if (write_enable==1'b1) mem[addr] <= data_in ;
end
always_comb
begin
    data_out= mem[addr];
end
endmodule


// CPU-style register file: one write port, two independent simultaneous read ports
module register_file#(parameter N=8)(
    input logic clk, write_enable,
    input logic [2:0]write_addr,
    input logic [2:0]read_addr1,
    input logic [2:0]read_addr2,
    input logic [N-1:0]write_data,
    output logic [N-1:0]read_data1, read_data2
);
logic [N-1:0] mem [7:0];
always_ff @(posedge clk)
begin
    if (write_enable==1'b1)  mem[write_addr] <= write_data;
end
always_comb
begin
    read_data1= mem[read_addr1];
    read_data2=mem[read_addr2];
end
endmodule
