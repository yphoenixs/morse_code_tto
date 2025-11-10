module trans_fsm(
    dot_inp, 
    dash_inp, 
    char_space_inp, 
    word_space_inp,
    parallel_out, 
    clk,
    rst
);

//////////////  INPUTS   /////////////////
input dot_inp;
input dash_inp;
input char_space_inp;
input word_space_inp;
input clk;
input rst;

// We need more states now, so we use a 4-bit register
reg [2:0] state = 3'b000; 

//////////// OUTPUTS /////////////////
output reg [2:0] parallel_out;

////////// parameters /////////
// Main States
parameter [2:0] s_idle       = 3'b000;
parameter [2:0] s_dot        = 3'b001;
parameter [2:0] s_dash       = 3'b010;
parameter [2:0] s_char     = 3'b011;
parameter [2:0] s_word     = 3'b100;

always@(posedge clk or negedge rst)
begin
    if(!rst) begin
        state <= s_idle;
        parallel_out <= 'd0;
    end
    else begin
        case(state)
            s_idle:
            begin
                parallel_out <= 3'b000; // Inter-element space
                if (dot_inp)
                    state <= s_dot;
                else if (dash_inp)
                    state <= s_dash;
                else if (char_space_inp && word_space_inp) begin
                    parallel_out <= 3'b100;
                    state <= s_word;
                    end
                else if (char_space_inp)
                    state <= s_char; // Start the 3-cycle character space
                else if (word_space_inp)
                    state <= s_word; // Start the 7-cycle word space
                else
                    state <= s_idle;
            end

            s_dot:  begin parallel_out <= 3'b001; state <= s_idle; end
            s_dash: begin parallel_out <= 3'b010; state <= s_idle; end
            s_char: begin parallel_out <= 3'b011; state <= s_idle;   end // Return to idle
            s_word: begin parallel_out <= 3'b100; state <= s_idle;   end // Return to idle
            
            default:
                state <= s_idle;
        endcase
    end
end
endmodule
