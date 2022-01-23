module flipflop (
input logic [15:0]data, 
input logic Clk, Reset, Load,
output logic [15:0]outdata);
					
			always_ff @ (posedge Clk)
			begin
			if (Reset)
			outdata <=16'h0000;
			else if (Load)
			outdata[15:0] <= data[15:0];
			else 
			outdata[15:0] <= outdata[15:0];
			end
			
			
endmodule 

module NZP (input logic Clk, Load, Reset, Nin, Zin, Pin,
output logic Pout, Zout, Nout
);
always_ff @ (posedge Clk)
begin
if (Reset)
begin
Pout <= 1'b0;
Zout <= 1'b0;
Nout <= 1'b0;
end
else if (Load)
begin
Pout <= Pin;
Zout <= Zin;
Nout <= Nin;
end
else
begin
Pout <= Pout;
Zout <= Zout;
Nout <= Nout;
end
end

endmodule 


<<<<<<< HEAD

module register_file (input [15:0] A,
							 input [2:0] DRMUX, SR2, SR1MUX, 
							 input LD_REG,
							 output [15:0] SR1_OUT, SR2_OUT)
							 flipflop R0 (.Clk(Clk), .data(), .Reset(), .Load(), .outdata(R0_OUT));
=======
module register_file (input  logic [15:0] A,
							 input  logic [2:0] DRMUX, SR2, SR1MUX, 
							 input  logic LD_REG, Reset,
							 input  logic Clk,
							 output logic  [15:0] SR1_OUT, SR2_OUT);
							 
		logic [3:0] R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out;
		logic LD0, LD1, LD2, LD3, LD4, LD5, LD6, LD7;
							
always_comb
begin
unique case(SR1MUX)
3'b000:
	SR1_OUT = R0out;
3'b001:
	SR1_OUT = R1out;
3'b010:
	SR1_OUT = R2out;
3'b011:
	SR1_OUT = R3out;
3'b100:
	SR1_OUT = R4out;
3'b101:
	SR1_OUT = R5out;
3'b110:
	SR1_OUT = R6out;
3'b111:
	SR1_OUT = R7out;	
endcase
unique case(SR2)
3'b000:
	SR2_OUT = R0out;
3'b001:
	SR2_OUT = R1out;
3'b010:
	SR2_OUT = R2out;
3'b011:
	SR2_OUT = R3out;
3'b100:
	SR2_OUT = R4out;
3'b101:
	SR2_OUT = R5out;
3'b110:
	SR2_OUT = R6out;
3'b111:
	SR2_OUT = R7out;	
endcase
>>>>>>> 64ccc2aeba759f25c292ab7adbd4d7c92b2574a3

if (LD_REG)
begin
unique case (DRMUX)
		3'h0: LD0 = 1'b1;
		3'h1: LD1 = 1'b1;
		3'h2: LD2 = 1'b1;
		3'h3: LD3 = 1'b1;
		3'h4: LD4 = 1'b1;
		3'h5: LD5 = 1'b1;
		3'h6: LD6 = 1'b1;
		3'h7: LD7 = 1'b1;

			
endcase
end
end

flipflop R0 (.Clk(Clk), .data(A), .Reset(Reset), .Load(LD0), .outdata(R0out));

flipflop R1 (.Clk(Clk), .data(A), .Reset(Reset), .Load(LD1), .outdata(R1out));

flipflop R2 (.Clk(Clk), .data(A), .Reset(Reset), .Load(LD2), .outdata(R2out));

flipflop R3 (.Clk(Clk), .data(A), .Reset(Reset), .Load(LD3),  .outdata(R3out));

flipflop R4 (.Clk(Clk), .data(A), .Reset(Reset), .Load(LD4), .outdata(R4out));

flipflop R5 (.Clk(Clk), .data(A), .Reset(Reset), .Load(LD5), .outdata(R5out));

flipflop R6 (.Clk(Clk), .data(A), .Reset(Reset), .Load(LD6), .outdata(R6out));

flipflop R7 (.Clk(Clk), .data(A), .Reset(Reset), .Load(LD7), .outdata(R7out));


endmodule
							