module Snake_food//食物的产生和吃食物判�??
(
	input clk,
	input rst_n,
	
	input [5:0]head_x,
	input [4:0]head_y,
	
	input [5:0]head_x2,
	input [4:0]head_y2,
	
	output reg [5:0]food_x,
	output reg [4:0]food_y,

	output reg add_body,
	
	output reg add_body2
	
	
);

	reg [31:0]clk_cnt;
	reg [10:0]random_num;
	
	always@(posedge clk)
		random_num <= random_num + 999;  //用加法产生随机数  
		//随机数高5位为食物X坐标 �??5位为食物Y坐标
	
	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			clk_cnt <= 0;
			food_x <= 24;
			food_y <= 10;
			add_body <= 0;
			add_body2 <= 0;
		end
		else begin
			clk_cnt <= clk_cnt+1;
			if(clk_cnt == 250_000) begin
				clk_cnt <= 0;
				if(food_x == head_x && food_y == head_y) begin
					add_body <= 1;
					food_x <= random_num[10:5]%38+1;
					food_y <= random_num[4:0]%23+1;
				end   //随机数转换为下个食物的坐�??
				
				else if(food_x == head_x2 && food_y == head_y2) begin
					add_body2 <= 1;
					food_x <= random_num[10:5]%38+1;
					food_y <= random_num[4:0]%23+1;
				end   //随机数转换为下个食物的坐�?
				else begin
					add_body <= 0;
					add_body2 <= 0;
				end
			end
		end
	end
endmodule