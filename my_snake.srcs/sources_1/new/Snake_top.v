`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/03 11:26:39
// Design Name: 
// Module Name: Snake_top
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


module Snake_top(
    input clk,
    input rst_n,
    input [3:0] cmd_out,

    output [1:0] gamestate,
    output [1:0] direct,

    output [3:0] scorel,
    output [3:0] scorem,
    output [3:0] scorel2,
    output [3:0] scorem2,
    
    output [5:0]food_x,
    output [4:0]food_y,
    output [999:0]map,
    output [5:0]head_x,
    output [4:0]head_y,
    output [5:0]head_x2,
    output [4:0]head_y2
    );
    
    wire [5:0]foodx;
    wire [4:0]foody;
    wire [5:0]headx;
    wire [4:0]heady;
    wire add_body;
    wire hit;
    
    wire [5:0]headx2;
    wire [4:0]heady2;
    wire add_body2;
    wire hit2;
    // wire [1:0]gamestate;
    
    assign food_x = foodx;
    assign food_y = foody;
    assign head_x = headx;
    assign head_y = heady;
    assign head_x2 = headx2;
    assign head_y2 = heady2;
    
    
    Snake_food U1(.clk(clk), .rst_n(rst_n), .food_x(foodx), .food_y(foody)
                ,.add_body(add_body), .head_x(headx), .head_y(heady)
                ,.add_body2(add_body2), .head_x2(headx2), .head_y2(heady2));
    
    Game_ctrl U2(.clk(clk), .rst_n(rst_n), .gamestate(gamestate)
                ,.cmd_out(cmd_out), .hit(hit), .hit2(hit2));
    
    Snake U3(.clk(clk), .rst_n(rst_n), .cmd_out(cmd_out), .gamestate(gamestate)
            ,.add_body(add_body), .hit(hit), .map(map), .head_x(headx), .head_y(heady)
            ,.add_body2(add_body2), .hit2(hit2), .head_x2(headx2), .head_y2(heady2)
            ,.scorel(scorel),.scorem(scorem),.scorel2(scorel2),.scorem2(scorem2)
            );
    
endmodule