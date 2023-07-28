module mem_mod
#(
    parameter DATA_WIDTH = 8,
    parameter MAX_ADDR = 1,
    parameter ADDRSIZE = $clog2(MAX_ADDR)
)
(
    input clk,
    input rd_en, wr_en,
    input [ADDRSIZE - 1:0] rd_addr, wr_addr,
    input [DATA_WIDTH - 1:0]wr_data,

    output reg [DATA_WIDTH - 1:0]rd_data
);

reg [DATA_WIDTH - 1:0] mem [MAX_ADDR - 1:0];

always @(posedge clk) begin
    if (rd_en) begin
        rd_data <= mem[rd_addr];
    end
    if (wr_en) begin
        mem[wr_addr] <= wr_data;
    end
end

endmodule
