module log(
    input [7:0]num,

    output reg [3:0]log_num
);

always @(num) begin
    case (num)
        8'b00000001 : log_num = 0;
        8'b00000010 : log_num = 1;
        8'b00000100 : log_num = 2;
        8'b00001000 : log_num = 3;
        8'b00010000 : log_num = 4;
        8'b00100000 : log_num = 5;
        8'b01000000 : log_num = 6;
        8'b10000000 : log_num = 7;
        
        default    : log_num = -1;
    endcase 
end

endmodule

