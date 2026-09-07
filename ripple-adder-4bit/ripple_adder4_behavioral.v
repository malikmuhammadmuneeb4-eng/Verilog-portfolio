module ripple_adder4_behavioral(
    input  [3:0] a, b,
    input  cin,
    output [3:0] sum,
    output cout
);
    reg [3:0] sum;
    reg cout;

    always @(*)
    begin
        {cout, sum} = a + b + cin;
    end
endmodule
