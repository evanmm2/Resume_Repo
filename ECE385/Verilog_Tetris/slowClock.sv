module slowClock( input logic clk,
						output logic slowclk1,
						output logic slowclk2
						);
			
		
		logic [3:0] counter1, counter2;
		
		
		assign slowclk1 = 1'b0;
		assign slowclk2 = 1'b0;
		
		
		
	always_ff@(posedge clk)
	begin
	counter1 = counter1 + 1;
	
		if(counter1 == 4'b1111)
			begin
			counter1 = 4'b0000;
			slowclk1 = ~slowclk1;
		end
	end
	
	always_ff@(posedge clk)
	begin
	counter1 = counter1 + 1;
	
		if(counter2 == 4'b0011)
			begin
			counter2 = 4'b0000;
			slowclk2 = ~slowclk2;
			end
		
		end
		endmodule

		