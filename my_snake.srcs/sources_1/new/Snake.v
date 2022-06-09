module Snake(//蛇的运动控制
    input clk,
    input rst_n,
    
    input [3:0]cmd_out,
    input [1:0]gamestate,
    input add_body,//增加体长
    
    input add_body2,
    
    output reg [1:0] direct,

    output [5:0]head_x,
    output [4:0]head_y,//头部坐标
    
    output [5:0]head_x2,
    output [4:0]head_y2,
    
    output reg hit,//碰撞
    
    output reg hit2,
    
    output reg [999:0]map,//地图中蛇的情�??
    
    output reg [4:0] scorel,//�Ʒ�ʮλ
    output reg [4:0] scorem,//�Ʒָ�λ
    
    output reg [4:0] scorel2,//�Ʒ�ʮλ
    output reg [4:0] scorem2//�Ʒָ�λ
    
    );
    
    localparam UP = 2'b00;
    localparam DOWN = 2'b01;
    localparam LEFT = 2'b11;
    localparam RIGHT = 2'b10;
    
    localparam PRE = 2'b10;
    localparam START = 2'b01;
    
    // reg [1:0]direct;
    reg [1:0]nextdirect;
    
    reg [1:0]direct2;
    reg [1:0]nextdirect2;
    
    reg [31:0]cnt;//时钟计数变量
    
    reg [5:0]body_x[6:0];
    reg [4:0]body_y[6:0];
    reg [6:0]body;//身体是否有效
    reg [4:0]length;//体长
    
    reg [5:0]body_x2[6:0];
    reg [4:0]body_y2[6:0];
    reg [6:0]body2;//身体是否有效
    reg [4:0]length2;//体长
    
    assign head_x = body_x[0];
    assign head_y = body_y[0];
    
    assign head_x2 = body_x2[0];
    assign head_y2 = body_y2[0];
    
    always@(posedge clk or negedge rst_n)//初始方向以及方向变化
    begin
      if(!rst_n) 
      begin
        direct <= RIGHT;//默认初始向右
        direct2 <= LEFT;
      end
        
      else if(gamestate == PRE) 
      begin
        direct <= RIGHT;
        direct2 <= LEFT;
      end
      
      else 
      begin
        direct <= nextdirect;
        direct2 <= nextdirect2;
      end
    end
    
    always@(posedge clk or negedge rst_n)//运动与撞墙�?�辑
    begin
      
      if(!rst_n)//初始长度�??3，设定初始位�??
      begin
        hit <= 0;
        hit2 <= 0;
        
        body_x[0] <= 10;
        body_y[0] <= 5;//初始头部坐标
        
        body_x[1] <= 9;
        body_y[1] <= 5;
        
        body_x[2] <= 8;
        body_y[2] <= 5;
        
        body_x[3] <= 0;
        body_y[3] <= 0;
        
        body_x[4] <= 0;
        body_y[4] <= 0;
        
        body_x[5] <= 0;
        body_y[5] <= 0;
        
        body_x[6] <= 0;
        body_y[6] <= 0;
        
//        body_x[7] <= 0;
//        body_y[7] <= 0;
        
        body_x2[0] <= 30;
        body_y2[0] <= 19;//初始头部坐标
        
        body_x2[1] <= 31;
        body_y2[1] <= 19;
        
        body_x2[2] <= 32;
        body_y2[2] <= 19;
        
        body_x2[3] <= 0;
        body_y2[3] <= 0;
        
        body_x2[4] <= 0;
        body_y2[4] <= 0;
        
        body_x2[5] <= 0;
        body_y2[5] <= 0;
        
        body_x2[6] <= 0;
        body_y2[6] <= 0;
        
//        body_x2[7] <= 0;
//        body_y2[7] <= 0;
        
//        body_x[8] <= 0;
//        body_y[8] <= 0;
        
//        body_x[9] <= 0;
//        body_y[9] <= 0;
        
//        body_x[10] <= 0;
//        body_y[10] <= 0;
        
//        body_x[11] <= 0;
//        body_y[11] <= 0;
        
//        body_x[12] <= 0;
//        body_y[12] <= 0;
        
