`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/03 11:53:23
// Design Name: 
// Module Name: my_snake_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module my_snake_top(
    input CLK,//键盘用时钟输入
    input DATA,
    input RST,
    input clk,//板载晶振
    input mist,

    output [1:0] gamestate,
    output [1:0] direct,

    output [3:0] scorel,
    output [3:0] scorem,

    output [3:0] RED,
    output [3:0] GRN,
    output [3:0] BLU,
    output HSync,
    output VSync
    );

    wire [3:0] cmd_out;
    wire [5:0] food_x;
    wire [4:0] food_y;
    wire [5:0] head1_x;
    wire [4:0] head1_y;
    wire [999:0] map;
    // wire [3:0] scorel;
    // wire [3:0] scorem;

    Keyboard KEYBOARD(.CLK(CLK),.DATA(DATA),.cmd_out(cmd_out));

    Snake_top SNAKE_TOP(.clk(clk),.rst_n(RST),.cmd_out(cmd_out),.food_x(food_x),.food_y(food_y),.map(map),.head_x(head1_x),.head_y(head1_y)
                        ,.gamestate(gamestate),.direct(direct),.scorel(scorel),.scorem(scorem)
    );

    VGA VGA(.CLK(clk),.map(map),.head1_x(head1_x),.head1_y(head1_y),.food_x(food_x),.food_y(food_y)
            ,.RED(RED),.GRN(GRN),.BLU(BLU),.HSync(HSync),.VSync(VSync),.score_l(scorel),.score_m(scorem),.mist(mist)
    );

endmodule
