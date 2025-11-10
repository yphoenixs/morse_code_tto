module rx_cw_m (
    clk,
    rx_cw,
    rst,
    dot_inp,
    dash_inp,
    char_space_inp,
    word_space_inp
);

//////////////  INPUTS   /////////////////
input clk;
input rx_cw;
input rst;

output reg dot_inp;
output reg dash_inp;
output reg char_space_inp;
output reg word_space_inp;

reg [1:0] a_state;

parameter [1:0] nop = 0;
parameter [1:0] when_up = 1;
parameter [1:0] when_down = 2;
parameter [1:0] send_space = 2;

reg [3:0] up_times;
reg [3:0] down_times;

always@(posedge clk)
begin

  if(!rst) begin
    dot_inp <= 0;
    dash_inp <= 0;
    char_space_inp <= 0;
    word_space_inp <= 0;
    a_state <= nop;
    up_times <= 0;
    down_times <= 0;
  end else begin

    case(a_state)
      nop: begin
        dot_inp <= 0;
        dash_inp <= 0;
        char_space_inp <= 0;
        word_space_inp <= 0;
        a_state <= nop;
        up_times <= 0;
        down_times <= 0;

        if(rx_cw) begin
          if(up_times < 7) up_times <= up_times + 1;

          a_state <= when_up;
        end
      end
      when_up: begin
        if(up_times < 7) up_times <= up_times + 1;

        if(up_times == 0) begin
          char_space_inp <= 0;
          word_space_inp <= 0;
          down_times <= 0;
        end

        if(!rx_cw) begin
          a_state <= when_down;

          if(up_times <= 3) dot_inp <= 1;
          else dash_inp <= 1;
        end
      end
      when_down: begin
        if(down_times == 0) begin
          dot_inp <= 0;
          dash_inp <= 0;
          up_times <= 0;
        end

        if(down_times == 7) begin
          char_space_inp <= 1;

          a_state <= nop;
        end

        if(down_times < 7) down_times <= down_times + 1;


        if(rx_cw) begin
          //if(down_times > 4) begin
          //  char_space_inp <= 1;
          //  word_space_inp <= 0;

          //  a_state <= send_space;
          if(down_times > 1) begin
            char_space_inp <= 1;

            a_state <= when_up;
          end else begin
            a_state <= when_up;
          end

        end
      end
      send_space: begin
        if(up_times < 7) up_times <= up_times + 1;

        char_space_inp <= 0;
        word_space_inp <= 1;

        a_state <= nop;
      end
      default: begin a_state <= nop; end
    endcase;
  end
end
endmodule
