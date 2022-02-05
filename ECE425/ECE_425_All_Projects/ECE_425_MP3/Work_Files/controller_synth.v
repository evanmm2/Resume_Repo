/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : P-2019.03-SP1-1
// Date      : Fri May  1 06:32:12 2020
/////////////////////////////////////////////////////////////


module controller ( i, a, b, select_a_hi, select_b_hi, select_a_low, 
        select_b_low, f, c, p, g_lo, p_lo, ovr, z, y_tri, y_data, oe, ram0, 
        ram3, q0, q3, q0_data, q3_data, reg_wr, y_select, y_select_bar, 
        mux_input, mux_input_bar, r_select, r_select_bar, s_select, 
        s_select_bar, Q_mux_select, Q_mux_select_bar, regfile_select, 
        regfile_selecter, inv_s, inv_r, Q_en, Q_en_inv, write_en_inv );
  input [8:0] i;
  input [3:0] a;
  input [3:0] b;
  output [15:0] select_a_hi;
  output [15:0] select_b_hi;
  output [15:0] select_a_low;
  output [15:0] select_b_low;
  input [3:0] f;
  input [3:0] c;
  input [3:0] p;
  inout [3:0] y_tri;
  input [3:0] y_data;
  output [1:0] mux_input;
  output [1:0] mux_input_bar;
  output [1:0] r_select;
  output [1:0] r_select_bar;
  output [1:0] s_select;
  output [1:0] s_select_bar;
  output [1:0] Q_mux_select;
  output [1:0] Q_mux_select_bar;
  output [1:0] regfile_select;
  output [1:0] regfile_selecter;
  input oe, q0_data, q3_data;
  output g_lo, p_lo, ovr, z, reg_wr, y_select, y_select_bar, inv_s, inv_r,
         Q_en, Q_en_inv, write_en_inv;
  inout ram0,  ram3,  q0,  q3;
  wire   n1, n3, n5, n7, n9, n11, n13, n15, n17, n18, n97, n98, n99, n100,
         n101, n102, n103, n104, n105, n106, n107, n108, n109, n110, n111,
         n112, n113, n114, n115, n116, n117, n118, n119, n120, n121, n122,
         n123, n124, n125, n126, n127, n128, n129, n130, n131, n132, n133,
         n134;
  tri   [3:0] y_tri;
  tri   ram0;
  tri   ram3;
  tri   q0;
  tri   q3;

  invzp_1 drvy0 ( .ip(n7), .c(n17), .op(y_tri[0]) );
  invzp_1 drvy1 ( .ip(n5), .c(n17), .op(y_tri[1]) );
  invzp_1 drvy2 ( .ip(n3), .c(n17), .op(y_tri[2]) );
  invzp_1 drvy3 ( .ip(n1), .c(n17), .op(y_tri[3]) );
  invzp_1 drvqshr ( .ip(n15), .c(n18), .op(q0) );
  invzp_1 drvramr ( .ip(n11), .c(n18), .op(ram0) );
  invzp_1 drvqshl ( .ip(n13), .c(regfile_selecter[1]), .op(q3) );
  invzp_1 drvraml ( .ip(n9), .c(regfile_selecter[1]), .op(ram3) );
  nand4_1 U133 ( .ip1(b[1]), .ip2(b[2]), .ip3(b[3]), .ip4(b[0]), .op(
        select_b_low[15]) );
  nand4_1 U134 ( .ip1(a[1]), .ip2(a[2]), .ip3(a[3]), .ip4(a[0]), .op(
        select_a_low[15]) );
  nand2_2 U135 ( .ip1(b[3]), .ip2(b[2]), .op(n126) );
  nand2_2 U136 ( .ip1(a[3]), .ip2(a[2]), .op(n130) );
  nand2_2 U137 ( .ip1(a[0]), .ip2(a[1]), .op(n118) );
  nand2_2 U138 ( .ip1(b[0]), .ip2(b[1]), .op(n116) );
  inv_2 U139 ( .ip(n97), .op(n123) );
  inv_2 U140 ( .ip(n98), .op(n115) );
  inv_2 U141 ( .ip(n100), .op(n117) );
  inv_2 U142 ( .ip(n99), .op(n127) );
  inv_1 U143 ( .ip(i[1]), .op(n111) );
  inv_1 U144 ( .ip(i[4]), .op(n113) );
  inv_1 U145 ( .ip(i[7]), .op(n134) );
  inv_1 U146 ( .ip(regfile_select[0]), .op(regfile_selecter[0]) );
  mux2_1 U147 ( .ip1(i[0]), .ip2(n111), .s(i[2]), .op(s_select_bar[1]) );
  mux2_1 U148 ( .ip1(i[1]), .ip2(n110), .s(i[2]), .op(r_select[1]) );
  inv_1 U149 ( .ip(write_en_inv), .op(reg_wr) );
  inv_1 U150 ( .ip(c[3]), .op(g_lo) );
  nor2_1 U151 ( .ip1(n115), .ip2(n123), .op(select_b_hi[0]) );
  nor2_1 U152 ( .ip1(n116), .ip2(n123), .op(select_b_hi[3]) );
  nor2_1 U153 ( .ip1(n126), .ip2(n115), .op(select_b_hi[12]) );
  nor2_1 U154 ( .ip1(n117), .ip2(n127), .op(select_a_hi[0]) );
  nor2_1 U155 ( .ip1(n118), .ip2(n127), .op(select_a_hi[3]) );
  nor2_1 U156 ( .ip1(n130), .ip2(n117), .op(select_a_hi[12]) );
  nor2_4 U157 ( .ip1(b[2]), .ip2(b[3]), .op(n97) );
  nor2_4 U158 ( .ip1(b[0]), .ip2(b[1]), .op(n98) );
  nor2_4 U159 ( .ip1(a[2]), .ip2(a[3]), .op(n99) );
  nor2_4 U160 ( .ip1(a[0]), .ip2(a[1]), .op(n100) );
  nand2_2 U161 ( .ip1(n101), .ip2(b[2]), .op(n119) );
  nand2_2 U162 ( .ip1(n102), .ip2(a[2]), .op(n121) );
  nand2_2 U163 ( .ip1(n103), .ip2(b[0]), .op(n124) );
  nand2_2 U164 ( .ip1(n104), .ip2(b[1]), .op(n125) );
  nand2_2 U165 ( .ip1(n105), .ip2(a[0]), .op(n128) );
  nand2_2 U166 ( .ip1(n106), .ip2(a[1]), .op(n129) );
  nand2_2 U167 ( .ip1(n107), .ip2(b[3]), .op(n120) );
  nand2_2 U168 ( .ip1(n108), .ip2(a[3]), .op(n122) );
  inv_4 U169 ( .ip(b[3]), .op(n101) );
  inv_4 U170 ( .ip(a[3]), .op(n102) );
  inv_4 U171 ( .ip(b[1]), .op(n103) );
  inv_4 U172 ( .ip(b[0]), .op(n104) );
  inv_4 U173 ( .ip(a[1]), .op(n105) );
  inv_4 U174 ( .ip(a[0]), .op(n106) );
  inv_4 U175 ( .ip(b[2]), .op(n107) );
  inv_4 U176 ( .ip(a[2]), .op(n108) );
  inv_1 U177 ( .ip(i[3]), .op(n132) );
  inv_1 U178 ( .ip(q3_data), .op(n13) );
  inv_1 U179 ( .ip(Q_en), .op(Q_en_inv) );
  nor4_1 U180 ( .ip1(f[3]), .ip2(f[0]), .ip3(f[2]), .ip4(f[1]), .op(z) );
  inv_1 U181 ( .ip(select_a_low[15]), .op(select_a_hi[15]) );
  inv_1 U182 ( .ip(select_b_low[15]), .op(select_b_hi[15]) );
  nor2_1 U183 ( .ip1(n134), .ip2(i[8]), .op(regfile_select[0]) );
  nor2_1 U184 ( .ip1(regfile_selecter[0]), .ip2(i[6]), .op(y_select_bar) );
  inv_1 U185 ( .ip(y_select_bar), .op(y_select) );
  nor2_1 U186 ( .ip1(i[5]), .ip2(i[3]), .op(n109) );
  nor2_1 U187 ( .ip1(i[5]), .ip2(i[4]), .op(n131) );
  and2_1 U188 ( .ip1(i[5]), .ip2(i[4]), .op(n133) );
  nor3_1 U189 ( .ip1(n109), .ip2(n131), .ip3(n133), .op(mux_input_bar[1]) );
  inv_1 U190 ( .ip(mux_input_bar[1]), .op(mux_input[1]) );
  nor2_1 U191 ( .ip1(n113), .ip2(n109), .op(mux_input_bar[0]) );
  inv_1 U192 ( .ip(mux_input_bar[0]), .op(mux_input[0]) );
  nor2_1 U193 ( .ip1(i[1]), .ip2(i[0]), .op(n110) );
  inv_1 U194 ( .ip(r_select[1]), .op(r_select_bar[1]) );
  nor2_1 U195 ( .ip1(i[2]), .ip2(i[1]), .op(r_select[0]) );
  inv_1 U196 ( .ip(r_select[0]), .op(r_select_bar[0]) );
  inv_1 U197 ( .ip(s_select_bar[1]), .op(s_select[1]) );
  nand2_1 U198 ( .ip1(i[2]), .ip2(n111), .op(n112) );
  nand2_1 U199 ( .ip1(i[0]), .ip2(n112), .op(s_select_bar[0]) );
  inv_1 U200 ( .ip(s_select_bar[0]), .op(s_select[0]) );
  nand2_1 U201 ( .ip1(i[7]), .ip2(i[8]), .op(regfile_selecter[1]) );
  nor2_1 U202 ( .ip1(regfile_selecter[1]), .ip2(i[6]), .op(Q_mux_select[1]) );
  inv_1 U203 ( .ip(Q_mux_select[1]), .op(Q_mux_select_bar[1]) );
  nor2_1 U204 ( .ip1(i[7]), .ip2(i[8]), .op(write_en_inv) );
  nor2_1 U205 ( .ip1(reg_wr), .ip2(i[6]), .op(Q_mux_select[0]) );
  inv_1 U206 ( .ip(Q_mux_select[0]), .op(Q_mux_select_bar[0]) );
  inv_1 U207 ( .ip(regfile_selecter[1]), .op(regfile_select[1]) );
  nor2_1 U208 ( .ip1(i[6]), .ip2(regfile_select[0]), .op(Q_en) );
  inv_1 U209 ( .ip(q0_data), .op(n15) );
  inv_1 U210 ( .ip(f[3]), .op(n9) );
  inv_1 U211 ( .ip(y_data[3]), .op(n1) );
  inv_1 U212 ( .ip(y_data[2]), .op(n3) );
  inv_1 U213 ( .ip(f[0]), .op(n11) );
  inv_1 U214 ( .ip(y_data[1]), .op(n5) );
  inv_1 U215 ( .ip(y_data[0]), .op(n7) );
  inv_1 U216 ( .ip(oe), .op(n17) );
  nand4_1 U217 ( .ip1(p[2]), .ip2(p[3]), .ip3(p[0]), .ip4(p[1]), .op(p_lo) );
  mux2_1 U218 ( .ip1(c[3]), .ip2(g_lo), .s(c[2]), .op(ovr) );
  nand2_1 U219 ( .ip1(n113), .ip2(i[5]), .op(n114) );
  mux2_1 U220 ( .ip1(n114), .ip2(i[5]), .s(i[3]), .op(inv_r) );
  inv_1 U221 ( .ip(select_b_hi[0]), .op(select_b_low[0]) );
  inv_1 U222 ( .ip(select_a_hi[0]), .op(select_a_low[0]) );
  inv_1 U223 ( .ip(select_b_hi[3]), .op(select_b_low[3]) );
  inv_1 U224 ( .ip(select_a_hi[3]), .op(select_a_low[3]) );
  inv_1 U225 ( .ip(select_b_hi[12]), .op(select_b_low[12]) );
  inv_1 U226 ( .ip(select_a_hi[12]), .op(select_a_low[12]) );
  nor2_1 U227 ( .ip1(n115), .ip2(n119), .op(select_b_hi[4]) );
  inv_1 U228 ( .ip(select_b_hi[4]), .op(select_b_low[4]) );
  nor2_1 U229 ( .ip1(n116), .ip2(n119), .op(select_b_hi[7]) );
  inv_1 U230 ( .ip(select_b_hi[7]), .op(select_b_low[7]) );
  nor2_1 U231 ( .ip1(n115), .ip2(n120), .op(select_b_hi[8]) );
  inv_1 U232 ( .ip(select_b_hi[8]), .op(select_b_low[8]) );
  nor2_1 U233 ( .ip1(n116), .ip2(n120), .op(select_b_hi[11]) );
  inv_1 U234 ( .ip(select_b_hi[11]), .op(select_b_low[11]) );
  nor2_1 U235 ( .ip1(n117), .ip2(n121), .op(select_a_hi[4]) );
  inv_1 U236 ( .ip(select_a_hi[4]), .op(select_a_low[4]) );
  nor2_1 U237 ( .ip1(n118), .ip2(n121), .op(select_a_hi[7]) );
  inv_1 U238 ( .ip(select_a_hi[7]), .op(select_a_low[7]) );
  nor2_1 U239 ( .ip1(n117), .ip2(n122), .op(select_a_hi[8]) );
  inv_1 U240 ( .ip(select_a_hi[8]), .op(select_a_low[8]) );
  nor2_1 U241 ( .ip1(n118), .ip2(n122), .op(select_a_hi[11]) );
  inv_1 U242 ( .ip(select_a_hi[11]), .op(select_a_low[11]) );
  nor2_1 U243 ( .ip1(n124), .ip2(n119), .op(select_b_hi[5]) );
  inv_1 U244 ( .ip(select_b_hi[5]), .op(select_b_low[5]) );
  nor2_1 U245 ( .ip1(n125), .ip2(n119), .op(select_b_hi[6]) );
  inv_1 U246 ( .ip(select_b_hi[6]), .op(select_b_low[6]) );
  nor2_1 U247 ( .ip1(n120), .ip2(n124), .op(select_b_hi[9]) );
  inv_1 U248 ( .ip(select_b_hi[9]), .op(select_b_low[9]) );
  nor2_1 U249 ( .ip1(n120), .ip2(n125), .op(select_b_hi[10]) );
  inv_1 U250 ( .ip(select_b_hi[10]), .op(select_b_low[10]) );
  nor2_1 U251 ( .ip1(n128), .ip2(n121), .op(select_a_hi[5]) );
  inv_1 U252 ( .ip(select_a_hi[5]), .op(select_a_low[5]) );
  nor2_1 U253 ( .ip1(n129), .ip2(n121), .op(select_a_hi[6]) );
  inv_1 U254 ( .ip(select_a_hi[6]), .op(select_a_low[6]) );
  nor2_1 U255 ( .ip1(n122), .ip2(n128), .op(select_a_hi[9]) );
  inv_1 U256 ( .ip(select_a_hi[9]), .op(select_a_low[9]) );
  nor2_1 U257 ( .ip1(n122), .ip2(n129), .op(select_a_hi[10]) );
  inv_1 U258 ( .ip(select_a_hi[10]), .op(select_a_low[10]) );
  nor2_1 U259 ( .ip1(n123), .ip2(n124), .op(select_b_hi[1]) );
  inv_1 U260 ( .ip(select_b_hi[1]), .op(select_b_low[1]) );
  nor2_1 U261 ( .ip1(n123), .ip2(n125), .op(select_b_hi[2]) );
  inv_1 U262 ( .ip(select_b_hi[2]), .op(select_b_low[2]) );
  nor2_1 U263 ( .ip1(n126), .ip2(n124), .op(select_b_hi[13]) );
  inv_1 U264 ( .ip(select_b_hi[13]), .op(select_b_low[13]) );
  nor2_1 U265 ( .ip1(n126), .ip2(n125), .op(select_b_hi[14]) );
  inv_1 U266 ( .ip(select_b_hi[14]), .op(select_b_low[14]) );
  nor2_1 U267 ( .ip1(n127), .ip2(n128), .op(select_a_hi[1]) );
  inv_1 U268 ( .ip(select_a_hi[1]), .op(select_a_low[1]) );
  nor2_1 U269 ( .ip1(n127), .ip2(n129), .op(select_a_hi[2]) );
  inv_1 U270 ( .ip(select_a_hi[2]), .op(select_a_low[2]) );
  nor2_1 U271 ( .ip1(n130), .ip2(n128), .op(select_a_hi[13]) );
  inv_1 U272 ( .ip(select_a_hi[13]), .op(select_a_low[13]) );
  nor2_1 U273 ( .ip1(n130), .ip2(n129), .op(select_a_hi[14]) );
  inv_1 U274 ( .ip(select_a_hi[14]), .op(select_a_low[14]) );
  ABorC U275 ( .ip1(n133), .ip2(n132), .ip3(n131), .op(inv_s) );
  nand2_1 U276 ( .ip1(i[8]), .ip2(n134), .op(n18) );
endmodule

