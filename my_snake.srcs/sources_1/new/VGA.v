module VGA(input CLK,
                input [999:0] map,//地图
                input [5:0] head1_x,
                input [4:0] head1_y,
                input [5:0] head2_x,
                input [4:0] head2_y,
                input [5:0] food_x,
                input [4:0] food_y,
                input [3:0] score_l,
                input [3:0] score_m,
                input [3:0] score_l2,
                input [3:0] score_m2,
                // output reg [5:0] y,
                // output reg [4:0] x_m,
                // output reg [1:0] cnt_m,
                // output reg [4:0] row,//行
                // output reg [5:0] col,//列
                // output reg [3:0] block_clk,
                // output reg [1:0] pixel_cnt,
                // output reg [11:0] Hsync_s,
                // output reg [20:0] Vsync_s,//生成同步信号使用的状态
                output reg [3:0] RED,
                output reg [3:0] GRN,
                output reg [3:0] BLU,
                output reg HSync,
                output reg VSync);

    reg [11:0] Hsync_s;
    reg [20:0] Vsync_s;//生成同步信号使用的状态

    // reg [3:0] score_m;//绘出十位数字使用的分数
    reg [5:0] y_m;//坐标
    reg [4:0] x_m;
    reg [1:0] cnt_m;//计数器，用于在合适的时候更新坐标

    // reg [3:0] score_l;//个位
    reg [5:0] y_l;
    reg [4:0] x_l;
    reg [1:0] cnt_l;

    // reg [3:0] score_m;//绘出十位数字使用的分数
    reg [5:0] y2_m;//坐标
    reg [4:0] x2_m;
    reg [1:0] cnt2_m;//计数器，用于在合适的时候更新坐标

    // reg [3:0] score_l;//个位
    reg [5:0] y2_l;
    reg [4:0] x2_l;
    reg [1:0] cnt2_l;

    reg [5:0] y;//用于连接数字位图的io
    reg [4:0] x;
    wire [3:0] num_red;
    wire [3:0] num_grn;
    wire [3:0] num_blu;

    reg [3:0] row;//行像素
    reg [5:0] col;//列
    reg [3:0] block_clk;
    reg [1:0] pixel_cnt;
    reg [4:0] row_block;

    reg [3:0] score;//输入到数字位图，用于确认具体数字
    // reg [999:0] map;//地图
    // reg [5:0] head1_x;
    // reg [4:0] head1_y;
    // reg [5:0] food_x;
    // reg [4:0] food_y;

    print_num numout(.num(score),.x(x),.y(y),.red(num_red),.grn(num_grn),.blu(num_blu));

    always @(posedge CLK) begin//确定同步信号
        // score_m<=2;
        // score_l<=1;
        Hsync_s <= 0;
        Vsync_s <= 0;
        if (Hsync_s == 0) begin
            HSync   <= 0;
            Hsync_s <= Hsync_s+1;
        end
        else if (Hsync_s == 384) begin
            HSync   <= 1;
            Hsync_s <= Hsync_s+1;
        end
        else if (Hsync_s == 3199) Hsync_s <= 0;//Hsync范围是0-3199
        else if (Hsync_s>0&&Hsync_s<3199&&Hsync_s != 384) Hsync_s <= Hsync_s+1;
        if (Vsync_s == 0) begin
            VSync   <= 0;
            Vsync_s <= Vsync_s+1;
        end
        else if (Vsync_s == 6400) begin
            VSync   <= 1;
            Vsync_s <= Vsync_s+1;
        end
        else if (Vsync_s == 1667199) begin//Vsync范围是0-1667199
            Vsync_s <= 0;
            VSync   <= 0;
        end
        else if (Vsync_s>0&&Vsync_s<1667199&&Vsync_s != 6400) Vsync_s <= Vsync_s+1;
    end
    always @(posedge CLK) begin//绘制
        // map<=1000'h0000000000FFFF00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
        // head1_x<=4;
        // head1_y<=5;
        // food_x<=4;
        // food_y<=6;
        if(Vsync_s>=0&&Vsync_s<10&&Hsync_s>=0&&Hsync_s<10) begin
            y_m<=0;
            x_m<=0;
            cnt_m<=0;
            y_l<=0;
            x_l<=0;
            cnt_l<=0;
            row<=0;
            col<=0;
            block_clk<=0;
            pixel_cnt<=0;
            row_block<=0;
        end
        else if((Vsync_s>=99200&&Vsync_s<1379200)&&(Hsync_s>=576&&Hsync_s<3136)) begin//地图部分
            if(pixel_cnt==3) begin
                pixel_cnt<=0;
                if(block_clk==15) begin
                    block_clk<=0;
                    if(col==39) begin
                        col<=0;
                        if(row==15) begin
                            row<=0;
                            if(row_block==24) begin
                                pixel_cnt<=0;
                                block_clk<=0;
                                col<=0;
                                row<=0;
                                row_block<=0;
                            end
                            else row_block<=row_block+1;
                        end
                        else row<=row+1;
                    end
                    else col<=col+1;
                end
                block_clk<=block_clk+1;
            end
            else pixel_cnt<=pixel_cnt+1;

            if(col==0||col==39||row_block==0||row_block==24) begin//边框是白色
                RED<=4'b1111;
                GRN<=4'b1111;
                BLU<=4'b1111;
            end
            else if(row_block==food_y&&col==food_x) begin//食物是红色
                RED<=4'b1111;
                GRN<=4'b0000;
                BLU<=4'b0000;
            end
            else if(map[40*row_block+col]==1) begin//身体是黄色
                if(row_block==head1_y&&col==head1_x) begin//头是青色
                    RED<=4'b0000;
                    GRN<=4'b1111;
                    BLU<=4'b1111;
                end
                else if (row_block==head2_y&&col==head2_x) begin//另一个头是紫色
                    RED<=4'b1111;
                    GRN<=4'b0000;
                    BLU<=4'b1111;
                end
                else begin
                    RED<=4'b1111;
                    GRN<=4'b1111;
                    BLU<=4'b0000;
                end
            end
            else begin//其余是黑的
                RED<=4'b0000;
                GRN<=4'b0000;
                BLU<=4'b0000;
            end
        end
        else if(Vsync_s>=1446400&&Vsync_s<1568000) begin//绘制数字
            if(Hsync_s>=948&&Hsync_s<1056) begin
                score<=score_m;
                y<=y_m;
                x<=x_m;
                if(cnt_m==3) begin
                    cnt_m<=0;
                    if(x_m==26) begin
                        x_m<=0;
                        if(y_m==37) begin
                            x_m<=0;
                            y_m<=0;
                        end
                        else y_m<=y_m+1;
                    end
                    else x_m<=x_m+1;
                end
                else begin
                    cnt_m<=cnt_m+1;
                    x_m<=x_m;
                    y_m<=y_m;
                end
            end
            else if(Hsync_s>=1056&&Hsync_s<1164) begin
                score<=score_l;
                y<=y_l;
                x<=x_l;
                if(cnt_l==3) begin
                    cnt_l<=0;
                    if(x_l==26) begin
                        x_l<=0;
                        if(y_l==37) begin
                            x_l<=0;
                            y_l<=0;
                        end
                        else y_l<=y_l+1;
                    end
                    else x_l<=x_l+1;
                end
                else begin
                    cnt_l<=cnt_l+1;
                    x_l<=x_l;
                    y_l<=y_l;
                end
            end
            else if(Hsync_s>=2548&&Hsync_s<2656) begin
                score<=score_m2;
                y<=y2_m;
                x<=x2_m;
                if(cnt2_m==3) begin
                    cnt2_m<=0;
                    if(x2_m==26) begin
                        x2_m<=0;
                        if(y2_m==37) begin
                            x2_m<=0;
                            y2_m<=0;
                        end
                        else y2_m<=y2_m+1;
                    end
                    else x2_m<=x2_m+1;
                end
                else begin
                    cnt2_m<=cnt2_m+1;
                    x2_m<=x2_m;
                    y2_m<=y2_m;
                end
            end
            else if(Hsync_s>=2656&&Hsync_s<2764) begin
                score<=score_l2;
                y<=y2_l;
                x<=x2_l;
                if(cnt2_l==3) begin
                    cnt2_l<=0;
                    if(x2_l==26) begin
                        x2_l<=0;
                        if(y2_l==37) begin
                            x2_l<=0;
                            y2_l<=0;
                        end
                        else y2_l<=y2_l+1;
                    end
                    else x2_l<=x2_l+1;
                end
                else begin
                    cnt2_l<=cnt2_l+1;
                    x2_l<=x2_l;
                    y2_l<=y2_l;
                end
            end
            else begin
                cnt_m<=cnt_m;
                x_m<=x_m;
                y_m<=y_m;
                cnt_l<=cnt_l;
                x_l<=x_l;
                y_l<=y_l;
                pixel_cnt<=pixel_cnt;
                block_clk<=block_clk;
                col<=col;
                row<=row;
                row_block<=row_block;
                RED<=4'b0000;
                GRN<=4'b0000;
                BLU<=4'b0000;
            end
            RED<=num_red;
            GRN<=num_grn;
            BLU<=num_blu;
        end
        
        else begin
            RED<=4'b0000;
            GRN<=4'b0000;
            BLU<=4'b0000;
        end
    end
endmodule