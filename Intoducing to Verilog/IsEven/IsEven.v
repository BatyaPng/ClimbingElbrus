module is_even(
    input wire [7:0]num,

    output wire parity
);

assign parity = ~(num & 1);

endmodule