//        body_x[13] <= 0;
//        body_y[13] <= 0;
        
//        body_x[14] <= 0;
//        body_y[14] <= 0;
        
//        body_x[15] <= 0;
//        body_y[15] <= 0;
        
//        body_x[16] <= 0;
//        body_y[16] <= 0;
        
//        body_x[17] <= 0;
//        body_y[17] <= 0;
        
//        body_x[18] <= 0;
//        body_y[18] <= 0;
        
//        body_x[19] <= 0;
//        body_y[19] <= 0;
        
//        body_x[20] <= 0;
//        body_y[20] <= 0;
        
//        body_x[21] <= 0;
//        body_y[21] <= 0;
        
//        body_x[22] <= 0;
//        body_y[22] <= 0;
        
//        body_x[23] <= 0;
//        body_y[23] <= 0;
        
//        body_x[24] <= 0;
//        body_y[24] <= 0;
        
//        body_x[25] <= 0;
//        body_y[25] <= 0;
      end
      
      else if(gamestate == PRE)
      begin
        hit <= 0;
        hit2 <= 0;
        
        body_x[0] <= 10;
        body_y[0] <= 5;//初始头部坐标
        
        body_x[1] <= 9;
        body_y[1] <= 5;
        
        body_x[2] <= 8;
        body_y[2] <= 5;
        
        body_x[3] <= 0;
        body_y[3] <= 0;
        
        body_x[4] <= 0;
        body_y[4] <= 0;
        
        body_x[5] <= 0;
        body_y[5] <= 0;
        
        body_x[6] <= 0;
        body_y[6] <= 0;
        
//        body_x[7] <= 0;
//        body_y[7] <= 0;
        
        body_x2[0] <= 30;
        body_y2[0] <= 19;//初始头部坐标
        
        body_x2[1] <= 31;
        body_y2[1] <= 19;
        
        body_x2[2] <= 32;
        body_y2[2] <= 19;
        
        body_x2[3] <= 0;
        body_y2[3] <= 0;
        
        body_x2[4] <= 0;
        body_y2[4] <= 0;
        
        body_x2[5] <= 0;
        body_y2[5] <= 0;
        
        body_x2[6] <= 0;
        body_y2[6] <= 0;
        
//        body_x2[7] <= 0;
//        body_y2[7] <= 0;
        
//        body_x[8] <= 0;
//        body_y[8] <= 0;
        
//        body_x[9] <= 0;
//        body_y[9] <= 0;
        
//        body_x[10] <= 0;
//        body_y[10] <= 0;
        
//        body_x[11] <= 0;
//        body_y[11] <= 0;
        
//        body_x[12] <= 0;
//        body_y[12] <= 0;
        
//        body_x[13] <= 0;
//        body_y[13] <= 0;
        
//        body_x[14] <= 0;
//        body_y[14] <= 0;
        
//        body_x[15] <= 0;
//        body_y[15] <= 0;
        
//        body_x[16] <= 0;
//        body_y[16] <= 0;
        
//        body_x[17] <= 0;
//        body_y[17] <= 0;
        
//        body_x[18] <= 0;
//        body_y[18] <= 0;
        
//        body_x[19] <= 0;
//        body_y[19] <= 0;
        
//        body_x[20] <= 0;
//        body_y[20] <= 0;
        
//        body_x[21] <= 0;
//        body_y[21] <= 0;
        
//        body_x[22] <= 0;
//        body_y[22] <= 0;
        
//        body_x[23] <= 0;
//        body_y[23] <= 0;
        
//        body_x[24] <= 0;
//        body_y[24] <= 0;
        
