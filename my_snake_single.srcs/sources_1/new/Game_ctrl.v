module Game_ctrl(//游戏状态的控制
    input clk,
    input rst_n,
    input [3:0] cmd_out,
    input hit,
    
    output reg [1:0]gamestate
    );
    
    localparam PRE = 2'b10;
    localparam START = 2'b01;
//    localparam PLAY = 2'b11;
    localparam DIE = 2'b11;
    
    always@(posedge clk or negedge rst_n)
    begin
      if(!rst_n)
      begin
        gamestate <= PRE;
      end
      
      else
      begin
        case(gamestate)
        
          PRE:
          begin
            if(cmd_out <= 4'b1000 && cmd_out >= 4'b0001) gamestate <= START;
            // if(cmd_out == 4'b0100) gamestate <= START;
            else gamestate <= PRE;
          end
          
          START:
          begin
            if(hit) gamestate <= DIE;
            else gamestate <= START;
          end
          
          DIE:
          begin
            if(cmd_out <= 4'b1000 && cmd_out >= 4'b0001) gamestate <= PRE;
            // if(cmd_out == 4'b0100) gamestate <= PRE;
            else gamestate <= DIE;
          end
        
        endcase
      end
    end
    
endmodule