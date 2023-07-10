module log(
    input [7:0]num,

    output wire [3:0]log_num
);

assign log_num = num == 8'b00000001 ? 0 :
                 num == 8'b00000010 ? 1 :
                 num == 8'b00000100 ? 2 :
                 num == 8'b00001000 ? 3 :
                 num == 8'b00010000 ? 4 :
                 num == 8'b00100000 ? 5 :
                 num == 8'b01000000 ? 6 :
                 num == 8'b10000000 ? 7 :
                 -1;
                    
endmodule