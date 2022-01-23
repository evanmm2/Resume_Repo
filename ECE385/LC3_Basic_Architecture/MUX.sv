module Mux2 #(parameter muxwidth = 16)
(
input logic [muxwidth-1:0] d0, d1,
input logic s,
output logic [muxwidth - 1:0] y);
//Simple mux for 2 inputs
always_comb begin
if (s)
	y=d1;
else
	y=d0;
end
endmodule

module Mux4 #(parameter muxwidth = 16) (
input logic [muxwidth-1:0] d0, d1, d2, d3,
input logic [1:0]s,
output logic [muxwidth -1:0] y);
//simple mux for 4 inputs
always_comb begin
if (s==2'h0)
y=d0;
else if (s== 2'h1)
y= d1;
else if (s == 2'h2)
y= d2;
else
y= d3;
end
endmodule

module GateMux (
input logic [15:0]PC, Adder, ALU, MDR,
input logic [3:0]Selector,
output logic [15:0]BUS);
//Gate selector mux
always_comb
begin
case(Selector)

				4'b1000:
					BUS = PC;
				4'b0100:
					BUS = Adder;
				4'b0010:
					BUS = ALU;			
				4'b0001:
					BUS = MDR;
				default: 
					BUS = 16'h0;
			endcase
		end

endmodule



