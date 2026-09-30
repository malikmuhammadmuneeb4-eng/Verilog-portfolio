module comparator4bit(
    input logic [3:0] a, b,
    output logic LT, GT, EQ
);
    always_comb begin
        if (a<b) {LT,GT,EQ}=3'b100;
        else if (a>b) {LT,GT,EQ}=3'b010;
        else {LT,GT,EQ}=3'b001;
    end
endmodule
