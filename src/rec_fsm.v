module rec_fsm(clk,p_in,rst,s_out);

input rst;
input clk;
input [2:0] p_in; 

output reg [7:0] s_out;

reg [7:0] state;
reg [7:0] next_state;
//reg [7:0] s_out;

parameter [7:0] reset_state = 8'hff;
parameter [7:0] a = 8'h00;
parameter [7:0] b = 8'h01;
parameter [7:0] c = 8'h02;
parameter [7:0] d = 8'h03;
parameter [7:0] e = 8'h04;
parameter [7:0] f = 8'h05;
parameter [7:0] g = 8'h06;
parameter [7:0] h = 8'h07;
parameter [7:0] i = 8'h08;
parameter [7:0] j = 8'h09;
parameter [7:0] k = 8'h0a;
parameter [7:0] l = 8'h0b;
parameter [7:0] m = 8'h0c;
parameter [7:0] n = 8'h0d;
parameter [7:0] o = 8'h0e;
parameter [7:0] p = 8'h0f;
parameter [7:0] q = 8'h10;
parameter [7:0] r = 8'h11;
parameter [7:0] s = 8'h12;
parameter [7:0] t = 8'h13;
parameter [7:0] u = 8'h14;
parameter [7:0] v = 8'h15;
parameter [7:0] w = 8'h16;
parameter [7:0] x = 8'h17;
parameter [7:0] y = 8'h18;
parameter [7:0] z = 8'h19;

parameter [7:0] zero = 8'h20;
parameter [7:0] one = 8'h21;
parameter [7:0] two = 8'h22;
parameter [7:0] three = 8'h23;
parameter [7:0] four = 8'h24;
parameter [7:0] five = 8'h25;
parameter [7:0] six = 8'h26;
parameter [7:0] seven = 8'h27;
parameter [7:0] eight = 8'h28;
parameter [7:0] nine = 8'h29;

parameter [7:0] ds1 = 8'h2a;
parameter [7:0] ds2 = 8'h2b;
parameter [7:0] ds3 = 8'h2c;
parameter [7:0] inv = 8'hfe;

always @(posedge clk or negedge rst) begin
    if (!rst)
        state <= reset_state;
    else
        state <= next_state;
end