//        body_x[25] <= 0;
//        body_y[25] <= 0;
      end
      
      else
      begin
        cnt <= cnt+1;
        if(cnt == 12_500_000)//每秒更新四次
        begin
          cnt <= 0;
          if(gamestate == START)
          begin
            
            if((direct == UP && body_y[0] == 1)|(direct == DOWN && body_y[0] == 23)|(direct == LEFT && body_x[0] == 1)|(direct == RIGHT && body_x[0] == 38))
              hit <= 1;//撞墙
              
            else if((direct2 == UP && body_y2[0] == 1)|(direct2 == DOWN && body_y2[0] == 23)|(direct2 == LEFT && body_x2[0] == 1)|(direct2 == RIGHT && body_x2[0] == 38))
              hit2 <= 1;//撞墙
            
            else if((body_x[0] == body_x[1] && body_y[0] == body_y[1] && body[1] == 1)|
                    (body_x[0] == body_x[2] && body_y[0] == body_y[2] && body[2] == 1)|
                    (body_x[0] == body_x[3] && body_y[0] == body_y[3] && body[3] == 1)|
                    (body_x[0] == body_x[4] && body_y[0] == body_y[4] && body[4] == 1)|
                    (body_x[0] == body_x[5] && body_y[0] == body_y[5] && body[5] == 1)|
                    (body_x[0] == body_x[6] && body_y[0] == body_y[6] && body[6] == 1)|
//                    (body_x[0] == body_x[7] && body_y[0] == body_y[7] && body[7] == 1)|
                    (body_x[0] == body_x2[1] && body_y[0] == body_y2[1] && body2[1] == 1)|
                    (body_x[0] == body_x2[2] && body_y[0] == body_y2[2] && body2[2] == 1)|
                    (body_x[0] == body_x2[3] && body_y[0] == body_y2[3] && body2[3] == 1)|
                    (body_x[0] == body_x2[4] && body_y[0] == body_y2[4] && body2[4] == 1)|
                    (body_x[0] == body_x2[5] && body_y[0] == body_y2[5] && body2[5] == 1)|
                    (body_x[0] == body_x2[6] && body_y[0] == body_y2[6] && body2[6] == 1)
//                    (body_x[0] == body_x2[7] && body_y[0] == body_y2[7] && body2[7] == 1)
//                    (body_x[0] == body_x[8] && body_y[0] == body_y[8] && body[8] == 1)|
//                    (body_x[0] == body_x[9] && body_y[0] == body_y[9] && body[9] == 1)|
//                    (body_x[0] == body_x[10] && body_y[0] == body_y[10] && body[10] == 1)|
//                    (body_x[0] == body_x[11] && body_y[0] == body_y[11] && body[11] == 1)|
//                    (body_x[0] == body_x[12] && body_y[0] == body_y[12] && body[12] == 1)|
//                    (body_x[0] == body_x[13] && body_y[0] == body_y[13] && body[13] == 1)|
//                    (body_x[0] == body_x[14] && body_y[0] == body_y[14] && body[14] == 1)
//                    (body_x[0] == body_x[15] && body_y[0] == body_y[15] && body[15] == 1)
//                    (body_x[0] == body_x[16] && body_y[0] == body_y[16] && body[16] == 1)|
//                    (body_x[0] == body_x[17] && body_y[0] == body_y[17] && body[17] == 1)|
//                    (body_x[0] == body_x[18] && body_y[0] == body_y[18] && body[18] == 1)|
//                    (body_x[0] == body_x[19] && body_y[0] == body_y[19] && body[19] == 1)|
//                    (body_x[0] == body_x[20] && body_y[0] == body_y[20] && body[20] == 1)|
//                    (body_x[0] == body_x[21] && body_y[0] == body_y[21] && body[21] == 1)|
//                    (body_x[0] == body_x[22] && body_y[0] == body_y[22] && body[22] == 1)|
//                    (body_x[0] == body_x[23] && body_y[0] == body_y[23] && body[23] == 1)|
//                    (body_x[0] == body_x[24] && body_y[0] == body_y[24] && body[24] == 1)|
//                    (body_x[0] == body_x[25] && body_y[0] == body_y[25] && body[25] == 1)
                    ) hit <= 1;//碰到身体�??
                    
                    else if((body_x2[0] == body_x2[1] && body_y2[0] == body_y2[1] && body2[1] == 1)|
                    (body_x2[0] == body_x[2] && body_y2[0] == body_y[2] && body[2] == 1)|
                    (body_x2[0] == body_x[3] && body_y2[0] == body_y[3] && body[3] == 1)|
                    (body_x2[0] == body_x[4] && body_y2[0] == body_y[4] && body[4] == 1)|
                    (body_x2[0] == body_x[5] && body_y2[0] == body_y[5] && body[5] == 1)|
                    (body_x2[0] == body_x[6] && body_y2[0] == body_y[6] && body[6] == 1)|
//                    (body_x2[0] == body_x[7] && body_y2[0] == body_y[7] && body[7] == 1)|
                    (body_x2[0] == body_x2[1] && body_y2[0] == body_y2[1] && body2[1] == 1)|
                    (body_x2[0] == body_x2[2] && body_y2[0] == body_y2[2] && body2[2] == 1)|
                    (body_x2[0] == body_x2[3] && body_y2[0] == body_y2[3] && body2[3] == 1)|
                    (body_x2[0] == body_x2[4] && body_y2[0] == body_y2[4] && body2[4] == 1)|
                    (body_x2[0] == body_x2[5] && body_y2[0] == body_y2[5] && body2[5] == 1)|
                    (body_x2[0] == body_x2[6] && body_y2[0] == body_y2[6] && body2[6] == 1)
//                    (body_x2[0] == body_x2[7] && body_y2[0] == body_y2[7] && body2[7] == 1)
                    ) hit2 <= 1;//碰到身体�??
            
            else
            begin
              body_x[1] <= body_x[0];
              body_y[1] <= body_y[0];
              
              body_x[2] <= body_x[1];
              body_y[2] <= body_y[1];
              
              body_x[3] <= body_x[2];
              body_y[3] <= body_y[2];
              
              body_x[4] <= body_x[3];
              body_y[4] <= body_y[3];
              
              body_x[5] <= body_x[4];
              body_y[5] <= body_y[4];
              
              body_x[6] <= body_x[5];
              body_y[6] <= body_y[5];
              
