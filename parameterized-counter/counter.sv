// Synchronous reset version - only takes effect on a clock edge
module counter #(parameter N=4)(
    input logic clk, reset, en,
    output logic [N-1:0] count
);
    always_ff @(posedge clk)
    begin
        if (reset) count <= '0;
        else if (en) count <= count+1;
    end
endmodule


// Asynchronous reset version - takes effect immediately, independent of the clock
module counter_async #(parameter N=4)(
    input logic clk, reset, en,
    output logic [N-1:0] count
);
    always_ff @(posedge clk or posedge reset)
    begin
        if (reset) count <= '0;
        else if (en) count <= count+1;
    end
endmodule
