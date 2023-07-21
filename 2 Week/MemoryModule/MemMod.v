module mem_mod
#(
    parameter DATA_WIDTH = 8,
    parameter MAX_ADDR = 1,
    parameter ADDRSIZE = $clog2(MAX_ADDR)
)
(
    input clk,
    input rd_en, wr_en,
    input [ADDRSIZE] rd_addr, wr_addr,
    input [DATA_WIDTH]wr_data,

    output [DATA_WIDTH]rd_data
);

reg [DATA_WIDTH] mem [MAX_ADDR];

always @(posedge clk) begin
    if (wr_en) begin
        mem[wr_addr] <= wr_data;
    end
end

assign rd_data = rd_en ? mem[rd_addr] : 'bx;

endmodule