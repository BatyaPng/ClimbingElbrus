`define DATA_WIDTH 8
`define FIFO_DEPTH 4
`define CAPACITY $clog2(`FIFO_DEPTH)

module top();

reg clk = 0, reset = 1;
reg rd_en = 0, wr_en = 0;
reg [`DATA_WIDTH] wr_data;

wire rd_val, wr_ready;
wire [`DATA_WIDTH] rd_data;

always begin
    #1 clk = ~clk;
end

fifo_shift #(`DATA_WIDTH, `FIFO_DEPTH) fifo_inst(
               .clk(clk), .reset(reset),
               .rd_en(rd_en), .wr_en(wr_en),
               .wr_data(wr_data),
               
               .rd_val(rd_val), .wr_ready(wr_ready),
               .rd_data(rd_data));

initial begin
    $dumpvars;

    #2 reset = 0;

    #2 wr_en = 1; 
     wr_data = 0;
    // #2 $display("Wrote data: %d",wr_data);
 
    #2 wr_data = 1;
    // #2 $display("Wrote data: %d",wr_data);
   
    #2 wr_data = 2;
    // #2 $display("Wrote data: %d",wr_data);
   
    #2 wr_data = 3;
    // #2 $display("Wrote data: %d",wr_data);
 
    #2 wr_en = 0;
    #2 rd_en = 1;
    // #2 $display("Readed data: %d", rd_data);

    #10
    $finish;
end

endmodule