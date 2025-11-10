module morse_top(
input wire clk,
input wire rst,
input wire dot_inp, 
input wire dash_inp, 
input wire char_space_inp, 
input wire word_space_inp,
input wire rx_cw,
output reg [7:0]sout);


wire [2:0] trans_out;
wire [7:0] serial_out;


wire rx_dot_inp; 
wire rx_dash_inp; 
wire rx_char_space_inp; 
wire rx_word_space_inp;

wire trans_dot_inp; 
wire trans_dash_inp; 
wire trans_char_space_inp; 
wire trans_word_space_inp;

assign trans_dot_inp = rx_dot_inp | dot_inp;
assign trans_dash_inp = rx_dash_inp | dash_inp;
assign trans_char_space_inp = rx_char_space_inp | char_space_inp;
assign trans_word_space_inp = rx_word_space_inp | word_space_inp;

rx_cw_m rx (.clk(clk),.rx_cw(rx_cw),.rst(rst),.dot_inp(rx_dot_inp),.dash_inp(rx_dash_inp),.char_space_inp(rx_char_space_inp),.word_space_inp(rx_word_space_inp));

trans_fsm trans (.clk(clk),.rst(rst),.dot_inp(trans_dot_inp),.dash_inp(trans_dash_inp),.char_space_inp(trans_char_space_inp),.word_space_inp(trans_word_space_inp),.parallel_out(trans_out));

rec_fsm rec(.clk(clk),.p_in(trans_out),.rst(rst),.s_out(serial_out));

always @(*) begin
sout = serial_out;
end
endmodule
