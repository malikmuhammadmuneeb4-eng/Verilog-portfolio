// Version 1: Behavioral - uses built-in comparison operators
module comparator_4bit(
    input [3:0] a, b,
    output reg LT, GT, EQ
);
    always @(*)
    begin
        LT = (a<b);
        GT = (a>b);
        EQ = (a==b);
    end
endmodule


// Version 2: Structural/priority-based - bit-by-bit, MSB first
module comparator4bit(
    input [3:0] a, b,
    output reg LT, GT, EQ
);
    always@(*)
    begin
        if (a[3]<b[3])
            {LT,GT,EQ}=3'b100;
        else if (a[3]>b[3])
            {LT,GT,EQ}=3'b010;
        else begin
            if (a[2]<b[2])
                {LT,GT,EQ}=3'b100;
            else if (a[2]>b[2])
                {LT,GT,EQ}=3'b010;
            else begin
                if (a[1]<b[1])
                    {LT,GT,EQ}=3'b100;
                else if (a[1]>b[1])
                    {LT,GT,EQ}=3'b010;
                else begin
                    if (a[0]<b[0])
                        {LT,GT,EQ}=3'b100;
                    else if (a[0]>b[0])
                        {LT,GT,EQ}=3'b010;
                    else
                        {LT,GT,EQ}=3'b001;
                end
            end
        end
    end
endmodule
