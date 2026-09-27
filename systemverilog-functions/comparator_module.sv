module comparator_module(
    input logic [3:0] a, b,
    output logic LT, GT, EQ
);
    function logic[2:0] comparator(input logic [3:0]a,b);
        if (a[3]<b[3])
            comparator=3'b100;
        else if (a[3]>b[3])
            comparator=3'b010;
        else begin
            if (a[2]<b[2])
                comparator=3'b100;
            else if (a[2]>b[2])
                comparator=3'b010;
            else begin
                if (a[1]<b[1])
                    comparator=3'b100;
                else if (a[1]>b[1])
                    comparator=3'b010;
                else begin
                    if (a[0]<b[0])
                        comparator=3'b100;
                    else if (a[0]>b[0])
                        comparator=3'b010;
                    else
                        comparator=3'b001;
                end
            end
        end
    endfunction

    assign {LT,GT,EQ} = comparator(a,b);
endmodule
