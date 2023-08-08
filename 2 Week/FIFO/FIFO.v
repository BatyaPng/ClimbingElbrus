module fifo
#(
    parameter DATA_WIDTH = 8,
    parameter FIFO_DEPTH = 1,
    parameter CAPACITY = $clog2(FIFO_DEPTH) + 1
)
(
    input clk, reset,
    input rd_en, wr_en,
    input [DATA_WIDTH - 1:0] wr_data,

    output rd_val, wr_ready,
    output reg [DATA_WIDTH - 1:0] rd_data
);

reg [DATA_WIDTH - 1:0] queue [FIFO_DEPTH -1:0];
reg [CAPACITY -1:0] head;
reg [CAPACITY -1:0] tail;
reg state_system;

always @(posedge clk) begin
    if (reset) begin
        head <= 0;
    end else if (rd_en & rd_val) begin
        rd_data <= queue[head];
        head <= head + 1; 
    end
end

always @(posedge clk) begin
    if (reset) begin
        tail <= 0;
    end else if (wr_en & wr_ready) begin
        queue[tail + 1] <= wr_data;
        tail <= tail + 1;
    end
end

always @(posedge clk) begin
    if (reset) begin
        state_system <= 1;
    end else if (tail < head) begin
        state_system <= 1;
    end else if (head == tail & state_system == 1) begin
        state_system <= 0;
    end
end

assign rd_val = state_system;
assign wr_ready = ((tail - head != FIFO_DEPTH - 1) & (tail - head != 1)) ? 1 : 0;
    
endmodule