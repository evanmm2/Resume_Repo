/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module  frameRAM
(
		
		input [9:0] read_address,
		input Clk,
		input [4:0] Shape,
		input [7:0]index,
		output logic [23:0] data_Out, data_Out2
);

// mem has width of 3 bits and a total of 400 addresses
logic [23:0] IPiece [0:255];
logic [23:0] SquarePiece [0:255];
logic [23:0] LPiece [0:255];
logic [23:0] JPiece [0:255];
logic [23:0] ZPiece [0:255];
logic [23:0] SPiece [0:255];
logic [23:0] TPiece [0:255];
logic [23:0] Background [0:255];



initial
begin
	 $readmemh("sprite_bytes/CyanBlock.txt", IPiece);
	 $readmemh("sprite_bytes/OrangeBlockDone.txt", SquarePiece);
	 $readmemh("sprite_bytes/BlueBlock.txt", LPiece);
	 $readmemh("sprite_bytes/YellowBlock.txt", JPiece);
	 $readmemh("sprite_bytes/RedBlock.txt", ZPiece);
	 $readmemh("sprite_bytes/LimeBlock.txt", SPiece);
	 $readmemh("sprite_bytes/PurpleBlock.txt", TPiece);
	 $readmemh("sprite_bytes/Background.txt", Background);
end


always_ff @ (posedge Clk) begin
	data_Out2<= Background[index];

	if(Shape == 1 || Shape == 2)
	data_Out<= IPiece[read_address];
	else if(Shape == 3)
	data_Out<= SquarePiece[read_address];
	else if(Shape == 4 || Shape == 5 || Shape == 6 || Shape == 7)
	data_Out<= LPiece[read_address];
	else if(Shape == 8 || Shape == 9 || Shape == 10 || Shape == 11)
	data_Out<= JPiece[read_address];
	else if(Shape == 12 || Shape == 13)
	data_Out<= ZPiece[read_address];
	else if(Shape == 14 || Shape == 15)
	data_Out<= SPiece[read_address];
	else if(Shape == 16 || Shape == 17 || Shape == 18 || Shape == 19)
	data_Out<= TPiece[read_address];
	else 
	data_Out<= IPiece[read_address];

end

endmodule
