`include "BoothEncoder.v"

`define DATA_WIDTH 6,
`define NUM_TERMS $ceil((DATA_WIDTH + 3) / 3),
`define CAPACITY_RESULT (DATA_WIDTH * 2 - 1) * NUM_TERMS
module top();

reg clk = 0;

reg [5:0] A;
reg [5:0] B;
wire [32:0] result;

booth_encoder #(6) booth_encoder_inst(.multiplicand(A),
                                              .multiplier(B),
                                              .result(result));

initial begin
    A <= 6'b110101;
    B <= 6'b011011;
end

always begin
    #1 clk = ~clk;
end

   integer i;

initial begin
    $dumpvars;

    $strobe("ir_result[0]  = %b", booth_encoder_inst.ir_result[0]);
    $monitor("result[5:0]  = %b", result[5:0]);

    $strobe("ir_result[1]   = %b", booth_encoder_inst.ir_result[1]);
    $strobe("result[11:6]   = %b", result[11:6]);

    $strobe("ir_result[2]    = %b", booth_encoder_inst.ir_result[2]);
    $strobe("result[17:12]   = %b", result[17:12]);

 
    for (i = 0; i < 3 ; i = i + 1) begin
        $dumpvars(1, booth_encoder_inst.ir_result[i]);
    end

    #10;

    $finish;
end

endmodule