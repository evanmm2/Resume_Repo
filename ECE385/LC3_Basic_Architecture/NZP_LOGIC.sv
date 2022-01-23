module NZP_IN_LOGIC (input logic [15:0] BUS,
							output logic Nin, Zin, Pin);
			always_comb
			begin
			if(BUS[15] == 1)
				begin
					Nin = 1;
					Zin = 0;
					Pin = 0;
			end
			else if(BUS == 4'h0000)
				begin
					Nin = 0;
					Zin = 1;
					Pin = 0;
			end
				else
					begin
						Nin = 0;
						Zin = 0;
						Pin = 1;
				end
			end	
endmodule


module NZP_OUT_LOGIC (input logic Nin, Zin, Pin,
							 input logic [2:0] IR,
							 output logic Jump_Bit);
		
		always_comb
		begin
			if(Nin)
				begin
					if(IR[2] == Nin)
						begin
							Jump_Bit = 1;
						end
						end
			else if(Zin)
				begin
					if(IR[1] == Zin)
						begin
							Jump_Bit = 1;
						end	
						end
			else if(Pin)
				begin
					if(IR[0] == Pin)
						begin
							Jump_Bit = 1;
						end	
						end
			else	
				begin
				Jump_Bit = 0;
				end
			end	 
endmodule
							 
							 