//              body_x[7] <= body_x[6];
//              body_y[7] <= body_y[6];
              
              body_x2[1] <= body_x2[0];
              body_y2[1] <= body_y2[0];
              
              body_x2[2] <= body_x2[1];
              body_y2[2] <= body_y2[1];
              
              body_x2[3] <= body_x2[2];
              body_y2[3] <= body_y2[2];
              
              body_x2[4] <= body_x2[3];
              body_y2[4] <= body_y2[3];
              
              body_x2[5] <= body_x2[4];
              body_y2[5] <= body_y2[4];
              
              body_x2[6] <= body_x2[5];
              body_y2[6] <= body_y2[5];
              
//              body_x2[7] <= body_x2[6];
//              body_y2[7] <= body_y2[6];
              
//              body_x[8] <= body_x[7];
//              body_y[8] <= body_y[7];
              
//              body_x[9] <= body_x[8];
//              body_y[9] <= body_y[8];
              
//              body_x[10] <= body_x[9];
//              body_y[10] <= body_y[9];
              
//              body_x[11] <= body_x[10];
//              body_y[11] <= body_y[10];
              
//              body_x[12] <= body_x[11];
//              body_y[12] <= body_y[11];
              
//              body_x[13] <= body_x[12];
//              body_y[13] <= body_y[12];
              
//              body_x[14] <= body_x[13];
//              body_y[14] <= body_y[13];
              
//              body_x[15] <= body_x[14];
//              body_y[15] <= body_y[14];
              
//              body_x[16] <= body_x[15];
//              body_y[16] <= body_y[15];
              
//              body_x[17] <= body_x[16];
//              body_y[17] <= body_y[16];
              
//              body_x[18] <= body_x[17];
//              body_y[18] <= body_y[17];
              
//              body_x[19] <= body_x[18];
//              body_y[19] <= body_y[18];
              
//              body_x[20] <= body_x[19];
//              body_y[20] <= body_y[19];
              
//              body_x[21] <= body_x[20];
//              body_y[21] <= body_y[20];
              
//              body_x[22] <= body_x[21];
//              body_y[22] <= body_y[21];
              
//              body_x[23] <= body_x[22];
//              body_y[23] <= body_y[22];
              
//              body_x[24] <= body_x[23];
//              body_y[24] <= body_y[23];
              
