// ECE 425 MP2 Verilog testbench
// Rev 9/20/07

module Am2901(cp,i,cin,cout,g_lo,p_lo,ovr,z,f3,d,y,a,b,ram0,ram3,q0,q3,oe);

 // define chip pins
input cp;		// clock
input [8:0] i;		// opcode
input cin;		// carry-in
output cout;		// carry-out
output g_lo, p_lo;	// carry-lookahead generate, propagate outputs
output ovr, z, f3;	// overflow, zero compare, MSB from ALU
input [3:0] d;		// data input
output [3:0] y;		// data output
input [3:0] a, b;	// register (RAM) addresses
inout ram0, ram3;	// right, left sides of RAM shift register
inout q0, q3;		// right, left sides of Q shift register
input oe;		// tristate enable for y (we keep it enabled)
 // -- total pins including vdd/gnd: 40 -- //

 // define signals between control and datapath
wire [15:0] select_a_hi, select_b_hi, select_b_low, select_a_low;
wire [3:0] f, c, p, y_data;
wire q0_data, q3_data;
wire reg_wr;
wire y_select, y_select_bar;
wire [1:0] Q_mux_select, Q_mux_select_bar, mux_input_bar, mux_input, s_select, s_select_bar, r_select,r_select_bar, regfile_select;
wire [1:0] regfile_selecter;
wire inv_s, inv_r, Q_en, Q_en_inv, write_en_inv;
 // DON'T add extra logic here - 
	// the Am2901 module only ties together the controller + datapath.
 // DO add extra signals tied directly between the controller + datapath -
	// the more work done in the controller, the simpler & faster your design.

assign cout = c[3];
assign f3 = f[3];

controller control ( // instantiate either RTL (MP2) or synthesized logic (MP3)
	.i(i),								// opcode
	.reg_wr(reg_wr),								// (add your decoded signals)
	.a(a), .b(b), .select_a_hi(select_a_hi), .select_b_hi(select_b_hi),	.select_a_low(select_a_low), .select_b_low(select_b_low),// decoding of register addresses
	.f(f), .c(c), .p(p), .g_lo(g_lo), .p_lo(p_lo), .ovr(ovr), .z(z),	// generation of ALU outputs
	.y_tri(y), .y_data(y_data), .oe(oe), 				// tristate control of y bus
	.ram0(ram0), .ram3(ram3),						// tristate control of RAM shifter
	.q0(q0), .q3(q3), .q0_data(q0_data), .q3_data(q3_data),		// tristate control of Q shifter
	.y_select(y_select), .y_select_bar(y_select_bar), .mux_input(mux_input), .mux_input_bar(mux_input_bar), .r_select(r_select), .r_select_bar(r_select_bar), 
	.s_select(s_select), .s_select_bar(s_select_bar), .Q_mux_select(Q_mux_select), .Q_mux_select_bar(Q_mux_select_bar), .regfile_select(regfile_select), 
	.regfile_selecter(regfile_selecter), .inv_s(inv_s), .inv_r(inv_r),
	.Q_en(Q_en), .Q_en_inv(Q_en_inv), .write_en_inv(write_en_inv)
);

datapath data ( // instantiate your design schematics from Virtuoso
	.cp(cp), 						// clock
	.reg_wr(reg_wr), 					// (add your decoded signals)
	.select_a_hi(select_a_hi),  .select_b_hi(select_b_hi), .select_b_low(select_b_low), .select_a_low(select_a_low), // decoded register selects (feel free to add more)
	.d(d), .cin(cin),						// datapath inputs
	.f(f), .c(c), .p(p),	 				// ALU outputs
	.y(y_data), 						// global chip output
	.q0_out(q0_data), .q3_out(q3_data), 			// shift register outputs
	.f0_in(ram0), .f3_in(ram3), .q0_in(q0), .q3_in(q3),		// shift register inputs
	.y_select(y_select), .y_select_bar(y_select_bar), .mux_input(mux_input), .mux_input_bar(mux_input_bar), .r_select(r_select), .r_select_bar(r_select_bar), 
	.s_select(s_select), .s_select_bar(s_select_bar), .Q_mux_select(Q_mux_select), .Q_mux_select_bar(Q_mux_select_bar), .regfile_select(regfile_select), 
	.regfile_selecter(regfile_selecter), .inv_s(inv_s), .inv_r(inv_r), .clock_inv(~cp),
	.Q_en(Q_en), .Q_en_inv(Q_en_inv), .write_en_inv(write_en_inv)
);

endmodule
