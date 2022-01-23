module eight_Bit_Add_Sub( //To do A + switches , S is B
input [7:0]A,
input B,
input [7:0]S, //switches
input fn,
output logic [7:0] Sum,
output logic xout
);

logic c0, c1, c2, c3, c4, c5, c6, c7, cin;
logic [7:0] BB;
logic A8, BB8;



always_comb
begin

if (~B)
BB = 8'b00; //Set BB to 0 if LSB of Register B is 0
else
BB=(S^{8{fn}});		//Otherwise set BB to itself or it's negative depending on fn
cin = fn & B; 
A8 = A[7];
BB8 = BB[7];
end
//9 bit adder
full_adder fa0 (.x(A[0]), .y(BB[0]), .cin(cin), .s(Sum[0]), .cout(c0));	//Full adder of 8
full_adder fa1 (.x(A[1]), .y(BB[1]), .cin(c0), .s(Sum[1]), .cout(c1));	//Adds, with subtract
full_adder fa2 (.x(A[2]), .y(BB[2]), .cin(c1), .s(Sum[2]), .cout(c2));	//If fn is 1
full_adder fa3 (.x(A[3]), .y(BB[3]), .cin(c2), .s(Sum[3]), .cout(c3));
full_adder fa4 (.x(A[4]), .y(BB[4]), .cin(c3), .s(Sum[4]), .cout(c4));
full_adder fa5 (.x(A[5]), .y(BB[5]), .cin(c4), .s(Sum[5]), .cout(c5));
full_adder fa6 (.x(A[6]), .y(BB[6]), .cin(c5), .s(Sum[6]), .cout(c6));
full_adder fa7 (.x(A[7]), .y(BB[7]), .cin(c6), .s(Sum[7]), .cout(c7));
full_adder fa8 (.x(A8),   .y(BB8),   .cin(c7), .s(xout),      .cout());




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

