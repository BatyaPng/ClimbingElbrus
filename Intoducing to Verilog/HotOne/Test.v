module top();

reg [2:0]src_num;

wire [7:0]res_num;

hot_one hot_one_inst(.src_num(src_num), .res_num(res_num));

initial begin
    $dumpvars;

    src_num = 3; #1 $display("Source number = %d; Result number = %b", src_num, res_num);
    src_num = 6; #1 $display("Source number = %d; Result number = %b", src_num, res_num);
    src_num = 0; #1 $display("Source number = %d; Result number = %b", src_num, res_num);
    src_num = 4; #1 $display("Source number = %d; Result number = %b", src_num, res_num);
end

endmodule