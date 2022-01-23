/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module  scoreRAM
(
		
		input Clk,
		input [3:0] Score,
		input [7:0]	scoreAddress,
		output logic [23:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [23:0] One [0:255];
logic [23:0] Two [0:255];
logic [23:0] Three [0:255];
logic [23:0] Four [0:255];
logic [23:0] Five [0:255];
logic [23:0] Six [0:255];
logic [23:0] Seven [0:255];
logic [23:0] Eight [0:255];
logic [23:0] Nine [0:255];
logic [23:0] Zero [0:255];



initial
begin
	 $readmemh("Number1Done.txt", One);
	 $readmemh("Number2Done.txt", Two);
	 $readmemh("Number3Done.txt", Three);
	 $readmemh("Number4Done.txt", Four);
	 $readmemh("Number5Done.txt", Five);
	 $readmemh("Number6Done.txt", Six);
	 $readmemh("Number7Done.txt", Seven);
	 $readmemh("Number8Done.txt", Eight);
 	 $readmemh("Number9Done.txt", Nine);
	 $readmemh("Number0Done.txt", Zero);

	 
end


always_ff @ (posedge Clk) begin

	if(Score == 0)
	data_Out<= Zero[scoreAddress];
	else if(Score == 1)
	data_Out<= One[scoreAddress];
	else if(Score == 2)
	data_Out<= Two[scoreAddress];
	else if(Score == 3)
	data_Out<= Three[scoreAddress];
	else if(Score == 4)
	data_Out<= Four[scoreAddress];
	else if(Score == 5)
	data_Out<= Five[scoreAddress];
	else if(Score == 6)
	data_Out<= Six[scoreAddress];
	else if(Score == 7)
	data_Out<= Seven[scoreAddress];
	else if(Score == 8)
	data_Out<= Eight[scoreAddress];
	else if(Score == 9)
	data_Out<= Nine[scoreAddress];
end

endmodule