always @(posedge clk) begin
    next_state = state;
    s_out = 8'hff;

    case (state)
        // ---------------- reset_state ----------------
        reset_state:
        case (p_in)
            3'b000: begin next_state = state; s_out = 8'hff; end
            3'b001: begin next_state = e; s_out = 8'hff; end
            3'b010: begin next_state = t; s_out = 8'hff; end
            3'b011: begin next_state = reset_state; s_out = 8'hff; end
            3'b100: begin next_state = reset_state; s_out = 8'h20; end 
            default: begin next_state = reset_state; s_out = 8'hff; end
        endcase

        // ---------------- a ----------------
        a:
        case (p_in)
            3'b000: begin next_state = state; s_out = 8'hff; end
            3'b001: begin next_state = r; s_out = 8'hff; end
            3'b010: begin next_state = w; s_out = 8'hff; end
            3'b011: begin next_state = reset_state; s_out = 8'h61; end
            default: begin next_state = reset_state; s_out = 8'hff; end
        endcase

        // ---------------- b ----------------
        b:
        case (p_in)
            3'b000: begin next_state = state; s_out = 8'hff; end
            3'b001: begin next_state = six; s_out = 8'hff; end
            3'b010: begin next_state = inv; s_out = 8'hff; end
            3'b011: begin next_state = reset_state; s_out = 8'h62; end
            default: begin next_state = reset_state; s_out = 8'hff; end
        endcase

        // ---------------- c ----------------
        c:
        case (p_in)
            3'b000: begin next_state = state; s_out = 8'hff; end
            3'b001: begin next_state = inv; s_out = 8'hff; end
            3'b010: begin next_state = inv; s_out = 8'hff; end
            3'b011: begin next_state = reset_state; s_out = 8'h63; end
            default: begin next_state = reset_state; s_out = 8'hff; end
        endcase

        // ---------------- d ----------------
        d:
        case (p_in)
            3'b000: begin next_state = state; s_out = 8'hff; end
            3'b001: begin next_state = b; s_out = 8'hff; end
            3'b010: begin next_state = x; s_out = 8'hff; end
            3'b011: begin next_state = reset_state; s_out = 8'h64; end
            default: begin next_state = reset_state; s_out = 8'hff; end
        endcase

        // ---------------- e ----------------
        e:
        case (p_in)
            3'b000: begin next_state = state; s_out = 8'hff; end
            3'b001: begin next_state = i; s_out = 8'hff; end
            3'b010: begin next_state = a; s_out = 8'hff; end
            3'b011: begin next_state = reset_state; s_out = 8'h65; end
            default: begin next_state = reset_state; s_out = 8'hff; end
        endcase

        // ---------------- f ----------------
        f:
        case (p_in)
            3'b000: begin next_state = state; s_out = 8'hff; end
            3'b001: begin next_state = inv; s_out = 8'hff; end
            3'b010: begin next_state = inv; s_out = 8'hff; end
            3'b011: begin next_state = reset_state; s_out = 8'h66; end
            default: begin next_state = reset_state; s_out = 8'hff; end
        endcase

        // ---------------- g ----------------
        g:
        case (p_in)
            3'b000: begin next_state = state; s_out = 8'hff; end
            3'b001: begin next_state = z; s_out = 8'hff; end
            3'b010: begin next_state = q; s_out = 8'hff; end
            3'b011: begin next_state = reset_state; s_out = 8'h67; end
            default: begin next_state = reset_state; s_out = 8'hff; end
        endcase

        // ---------------- h ----------------
        h:
        case (p_in)
            3'b000: begin next_state = state; s_out = 8'hff; end
            3'b001: begin next_state = five; s_out = 8'hff; end
            3'b010: begin next_state = four; s_out = 8'hff; end
            3'b011: begin next_state = reset_state; s_out = 8'h68; end
            default: begin next_state = reset_state; s_out = 8'hff; end
        endcase

        // ---------------- i ----------------
        i:
        case (p_in)
            3'b000: begin next_state = state; s_out = 8'hff; end
            3'b001: begin next_state = s; s_out = 8'hff; end
            3'b010: begin next_state = u; s_out = 8'hff; end
            3'b011: begin next_state = reset_state; s_out = 8'h69; end
            default: begin next_state = reset_state; s_out = 8'hff; end
        endcase

        // ---------------- j ----------------
        j:
        case (p_in)
            3'b000: begin next_state = state; s_out = 8'hff; end
            3'b001: begin next_state = inv; s_out = 8'hff; end
            3'b010: begin next_state = one; s_out = 8'hff; end
            3'b011: begin next_state = reset_state; s_out = 8'h6A; end
            default: begin next_state = reset_state; s_out = 8'hff; end
        endcase

        // ---------------- k ----------------
        k:
        case (p_in)
            3'b000: begin next_state = state; s_out = 8'hff; end
            3'b001: begin next_state = c; s_out = 8'hff; end
            3'b010: begin next_state = y; s_out = 8'hff; end
            3'b011: begin next_state = reset_state; s_out = 8'h6B; end
            default: begin next_state = reset_state; s_out = 8'hff; end
        endcase

        // ---------------- l ----------------
        l:
        case (p_in)
            3'b000: begin next_state = state; s_out = 8'hff; end
            3'b001: begin next_state = inv; s_out = 8'hff; end
            3'b010: begin next_state = inv; s_out = 8'hff; end
            3'b011: begin next_state = reset_state; s_out = 8'h6C; end
            default: begin next_state = reset_state; s_out = 8'hff; end
        endcase

        // ---------------- m ----------------
        m:
        case (p_in)
            3'b000: begin next_state = state; s_out = 8'hff; end
            3'b001: begin next_state = g; s_out = 8'hff; end
            3'b010: begin next_state = o; s_out = 8'hff; end
            3'b011: begin next_state = reset_state; s_out = 8'h6D; end
            default: begin next_state = reset_state; s_out = 8'hff; end
        endcase

        // ---------------- n ----------------
        n:
        case (p_in)
            3'b000: begin next_state = state; s_out = 8'hff; end
            3'b001: begin next_state = d; s_out = 8'hff; end
            3'b010: begin next_state = k; s_out = 8'hff; end
            3'b011: begin next_state = reset_state; s_out = 8'h6E; end
            default: begin next_state = reset_state; s_out = 8'hff; end
        endcase

        // ---------------- o ----------------
        o:
        case (p_in)
            3'b000: begin next_state = state; s_out = 8'hff; end
            3'b001: begin next_state = ds2; s_out = 8'hff; end
            3'b010: begin next_state = ds1; s_out = 8'hff; end
            3'b011: begin next_state = reset_state; s_out = 8'h6F; end
            default: begin next_state = reset_state; s_out = 8'hff; end
        endcase

        // ---------------- p ----------------
        p:
        case (p_in)
            3'b000: begin next_state = state; s_out = 8'hff; end
            3'b001: begin next_state = inv; s_out = 8'hff; end
            3'b010: begin next_state = inv; s_out = 8'hff; end
            3'b011: begin next_state = reset_state; s_out = 8'h70; end
            default: begin next_state = reset_state; s_out = 8'hff; end
        endcase

        // ---------------- q ----------------
        q:
        case (p_in)
            3'b000: begin next_state = state; s_out = 8'hff; end
            3'b001: begin next_state = inv; s_out = 8'hff; end
            3'b010: begin next_state = inv; s_out = 8'hff; end
            3'b011: begin next_state = reset_state; s_out = 8'h71; end
            default: begin next_state = reset_state; s_out = 8'hff; end
        endcase

        // ---------------- r ----------------
        r:
        case (p_in)
            3'b000: begin next_state = state; s_out = 8'hff; end
            3'b001: begin next_state = l; s_out = 8'hff; end
            3'b010: begin next_state = inv; s_out = 8'hff; end
            3'b011: begin next_state = reset_state; s_out = 8'h72; end
            default: begin next_state = reset_state; s_out = 8'hff; end
        endcase

        // ---------------- s ----------------
        s:
        case (p_in)
            3'b000: begin next_state = state; s_out = 8'hff; end
            3'b001: begin next_state = h; s_out = 8'hff; end
            3'b010: begin next_state = v; s_out = 8'hff; end
            3'b011: begin next_state = reset_state; s_out = 8'h73; end
            default: begin next_state = reset_state; s_out = 8'hff; end
        endcase

        // ---------------- t ----------------
        t:
        case (p_in)
            3'b000: begin next_state = state; s_out = 8'hff; end
            3'b001: begin next_state = n; s_out = 8'hff; end
            3'b010: begin next_state = m; s_out = 8'hff; end
            3'b011: begin next_state = reset_state; s_out = 8'h74; end
            default: begin next_state = reset_state; s_out = 8'hff; end
        endcase

        // ---------------- u ----------------
        u:
        case (p_in)
            3'b000: begin next_state = state; s_out = 8'hff; end
            3'b001: begin next_state = f; s_out = 8'hff; end
            3'b010: begin next_state = ds3; s_out = 8'hff; end
            3'b011: begin next_state = reset_state; s_out = 8'h75; end
            default: begin next_state = reset_state; s_out = 8'hff; end
        endcase

        // ---------------- v ----------------
        v:
        case (p_in)
            3'b000: begin next_state = state; s_out = 8'hff; end
            3'b001: begin next_state = inv; s_out = 8'hff; end
            3'b010: begin next_state = three; s_out = 8'hff; end
            3'b011: begin next_state = reset_state; s_out = 8'h76; end
            default: begin next_state = reset_state; s_out = 8'hff; end
        endcase

        // ---------------- w ----------------
        w:
        case (p_in)
            3'b000: begin next_state = state; s_out = 8'hff; end
            3'b001: begin next_state = p; s_out = 8'hff; end
            3'b010: begin next_state = j; s_out = 8'hff; end
            3'b011: begin next_state = reset_state; s_out = 8'h77; end
            default: begin next_state = reset_state; s_out = 8'hff; end
        endcase

        // ---------------- x ----------------
        x:
        case (p_in)
            3'b000: begin next_state = state; s_out = 8'hff; end
            3'b001: begin next_state = inv; s_out = 8'hff; end
            3'b010: begin next_state = inv; s_out = 8'hff; end
            3'b011: begin next_state = reset_state; s_out = 8'h78; end
            default: begin next_state = reset_state; s_out = 8'hff; end
        endcase

        // ---------------- y ----------------
        y:
        case (p_in)
            3'b000: begin next_state = state; s_out = 8'hff; end
            3'b001: begin next_state = inv; s_out = 8'hff; end
            3'b010: begin next_state = inv; s_out = 8'hff; end
            3'b011: begin next_state = reset_state; s_out = 8'h79; end
            default: begin next_state = reset_state; s_out = 8'hff; end
        endcase

        // ---------------- z ----------------
        z:
        case (p_in)
            3'b000: begin next_state = state; s_out = 8'hff; end
            3'b001: begin next_state = seven; s_out = 8'hff; end
            3'b010: begin next_state = inv; s_out = 8'hff; end
            3'b011: begin next_state = reset_state; s_out = 8'h7A; end
            default: begin next_state = reset_state; s_out = 8'hff; end
        endcase

        // ---------------- one ----------------
        one:
        case (p_in)
            3'b000: begin next_state = state; s_out = 8'hff; end
            3'b001: begin next_state = reset_state; s_out = 8'hff; end
            3'b010: begin next_state = reset_state; s_out = 8'hff; end
            3'b011: begin next_state = reset_state; s_out = 8'h31; end
            default: begin next_state = reset_state; s_out = 8'hff; end
        endcase

        // ---------------- two ----------------
        two:
        case (p_in)
            3'b000: begin next_state = state; s_out = 8'hff; end
            3'b001: begin next_state = reset_state; s_out = 8'hff; end
            3'b010: begin next_state = reset_state; s_out = 8'hff; end
            3'b011: begin next_state = reset_state; s_out = 8'h32; end
            default: begin next_state = reset_state; s_out = 8'hff; end
        endcase

        // ---------------- three ----------------
        three:
        case (p_in)
            3'b000: begin next_state = state; s_out = 8'hff; end
            3'b001: begin next_state = reset_state; s_out = 8'hff; end
            3'b010: begin next_state = reset_state; s_out = 8'hff; end
            3'b011: begin next_state = reset_state; s_out = 8'h33; end
            default: begin next_state = reset_state; s_out = 8'hff; end
        endcase

        // ---------------- four ----------------
        four:
        case (p_in)
            3'b000: begin next_state = state; s_out = 8'hff; end
            3'b001: begin next_state = reset_state; s_out = 8'hff; end
            3'b010: begin next_state = reset_state; s_out = 8'hff; end
            3'b011: begin next_state = reset_state; s_out = 8'h34; end
            default: begin next_state = reset_state; s_out = 8'hff; end
        endcase

        // ---------------- five ----------------
        five:
        case (p_in)
            3'b000: begin next_state = state; s_out = 8'hff; end
            3'b001: begin next_state = reset_state; s_out = 8'hff; end
            3'b010: begin next_state = reset_state; s_out = 8'hff; end
            3'b011: begin next_state = reset_state; s_out = 8'h35; end
            default: begin next_state = reset_state; s_out = 8'hff; end
        endcase

        // ---------------- six ----------------
        six:
        case (p_in)
            3'b000: begin next_state = state; s_out = 8'hff; end
            3'b001: begin next_state = reset_state; s_out = 8'hff; end
            3'b010: begin next_state = reset_state; s_out = 8'hff; end
            3'b011: begin next_state = reset_state; s_out = 8'h36; end
            default: begin next_state = reset_state; s_out = 8'hff; end
        endcase

        // ---------------- seven ----------------
        seven:
        case (p_in)
            3'b000: begin next_state = state; s_out = 8'hff; end
            3'b001: begin next_state = reset_state; s_out = 8'hff; end
            3'b010: begin next_state = reset_state; s_out = 8'hff; end
            3'b011: begin next_state = reset_state; s_out = 8'h37; end
            default: begin next_state = reset_state; s_out = 8'hff; end
        endcase

        // ---------------- eight ----------------
        eight:
        case (p_in)
            3'b000: begin next_state = state; s_out = 8'hff; end
            3'b001: begin next_state = reset_state; s_out = 8'hff; end
            3'b010: begin next_state = reset_state; s_out = 8'hff; end
            3'b011: begin next_state = reset_state; s_out = 8'h38; end
            default: begin next_state = reset_state; s_out = 8'hff; end
        endcase

        // ---------------- nine ----------------
        nine:
        case (p_in)
            3'b000: begin next_state = state; s_out = 8'hff; end
            3'b001: begin next_state = reset_state; s_out = 8'hff; end
            3'b010: begin next_state = reset_state; s_out = 8'hff; end
            3'b011: begin next_state = reset_state; s_out = 8'h39; end
            default: begin next_state = reset_state; s_out = 8'hff; end
        endcase

        // ---------------- zero ----------------
        zero:
        case (p_in)
            3'b000: begin next_state = state; s_out = 8'hff; end
            3'b001: begin next_state = reset_state; s_out = 8'hff; end
            3'b010: begin next_state = reset_state; s_out = 8'hff; end
            3'b011: begin next_state = reset_state; s_out = 8'h30; end
            default: begin next_state = reset_state; s_out = 8'hff; end
        endcase

        // ---------------- ds1 ----------------
        ds1:
        case (p_in)
            3'b000: begin next_state = state; s_out = 8'hff; end
            3'b001: begin next_state = nine; s_out = 8'hff; end
            3'b010: begin next_state = zero; s_out = 8'hff; end
            3'b011: begin next_state = reset_state; s_out = 8'hff; end
            default: begin next_state = reset_state; s_out = 8'hff; end
        endcase

        // ---------------- ds2 ----------------
        ds2:
        case (p_in)
            3'b000: begin next_state = state; s_out = 8'hff; end
            3'b001: begin next_state = eight; s_out = 8'hff; end
            3'b010: begin next_state = inv; s_out = 8'hff; end
            3'b011: begin next_state = reset_state; s_out = 8'hff; end
            default: begin next_state = reset_state; s_out = 8'hff; end
        endcase

        // ---------------- ds3 ----------------
        ds3:
        case (p_in)
            3'b000: begin next_state = state; s_out = 8'hff; end
            3'b001: begin next_state = inv; s_out = 8'hff; end
            3'b010: begin next_state = two; s_out = 8'hff; end
            3'b011: begin next_state = reset_state; s_out = 8'hff; end
            default: begin next_state = reset_state; s_out = 8'hff; end
        endcase
       
       inv:
       case (p_in)
            3'b000: begin next_state = state; s_out = 8'hff; end
            3'b001: begin next_state = reset_state; s_out = 8'hff; end
            3'b010: begin next_state = reset_state; s_out = 8'hff; end
            3'b011: begin next_state = reset_state; s_out = 8'hff; end
            default: begin next_state = reset_state; s_out = 8'hff; end
        endcase
        // ---------------- default ----------------
        default:
        case (p_in)
            3'b000: begin next_state = state; s_out = 8'hff; end
            3'b001: begin next_state = reset_state; s_out = 8'hff; end
            3'b010: begin next_state = reset_state; s_out = 8'hff; end
            3'b011: begin next_state = reset_state; s_out = 8'hff; end
            3'b100: begin next_state = reset_state; s_out = 8'hff; end 
            default: begin next_state = reset_state; s_out = 8'hff; end
        endcase
    endcase
end

/*always @(posedge clk or negedge rst) begin
if(!rst)
s_out1 <= 'b0;
else
s_out1 <= s_out;
end*/
endmodule
