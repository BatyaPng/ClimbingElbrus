module hot_one(
    input [2:0]src_num,

    output [7:0]res_num
);

assign res_num = 1 << (src_num - 1);

endmodule