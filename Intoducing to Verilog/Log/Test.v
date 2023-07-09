module top();

reg [7:0]src_num;

wire [3:0]log_src_num;

log log_inst(.num(src_num), .log_num(log_src_num));

initial begin
    $dumpvars;

    src_num = 0; #1 $display("Source number = %d; Result number = %d", src_num, log_src_num);
    src_num = 1; #1 $display("Source number = %d; Result number = %d", src_num, log_src_num);
    src_num = 2; #1 $display("Source number = %d; Result number = %d", src_num, log_src_num);
    src_num = 4; #1 $display("Source number = %d; Result number = %d", src_num, log_src_num);
    src_num = 8; #1 $display("Source number = %d; Result number = %d", src_num, log_src_num);
    src_num = 16; #1 $display("Source number = %d; Result number = %d", src_num, log_src_num);
    src_num = 32; #1 $display("Source number = %d; Result number = %d", src_num, log_src_num);
    src_num = 64; #1 $display("Source number = %d; Result number = %d", src_num, log_src_num);
    src_num = 128; #1 $display("Source number = %d; Result number = %d", src_num, log_src_num);
end

endmodule