//              body_x[25] <= body_x[24];
//              body_y[25] <= body_y[24];//身体运动逻辑
              
              case(direct)
                UP:
                begin
                  if(body_y[0] == 1) hit <= 1;
                  else body_y[0] <= body_y[0]-1;
                end
                
                DOWN:
                begin
                  if(body_y[0] == 24) hit <= 1;
                  else body_y[0] <= body_y[0]+1;
                end
                
                RIGHT:
                begin
                  if(body_x[0] == 39) hit <= 1;
                  else body_x[0] <= body_x[0]+1;
                end
                
                LEFT:
                begin
                  if(body_x[0] == 1) hit <= 1;
                  else body_x[0] <= body_x[0]-1;
                end//头的移动逻辑
                
              endcase
              
              case(direct2)
                UP:
                begin
                  if(body_y2[0] == 1) hit2 <= 1;
                  else body_y2[0] <= body_y2[0]-1;
                end
                
                DOWN:
                begin
                  if(body_y2[0] == 24) hit2 <= 1;
                  else body_y2[0] <= body_y2[0]+1;
                end
                
                RIGHT:
                begin
                  if(body_x2[0] == 39) hit2 <= 1;
                  else body_x2[0] <= body_x2[0]+1;
                end
                
                LEFT:
                begin
                  if(body_x2[0] == 1) hit2 <= 1;
                  else body_x2[0] <= body_x2[0]-1;
                end//头的移动逻辑
                
              endcase
            
            end
            
          end
        end
      end
      
    end
    
    always@(*)//按键控制逻辑
    begin
      nextdirect = direct;
      nextdirect2 = direct2;
      
      case(direct)
        UP:
        begin
          if(cmd_out == 4'b0011) nextdirect = LEFT;
          else if(cmd_out == 4'b0100) nextdirect = RIGHT;
          else nextdirect = UP;
        end
        
        DOWN:
        begin
          if(cmd_out == 4'b0011) nextdirect = LEFT;
          else if(cmd_out == 4'b0100) nextdirect = RIGHT;
          else nextdirect = DOWN;
        end
        
        RIGHT:
        begin
          if(cmd_out == 4'b0001) nextdirect = UP;
          else if(cmd_out == 4'b0010) nextdirect = DOWN;
          else nextdirect = RIGHT;
        end
        
        LEFT:
        begin
          if(cmd_out == 4'b0001) nextdirect = UP;
          else if(cmd_out == 4'b0010) nextdirect = DOWN;
          else nextdirect = LEFT;
        end
      endcase
      
      case(direct2)
        UP:
        begin
          if(cmd_out == 4'b0111) nextdirect2 = LEFT;
          else if(cmd_out == 4'b1000) nextdirect2 = RIGHT;
          else nextdirect2 = UP;
        end
        
        DOWN:
        begin
          if(cmd_out == 4'b0111) nextdirect2 = LEFT;
          else if(cmd_out == 4'b1000) nextdirect2 = RIGHT;
          else nextdirect2 = DOWN;
        end
        
        RIGHT:
        begin
          if(cmd_out == 4'b0101) nextdirect2 = UP;
          else if(cmd_out == 4'b0110) nextdirect2 = DOWN;
          else nextdirect2 = RIGHT;
        end
        
        LEFT:
        begin
          if(cmd_out == 4'b0101) nextdirect2 = UP;
          else if(cmd_out == 4'b0110) nextdirect2 = DOWN;
          else nextdirect2 = LEFT;
        end
      endcase
    end
    
    reg add_body_state;
    reg add_body_state2;
    
    always@(posedge clk or negedge rst_n)//变长逻辑
    begin
      if(!rst_n)
      begin
        body <= 7'd7;
        body2 <= 7'd7;
        length <= 3;
        length2 <= 3;
        scorel <= 0;
        scorem <= 0;
        scorel2 <= 0;
        scorem2 <= 0;
        add_body_state <= 0;
      end
      
      else if(gamestate == PRE)
      begin
        body <= 7'd7;
        body2 <= 7'd7;
        length <= 3;
        length2 <= 3;
        scorel <= 0;
        scorem <= 0;
        scorel2 <= 0;
        scorem2 <= 0;
        add_body_state <= 0;
      end
      
      else
      begin
        case(add_body_state)
        0:
        begin
          if(add_body)
          begin
            if(scorel==9) begin
              scorel<=0;
              if(scorem==9) scorem<=0;
              else scorem<=scorem+1;
            end
            else scorel<=scorel+1;

            if(length <= 6)
            begin
              length <= length+1;
              body[length] <= 1;
              add_body_state <= 1;
            end
          end
        end
        
        1:
        begin
          if(!add_body)
          begin
            add_body_state <= 0;
          end
        end
        
        endcase
        
        case(add_body_state2)
        0:
        begin
          if(add_body2)
          begin
            if(scorel2==9) begin
              scorel2<=0;
              if(scorem2==9) scorem2<=0;
              else scorem2<=scorem2+1;
            end
            else scorel2<=scorel2+1;
            if(length2 <= 6)
            begin
              length2 <= length2+1;
              body2[length2] <= 1;
              add_body_state2 <= 1;
            end
          end
        end
        
        1:
        begin
          if(!add_body2)
          begin
            add_body_state2 <= 0;
          end
        end
        
        endcase
      end
    end
    
    always@(posedge clk or negedge rst_n)
    begin
      if(!rst_n) map <= 0;
      else if(gamestate == PRE) map <= 0;
      
      else
      begin
        map <= 0;
        if(body[0]) map[body_x[0]+body_y[0]*40] <= 1;
        if(body[1]) map[body_x[1]+body_y[1]*40] <= 1;
        if(body[2]) map[body_x[2]+body_y[2]*40] <= 1;
        if(body[3]) map[body_x[3]+body_y[3]*40] <= 1;
        if(body[4]) map[body_x[4]+body_y[4]*40] <= 1;
        if(body[5]) map[body_x[5]+body_y[5]*40] <= 1;
        if(body[6]) map[body_x[6]+body_y[6]*40] <= 1;
//        if(body[7]) map[body_x[7]+body_y[7]*40] <= 1;
        
        if(body2[0]) map[body_x2[0]+body_y2[0]*40] <= 1;
        if(body2[1]) map[body_x2[1]+body_y2[1]*40] <= 1;
        if(body2[2]) map[body_x2[2]+body_y2[2]*40] <= 1;
        if(body2[3]) map[body_x2[3]+body_y2[3]*40] <= 1;
        if(body2[4]) map[body_x2[4]+body_y2[4]*40] <= 1;
        if(body2[5]) map[body_x2[5]+body_y2[5]*40] <= 1;
        if(body2[6]) map[body_x2[6]+body_y2[6]*40] <= 1;
//        if(body2[7]) map[body_x2[7]+body_y2[7]*40] <= 1;
//        if(body[8]) map[body_x[8]+body_y[8]*40] <= 1;
//        if(body[9]) map[body_x[9]+body_y[9]*40] <= 1;
//        if(body[10]) map[body_x[10]+body_y[10]*40] <= 1;
//        if(body[11]) map[body_x[11]+body_y[11]*40] <= 1;
//        if(body[12]) map[body_x[12]+body_y[12]*40] <= 1;
//        if(body[13]) map[body_x[13]+body_y[13]*40] <= 1;
//        if(body[14]) map[body_x[14]+body_y[14]*40] <= 1;
//        if(body[15]) map[body_x[10]+body_y[15]*40] <= 1;
//        if(body[16]) map[body_x[10]+body_y[16]*40] <= 1;
//        if(body[17]) map[body_x[10]+body_y[17]*40] <= 1;
//        if(body[18]) map[body_x[10]+body_y[18]*40] <= 1;
//        if(body[19]) map[body_x[10]+body_y[19]*40] <= 1;
//        if(body[20]) map[body_x[10]+body_y[20]*40] <= 1;
//        if(body[21]) map[body_x[10]+body_y[21]*40] <= 1;
//        if(body[22]) map[body_x[10]+body_y[22]*40] <= 1;
//        if(body[23]) map[body_x[10]+body_y[23]*40] <= 1;
//        if(body[24]) map[body_x[10]+body_y[24]*40] <= 1;
//        if(body[25]) map[body_x[10]+body_y[25]*40] <= 1;
        
      end
    end
    
endmodule