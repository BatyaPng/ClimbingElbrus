// `include "IsEven.v"

// `timescale 1ns/1ns

module top();

reg [7:0]num;
wire parity;
 
is_even is_even_inst(.num(num), .parity(parity));

initial begin
    $dumpvars;

    num = 31; #1 $display("parity = %d", parity);
end

endmodule