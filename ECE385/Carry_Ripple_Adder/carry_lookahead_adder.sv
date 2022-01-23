module carry_lookahead_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);

    /* TODO
     *
     * Insert code here to implement a carry select.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
 
logic C0, C4, C8, C12, G0, P0, G4, P4, G8, P8, G12, P12;

always_comb
begin

C0  = 0;
C4  =  (G0) | (C0 & P0);
C8  =  (G4) | (G0 & P4) | (C0 & P0 & P4);
C12 =  (G8) | (G8 & P8) | (G0 & P8 & P4) | (C0 & P8 & P4 & P0);
end



	  four_bit_sa FSA0(.x(A[3:0]), .y(B[3:0]), .cin (0),  .S(Sum[3:0]), .gO(G0), .pO(P0));
	  four_bit_sa FSA1(.x(A[7:4]), .y(B[7:4]), .cin (C4), .S(Sum[7:4]), .gO(G4), .pO(P4));
	  four_bit_sa FSA2(.x(A[11:8]), .y(B[11:8]), .cin (C8), .S(Sum[11:8]), .gO(G8), .pO(P8));
	  four_bit_sa FSA3(.x(A[15:12]), .y(B[15:12]), .cin (C12), .S(Sum[15:12]), .gO(G12), .pO(P12), .CO(CO));
	  
endmodule



module four_bit_sa(
input [3:0]x,
input [3:0]y,
input cin,
output logic [3:0]S,
output logic gO,
output logic pO,
output logic CO
);
logic c0, c1, c2, c3, g0, g1, g2, g3, p0, p1, p2, p3;

always_comb
begin

g0 = x[0] & y[0];
g1 = x[1] & y[1];
g2 = x[2] & y[2];
g3 = x[3] & y[3];

gO = g3 | (g2 & p3) | (g1 & p3 & p2) | (g0 & p3 & p2 & p1);

p0 = x[0] | y[0];
p1 = x[1] | y[1];
p2 = x[2] | y[2];
p3 = x[3] | y[3];

pO= (p0 & p1 & p2 & p3);

c0 = cin;
c1 = (cin & p0) | g0;
c2 = (cin & p0 & p1)  | (g0 & p1 )| (g1); 
c3 = (cin & p0 & p1 & p2) | (g0 & p1& p2) | (g1 & p2) | g2;
end
full_adder FA0 (.x(x[0]), .y(y[0]), .cin(c0), .s(S[0]));
full_adder FA1 (.x(x[1]), .y(y[1]), .cin(c1), .s(S[1]));
full_adder FA2 (.x(x[2]), .y(y[2]), .cin(c2), .s(S[2]));
full_adder FA3 (.x(x[3]), .y(y[3]), .cin(c3), .s(S[3]), .cout(CO));

endmodule

module full_adder(
input x,
input y,
input cin, 
output logic s,
output logic cout);

	assign s=x^y^cin;
	assign cout=(x&y)|(y&cin)|(x&cin);
	
endmodule

