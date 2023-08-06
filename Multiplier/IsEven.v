module is_even
#(
    parameter DATA_WIDTH = 32
)
(
    input wire [DATA_WIDTH - 1:0] num,

    output wire parity
);

assign parity = ~num[0];

endmodule