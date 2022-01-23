module SEXT5 (input logic[10:0] INPUT,
				  output logic [15:0] OUTPUT);
				  
				  always_comb
					begin
				   OUTPUT[10:0] = INPUT[10:0];
					if(INPUT[10])
					OUTPUT[15:11] = 5'b11111;
					else
					OUTPUT[15:11] = 5'b00000;
					end
				  
				  
				  endmodule
				  
module SEXT7 (input logic[8:0] INPUT,
				  output logic [15:0] OUTPUT);
				  
				  always_comb
					begin
				   OUTPUT[8:0] = INPUT[8:0];
					if(INPUT[8])
					OUTPUT[15:9] = 7'b1111111;
					else
					OUTPUT[15:9] = 7'b0000000;
					end
				  
				  
				  endmodule
				  
module SEXT10 (input logic[5:0] INPUT,
				  output logic [15:0] OUTPUT);
				  
				  always_comb
					begin
				   OUTPUT[5:0] = INPUT[5:0];
					if(INPUT[5])
					OUTPUT[15:6] = 10'b1111111111;
					else
					OUTPUT[15:6] = 10'b0000000000;
					end
				  
				  
				  endmodule
				  
module SEXT11 (input logic[4:0] INPUT,
				  output logic [15:0] OUTPUT);
				  
				  always_comb
					begin
				   OUTPUT[4:0] = INPUT[4:0];
					if(INPUT[5])
					OUTPUT[15:5] = 11'b11111111111;
					else
					OUTPUT[15:5] = 11'b00000000000;
					end
				  
				  
				  endmodule
				  

					