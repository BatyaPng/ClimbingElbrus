module decoder(
    input [7:0]num,

    output wire [3:0]msb
);

ms_bit decoder(.num(num), .msb(msb));

endmodule