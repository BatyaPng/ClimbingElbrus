module top();

reg [7:0]num;

wire [3:0]msb;

decoder decoder_inst(.num(num), .msb(msb));

initial begin
    $dumpvars;

    num = 2; #1 $display("Source number = %d; MSb = %d", num, msb);
    num = 5; #1 $display("Source number = %d; MSb = %d", num, msb);
    num = 4; #1 $display("Source number = %d; MSb = %d", num, msb);
    num = 9; #1 $display("Source number = %d; MSb = %d", num, msb);
    num = 17; #1 $display("Source number = %d; MSb = %d", num, msb);
    num = 33; #1 $display("Source number = %d; MSb = %d", num, msb);
    num = 65; #1 $display("Source number = %d; MSb = %d", num, msb);
    num = 129; #1 $display("Source number = %d; MSb = %d", num, msb);
end

endmodule