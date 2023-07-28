`define DATA_WIDTH 8
`define MAX_ADDR 4
`define ADDRSIZE $clog2(`MAX_ADDR) 

module top();

reg clk = 0;

reg rd_en, wr_en;
reg [`ADDRSIZE- 1:0] rd_addr, wr_addr;
reg [`DATA_WIDTH- 1:0] wr_data;

wire [`DATA_WIDTH- 1:0] rd_data;

mem_mod #(`DATA_WIDTH, `MAX_ADDR) mem_mod_inst(.clk(clk), 
                                               .rd_en(rd_en), .wr_en(wr_en), 
                                               .rd_addr(rd_addr), .wr_addr(wr_addr), 
                                               .wr_data(wr_data),
                                               .rd_data(rd_data));

always begin
    #1 clk = ~clk;
end

// initial begin
//     $dumpvars;

//     wr_en = 1;
//     wr_data = 5;
//     wr_addr = 0; #2

//     rd_en = 1;
//     rd_addr = 0;
//     wr_data = 6; #2
//     // wr_addr = 0;

//     $finish;
// end

initial begin
    wr_addr = 0;
    rd_addr = 0;
end

always @(posedge clk)
//initial
begin
//	repeat (10) begin
//		@(posedge clk)
		wr_data <= $random % 10;

		wr_en <= $random %2;
		rd_en <= $random %2;
//	end
end


endmodule