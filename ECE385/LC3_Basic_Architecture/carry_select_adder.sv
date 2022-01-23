module carry_select_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);

    /* TODO
     *
     * Insert code here to implement a CLA adder.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
	  logic C1, cout1, cout2, cout3, cout4;
	  assign C1 = 0;
	  
	  fcarry_lookahead lg1(.x(A[3:0]), .y(B[3:0]), .cin(C1), .s3(Sum[3:0]), .cout(cout1));
	  
	  fcarry_lookahead lg2(.x(A[7:4]), .y(B[7:4]), .cin(cout1), .s3(Sum[7:4]), .cout(cout2));
	  
	  fcarry_lookahead lg3(.x(A[11:8]), .y(B[11:8]), .cin(cout2), .s3(Sum[11:8]), .cout(cout3));
	  
	  fcarry_lookahead lg4(.x(A[15:12]), .y(B[15:12]), .cin(cout3), .s3(Sum[15:12]), .cout(cout4));
	  
     assign CO = cout4;
endmodule


module fcarry_lookahead 
(
	input   logic[3:0] x,
	input   logic[3:0] y,
	input	  logic      cin,
	output  logic[3:0] s3,
	output  logic      cout
);
logic cin0, cin1, f, g, h, i, j, k;
logic [3:0]s1; 
logic [3:0]s2;
logic [1:0]cout1;

always_comb
begin
 cin0 = 0;
 cin1 = 1;
 if(cin == 1'b0) 
 begin
s3[0] = s1[0];
s3[1] = s1[1];
s3[2] = s1[2];
s3[3] = s1[3];
cout = cout1[0]; end
else begin
s3[0] = s2[0];
s3[1] = s2[1];
s3[2] = s2[2];
s3[3] = s2[3];
cout = cout1[1];
end
end

full_addery LG1 (.x(x[0]), .y(y[0]), .cin(1'b0), .s(s1[0]), .cout(f));
full_addery LG2 (.x(x[1]), .y(y[1]), .cin(f), .s(s1[1]), .cout(g));
full_addery LG3 (.x(x[2]), .y(y[2]), .cin(g), .s(s1[2]), .cout(h));
full_addery LG4 (.x(x[3]), .y(y[3]), .cin(h), .s(s1[3]), .cout(cout1[0]));

full_addery LG5 (.x(x[0]), .y(y[0]), .cin(1'b1), .s(s2[0]), .cout(i));
full_addery LG6 (.x(x[1]), .y(y[1]), .cin(i), .s(s2[1]), .cout(j));
full_addery LG7 (.x(x[2]), .y(y[2]), .cin(j), .s(s2[2]), .cout(k));
full_addery LG8 (.x(x[3]), .y(y[3]), .cin(k), .s(s2[3]), .cout(cout1[1]));


endmodule




module full_addery(
input x,
input y,
input cin, 
output logic s,
output logic cout);

	assign s=x^y^cin;
	assign cout=(x&y)|(y&cin)|(x&cin);
	
endmodule