module equality_checker(
    input logic [3:0] a, b,
    output logic result
);
    function logic is_equal(input logic [3:0]a,b);
        is_equal=(a[0]~^b[0]) & (a[1]~^b[1]) & (a[2]~^b[2]) & (a[3]~^b[3]);
    endfunction

    assign result = is_equal(a, b);
endmodule
