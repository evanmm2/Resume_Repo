
module ALUK( input [15:0] A, B,
				 input [1:0]Selector,
				 output [15:0] OUTPUT
);
always_comb
begin
case(Selector)
	1'h0:begin
	end
	1'h1:begin
	OUTPUT = A&B;
	end
	1'h2:begin
	OUTPUT = ~A;
	end
	1'h3:begin
	OUTPUT=A;
	end
	endcase
end
	carry_select_adder(.A(A), .B(B), .Sum(OUTPUT), .C0());

endmodule

