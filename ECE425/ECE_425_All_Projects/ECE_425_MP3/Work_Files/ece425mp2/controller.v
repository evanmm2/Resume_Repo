// ECE 425 MP2: Verilog RTL for Am2901 controller
// Rev 2/17/08

module controller(
	i,					// opcode (add your decoded signals)
	a,b,select_a_hi,select_b_hi, select_a_low, select_b_low,		// decoding of register addresses
	f,c,p,g_lo,p_lo,ovr,z,			// generation of ALU outputs
	y_tri,y_data,oe,			// tristate control of y bus
	ram0,ram3,		// tristate control of RAM shifter
	q0,q3,q0_data,q3_data,			// tristate control of Q shifter
	reg_wr,      //add additiona signals for your design here
	y_select, y_select_bar, mux_input, mux_input_bar, r_select, r_select_bar, 
	s_select, s_select_bar, Q_mux_select, Q_mux_select_bar, regfile_select, 
	regfile_selecter, inv_s, inv_r,
	Q_en, Q_en_inv, write_en_inv
);

 // define I/O for synthesized control
input [8:0] i;
input [3:0] a, b;
output [15:0] select_a_hi, select_b_hi, select_a_low, select_b_low;
input [3:0] f, c, p;
output g_lo, p_lo, ovr, z;
inout [3:0] y_tri;
input [3:0] y_data;
input oe;
inout ram0, ram3, q0, q3;
input q0_data, q3_data;
output reg [1:0] mux_input, mux_input_bar, r_select, r_select_bar;
output reg [1:0] s_select, s_select_bar, Q_mux_select, Q_mux_select_bar, regfile_select;
output reg [1:0] regfile_selecter;
output reg inv_s, inv_r;
output reg reg_wr;    //define additional I/Os for your design
output reg Q_en, Q_en_inv, write_en_inv, y_select, y_select_bar;


 // named internal wires carry reusable subexpressions
wire shift_left, shift_right;

 // "assign" statements give us algebraic expressions
assign select_a_hi = 16'h0001 << a;
assign select_b_hi = 16'h0001 << b;
assign select_a_low = ~select_a_hi;
assign select_b_low = ~select_b_hi;
assign shift_left = i[8] & i[7];
assign shift_right = i[8] & ~ i[7];


 // simpler functionality is better implemented directly in logic gates
buf calcg(	g_lo,	~c[3] ); // glitchy with lookahead carry propagation, but shouldn't matter for us :v)
nand calcp(	p_lo,	p[3], p[2], p[1], p[0] );
xor calcovr(	ovr,	c[3], c[2] );
nor calczero(	z,	f[3], f[2], f[1], f[0] );

bufif1 drvy3(	y_tri[3],y_data[3], oe );
bufif1 drvy2(	y_tri[2],y_data[2], oe );
bufif1 drvy1(	y_tri[1],y_data[1], oe );
bufif1 drvy0(	y_tri[0],y_data[0], oe );
bufif1 drvraml( ram3,	f[3], shift_left );
bufif1 drvramr( ram0,	f[0], shift_right );
bufif1 drvqshl( q3,	q3_data, shift_left );
bufif1 drvqshr( q0,	q0_data, shift_right );


 // add your control signals here...


always @ * begin
case (i[2:0])
	3'b000: begin
			r_select = 2'b01;
			s_select = 2'b10;
			end
	3'b001: begin
			r_select = 2'b01;
			s_select = 2'b01;
		   end
	3'b010: begin
			r_select = 2'b10;
			s_select = 2'b10;
		   end
	3'b011: begin
			r_select = 2'b10;
			s_select = 2'b01;
		   end
	3'b100: begin
			r_select = 2'b10;
			s_select = 2'b00;
		   end
	3'b101: begin
			r_select = 2'b00;
			s_select = 2'b00;
		   end
	3'b110: begin
			r_select = 2'b00;
			s_select = 2'b10;
		   end
	3'b111: begin
			r_select = 2'b00;
			s_select = 2'b11;
		   end
	default: begin 
			r_select = 2'b00;
			s_select = 2'b00;
			end
	endcase
case (i[5:3])
	3'b000: begin
			inv_r = 1'b1;
			inv_s = 1'b1;
			mux_input = 2'b11;
			end
	3'b001: begin
			inv_r = 1'b0;
			inv_s = 1'b1;
			mux_input = 2'b11;
			end
	3'b010: begin
			inv_r = 1'b1;
			inv_s = 1'b0;
			mux_input = 2'b11;
			end
	3'b011: begin
			inv_r = 1'b0;
			inv_s = 1'b0;
			mux_input = 2'b00;
			end
	3'b100: begin
			inv_r = 1'b0;
			inv_s = 1'b0;
			mux_input = 2'b01;
			end
	3'b101: begin
			inv_r = 1'b1;
			inv_s = 1'b0;
			mux_input = 2'b01;
			end
	3'b110: begin
			inv_r = 1'b1;
			inv_s = 1'b1;
			mux_input = 2'b10;
			end
	3'b111: begin
			inv_r = 1'b1;
			inv_s = 1'b0;
			mux_input = 2'b10;
			end
	default: begin
			inv_r = 1'b0;
			inv_s = 1'b0;
			mux_input = 2'b00;
			end
endcase

case(i[8:6])
	3'b000: begin
			regfile_select = 2'b00;
			Q_mux_select = 	 2'b01;	
			y_select = 1'b1;
			Q_en = 1'b1;
			reg_wr = 1'b0;
			end
	3'b001: begin
			regfile_select = 2'b00;
			Q_mux_select = 	 2'b00;
			y_select = 1'b1;
			Q_en = 1'b0;
			reg_wr = 1'b0;
			end
	3'b010:begin
			regfile_select = 2'b01;
			Q_mux_select = 2'b00;
			y_select = 1'b0;
			Q_en = 1'b0;
			reg_wr = 1'b1;
			end
	3'b011: begin
			regfile_select = 2'b01;
			Q_mux_select = 2'b00;
			y_select = 1'b1;
			Q_en = 1'b0;
			reg_wr = 1'b1;
			end
	3'b100: begin
			Q_mux_select = 	 2'b00;
			regfile_select = 2'b00;
			y_select = 1'b1;
			reg_wr = 1'b1;
			Q_en = 1'b1;
			end
	3'b101: begin
			Q_mux_select = 2'b00;
			regfile_select = 2'b00;
			y_select = 1'b1;
			Q_en = 1'b0;
			reg_wr = 1'b1;
			end
	3'b110: begin
			Q_mux_select = 	 2'b10;
			regfile_select = 2'b10;
			y_select = 1'b1;
			reg_wr = 1'b1;
			Q_en = 1'b1;
			end
	3'b111: begin
			Q_mux_select = 2'b00;
			regfile_select = 2'b10;
			y_select = 1'b1;
			Q_en = 1'b0;
			reg_wr = 1'b1;
			end
default: begin
			Q_mux_select = 	 2'b11;
			regfile_select = 2'b11;
			y_select = 1'b1;
			reg_wr = 1'b0;
			Q_en = 1'b0;
			end
	endcase
r_select_bar = ~r_select;
s_select_bar = ~s_select;
y_select_bar = ~y_select;
mux_input_bar = ~mux_input;
Q_mux_select_bar = ~Q_mux_select;
regfile_selecter = ~regfile_select;
write_en_inv = ~reg_wr;
Q_en_inv = ~Q_en;
end


endmodule

