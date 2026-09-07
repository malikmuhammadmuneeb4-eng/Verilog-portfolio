module ripple_adder4_structural(
    input  [3:0] a, b,
    input  cin,
    output [3:0] sum,
    output cout
);
    wire c0, c1, c2;

    fulladder FA0 (.a(a[0]), .b(b[0]), .cin(cin), .sum(sum[0]), .cout(c0));
    fulladder FA1 (.a(a[1]), .b(b[1]), .cin(c0),  .sum(sum[1]), .cout(c1));
    fulladder FA2 (.a(a[2]), .b(b[2]), .cin(c1),  .sum(sum[2]), .cout(c2));
    fulladder FA3 (.a(a[3]), .b(b[3]), .cin(c2),  .sum(sum[3]), .cout(cout));
endmodule

// Depends on the fulladder module (see ../full-adder/fulladder.v):
//
// module fulladder(
//     input  a, b, cin,
//     output sum, cout
// );
//     assign sum  = a ^ b ^ cin;
//     assign cout = (a & b) | (a & cin) | (b & cin);
// endmodule
