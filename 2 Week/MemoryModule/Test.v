`define DATA_WIDTH 8;
`define MAX_ADDR 4;
`define ADDRSIZE $clog2(MAX_ADDR); 

module top();

reg clk = 0;
always begin
    #1 clk = ~clk;
end

reg rd_en, wr_en;
reg [2] rd_addr, wr_addr;
reg [8] wr_data;

wire [8] rd_data;

mem_mod #(8, 4) mem_mod_inst(.clk(clk), 
                                             .rd_en(rd_en), .wr_en(wr_en), 
                                             .rd_addr(rd_addr), .wr_addr(wr_addr), 
                                             .wr_data(wr_data),
                                             .rd_data(rd_data));

initial begin
    $dumpvars;

    wr_en = 1;
    wr_addr = 0; 
    wr_data = 128;
    #2;
    //$display("Wrote data: %d",wr_data);
    wr_addr = 1; 
    wr_data = 56;
    #2;

    //$display("Wrote data: %d",wr_data);
    wr_addr = 2; 
    wr_data = 74;
    #2;

    //$display("Wrote data: %d",wr_data);
    wr_addr = 3; 
    wr_data = 200;
    #2;

    //$display("Wrote data: %d",wr_data);

    wr_en = 0;
    rd_en = 1;
    rd_addr = 0;
    //$display("Readed data: %d", rd_data);
    #2;

    rd_addr = 1;
    //$display("Readed data: %d", rd_data);
    #2;

    rd_addr = 2;
    //$display("Readed data: %d", rd_data);
    #2;

    rd_addr = 3;
    //$display("Readed data: %d", rd_data);
    #2;

    #2 $finish;
end

endmodule