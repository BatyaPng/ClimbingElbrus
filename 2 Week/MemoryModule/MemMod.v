module mem_mod
#(
    parameter DATA_WIDTH = 8,
    parameter MAX_ADDR = 1,
    parameter ADDRSIZE = $clog2(MAX_ADDR)
    // parameter CAPACITY = DATA_WIDTH * MAX_ADDR
)
(
    input clk,
    input rd_en, wr_en,
    input [ADDRSIZE] rd_addr, wr_addr,
    input [DATA_WIDTH]wr_data,

    output [DATA_WIDTH]rd_data
);

// reg [ADDRSIZE]mcb;
reg [DATA_WIDTH] mem [MAX_ADDR];

always @(posedge clk) begin
    // if (rd_en) begin
    //     $display("Out %d from %d", mem[rd_addr], rd_addr);
    //     rd_data <= mem[rd_addr];
    // end
    // else 
    if (wr_en) begin
        $display("In %d to %d", wr_data, wr_addr);
        mem[wr_addr] <= wr_data;
    end
end


assign rd_data = rd_en ? mem[rd_addr] : 'bx;

always @(rd_en) begin

    $display("Out %d from %d", rd_data, rd_addr);

end



endmodule
