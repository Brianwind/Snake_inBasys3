module Keyboard(input CLK,//注意，这个CLK是来自键盘的同步时钟，可能不与板载晶振同步。
                     input DATA,
                    //  output reg [3:0] present_bit,
                    //  output reg [7:0] cmd,
                     output reg [3:0] cmd_out);
    reg [7:0] CMD;
    reg [3:0] present_bit;
    reg [7:0] cmd;
    reg ignore;
    always @(negedge CLK) begin
        present_bit<=0;
        if(present_bit==0&&DATA==1) CMD<=8'b00000000;
        else if (DATA == 0&&present_bit == 0) begin
            present_bit <= 1;
        end
        else if (present_bit>0&&present_bit<10) begin
            present_bit <= present_bit+1;
            if (present_bit>0&&present_bit<9) begin
                cmd[present_bit-1] <= DATA;
            end
        end
        else if (present_bit == 10) begin
            present_bit<=0;
            if(cmd==8'b11110000) ignore<=1;
            else if(ignore==0) CMD<=cmd;
            else begin
                ignore<=0;
                CMD<=8'b00000000;
            end
        end
    end
    always @(*) begin
        case (CMD)
            8'b00011101:cmd_out=4'b0001;//玩家1的上下左右（按顺序）
            8'b00011011:cmd_out=4'b0010;
            8'b00011100:cmd_out=4'b0011;
            8'b00100011:cmd_out=4'b0100;
            8'b01000011:cmd_out=4'b0101;//玩家2的上下左右（按顺序）
            8'b01000010:cmd_out=4'b0110;
            8'b00111011:cmd_out=4'b0111;
            8'b01001011:cmd_out=4'b1000;
            default:cmd_out=4'b0000;
        endcase
    end
endmodule