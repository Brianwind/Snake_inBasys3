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

    output [5:0]food_x,
    output [4:0]food_y,
    output [999:0]map,
    output [5:0]head_x,
    output [4:0]head_y
    );
    
    wire [5:0]foodx;
    wire [4:0]foody;
    wire [5:0]headx;
    wire [4:0]heady;
    wire add_body;
    wire hit;
    // wire [1:0]gamestate;
    
    assign food_x = foodx;
    assign food_y = foody;
    assign head_x = headx;
    assign head_y = heady;
    
    Snake_food U1(.clk(clk), .rst_n(rst_n), .food_x(foodx), .food_y(foody), .add_body(add_body), .head_x(headx), .head_y(heady));
    
    Game_ctrl U2(.clk(clk), .rst_n(rst_n), .gamestate(gamestate), .cmd_out(cmd_out), .hit(hit));
    
    Snake U3(.clk(clk), .rst_n(rst_n), .cmd_out(cmd_out), .gamestate(gamestate), .add_body(add_body), .hit(hit), .map(map), .head_x(headx), .head_y(heady)
            ,.direct(direct),.scorel(scorel),.scorem(scorem)
    );
    
endmodule