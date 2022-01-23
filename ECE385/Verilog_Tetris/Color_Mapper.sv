//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Po-Han Huang  10-06-2017                               --
//                                                                       --
//    Fall 2017 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 8                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------

// color_mapper: Decide which color to be output to VGA for each pixel.
module  color_mapper (            // Whether current pixel belongs to ball 
                       input					Clk,                 //   or background (computed in ball.sv)
                       input               // Current pixel coordinates
							  input			[4:0]	Shape,
							  input 			[9:0] Block_X_Pos, Block_Y_Pos,
							  input			start, lost,
							  input 			[9:0][19:0][4:0] Tetris_Array,
							  input 			[3:0] Single, Tens, Hundreds, Thousands, TenThousands,
                       output logic [7:0] VGA_R, VGA_G, VGA_B // VGA RGB output
                     );
    
    logic [7:0] Red, Green, Blue;
    
    // Output colors to VGA
    assign VGA_R = Red;
    assign VGA_G = Green;
    assign VGA_B = Blue;

    logic [9:0] X_Pos_Arr1, Y_Pos_Arr1;
	
	 

	
	 
	 logic [23:0] /*databoi0, databoi1, databoi2,*/ databoi3, databoi4, databoi5, databoi6,
	 scoreOne, scoreTwo, scoreThree, scoreFour, scoreFive, Background, A/*, B, C, D*/;
	 
	 logic [4:0] blockwidth;
	 assign blockwidth = 16;
	 logic [10:0] StartAddress, EndAddress;
	 logic shape_on;
	 logic[9:0] shape_x;
	 logic[9:0] shape_y;
	 logic[10:0] shape_size_x = 16;
	 logic[10:0] shape_size_y = 16;
	// logic[9:0] read_address0, read_address1, read_address2, read_address3;
	 logic[7:0] index;				
	 //logic[23:0] sprite_data;
	 
	 assign shape_x = Block_X_Pos;
	 assign shape_y = Block_Y_Pos;
//	 
//	frameRAM rammieboi0(.*, .read_address(read_address0), .data_Out(databoi0), .data_Out2(B));
//	frameRAM rammieboi1(.*, .read_address(read_address1), .data_Out(databoi1), .data_Out2(C));
//	frameRAM rammieboi2(.*, .read_address(read_address2), .data_Out(databoi2), .data_Out2(D));
	frameRAM rammieboi3(.*, .read_address(index), .data_Out(databoi3), .data_Out2(Background));
	frameRAM rammieboi4(.*, .Shape(backShape), .read_address(index), .data_Out(databoi4), .data_Out2(A));
	scoreRAM rammieboi5(.*, .Score(Single), .scoreAddress(index) 		 ,	.data_Out(scoreOne));
	scoreRAM rammieboi6(.*, .Score(Tens), .scoreAddress(index)			 ,	.data_Out(scoreTwo));
	scoreRAM rammieboi7(.*, .Score(Hundreds), .scoreAddress(index)  	 ,	.data_Out(scoreThree));
	scoreRAM rammieboi8(.*, .Score(Thousands), .scoreAddress(index) 	 ,	.data_Out(scoreFour));
	scoreRAM rammieboi9(.*, .Score(TenThousands), .scoreAddress(index) , .data_Out(scoreFive));
	startRAM	rammieboi10(.*, .data_Out(databoi5));
	endRAM	rammieboi11(.*, .data_Out(databoi6));
	 	//These change the address. Each address is a pixel
	 
	logic[4:0] backShape;
	

//	logic [9:0][19:0][3:0] Tetris_Array ;				// Should be an upside down T-Piece.
//	assign Tetris_Array [9][19] = 4'b0001;
//	assign Tetris_Array [8][19] = 4'b0001;
//	assign Tetris_Array [7][19] = 4'b0001;
//	assign Tetris_Array [6][19] = 4'b0001;
//	assign Tetris_Array [5][19] = 4'b0001;
//	assign Tetris_Array [4][19] = 4'b0001;
//	assign Tetris_Array [3][19] = 4'b0001;
//	assign Tetris_Array [2][19] = 4'b0001;
//	assign Tetris_Array [1][19] = 4'b0001;
//	assign Tetris_Array [0][19] = 4'b0001;

	
	
always_comb
begin
	 
	 index 		= (DrawX - 250) % blockwidth + ((DrawY - 100)%blockwidth)*blockwidth;
	 X_Pos_Arr1 = ((DrawX - 250)/blockwidth);
	 Y_Pos_Arr1 = ((DrawY - 100)/blockwidth);
	 backShape = 4'b0;
	 StartAddress = (DrawX-287)+(DrawY-255)*88;
	 EndAddress = StartAddress;
if(start)
begin
	if(DrawX > 286 && DrawX < 374 && DrawY > 254 && DrawY < 266)
	begin
				Red	= 	databoi5[23:16];
				Green	=	databoi5[15:8];
				Blue 	=	databoi5[7:0];
	end
	else
	begin
				Red = 8'h00; 
            Green = 8'h00;
            Blue = 8'h00;
	end
end

else if(lost)
begin
	if(DrawX < 250 || DrawX > 506 || (DrawX > 426 && (DrawY < 132 || DrawY > 148)) || (DrawX > 410 && DrawX < 427)|| DrawY < 100 || DrawY > 420)
        begin
            Red = 8'h00; 
            Green = 8'h00;
            Blue = 8'h00;
        end
		else if(DrawX > 426 && DrawX <= 442)
		begin 
				Red	= 	scoreFive[23:16];
				Green	=	scoreFive[15:8];
				Blue 	=	scoreFive[7:0];

		end
		else if(DrawX > 442 && DrawX <= 458)
		begin
				Red	= 	scoreFour[23:16];
				Green	=	scoreFour[15:8];
				Blue 	=	scoreFour[7:0];

		end
		else if(DrawX > 458 && DrawX <= 474)
		begin
				Red	= 	scoreThree[23:16];
				Green	=	scoreThree[15:8];
				Blue 	=	scoreThree[7:0];
		end
		else if(DrawX > 474 && DrawX <= 490)
		begin
				Red	= 	scoreTwo[23:16];
				Green	=	scoreTwo[15:8];
				Blue 	=	scoreTwo[7:0];
		end
		else if(DrawX > 490 && DrawX <=506)
		begin
				Red	= 	scoreOne[23:16];
				Green	=	scoreOne[15:8];
				Blue 	=	scoreOne[7:0];		
		end
	else if(DrawX > 286 && DrawX < 374 && DrawY > 254 && DrawY < 266)
		begin
				Red	= 	databoi6[23:16];
				Green	=	databoi6[15:8];
				Blue 	=	databoi6[7:0];
		end
	else
		begin
				Red = 8'h00; 
            Green = 8'h00;
            Blue = 8'h00;
	end
end

else
begin
	 if(Shape == 1)
	 begin

		
		
			if(DrawX >= shape_x && DrawX < shape_x + shape_size_x && DrawY >= shape_y
			&& DrawY < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if(DrawX >= shape_x && DrawX < shape_x + shape_size_x && (DrawY-16) >= shape_y
			&& (DrawY-16) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if(DrawX >= shape_x && DrawX < shape_x + shape_size_x && (DrawY-32) >= shape_y
			&& (DrawY-32) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if(DrawX >= shape_x && DrawX < shape_x + shape_size_x && (DrawY-48) >= shape_y
			&& (DrawY-48) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if(DrawX < 250 || DrawX > 506 || (DrawX > 426 && (DrawY < 132 || DrawY > 148)) || (DrawX > 410 && DrawX < 427)|| DrawY < 100 || DrawY > 420)
        begin
            Red = 8'h00; 
            Green = 8'h00;
            Blue = 8'h00;
        end
		else if(DrawX > 426 && DrawX <= 442)
		begin 
				Red	= 	scoreFive[23:16];
				Green	=	scoreFive[15:8];
				Blue 	=	scoreFive[7:0];

		end
		else if(DrawX > 442 && DrawX <= 458)
		begin
				Red	= 	scoreFour[23:16];
				Green	=	scoreFour[15:8];
				Blue 	=	scoreFour[7:0];

		end
		else if(DrawX > 458 && DrawX <= 474)
		begin
				Red	= 	scoreThree[23:16];
				Green	=	scoreThree[15:8];
				Blue 	=	scoreThree[7:0];
		end
		else if(DrawX > 474 && DrawX <= 490)
		begin
				Red	= 	scoreTwo[23:16];
				Green	=	scoreTwo[15:8];
				Blue 	=	scoreTwo[7:0];
		end
		else if(DrawX > 490 && DrawX <=506)
		begin
				Red	= 	scoreOne[23:16];
				Green	=	scoreOne[15:8];
				Blue 	=	scoreOne[7:0];		
		end
		else if(Tetris_Array[X_Pos_Arr1][Y_Pos_Arr1] > 0)
			begin
				backShape = Tetris_Array[X_Pos_Arr1][Y_Pos_Arr1];
				Red	= 	databoi4[23:16];
				Green	=	databoi4[15:8];
				Blue 	=	databoi4[7:0];
			end
		else 
			begin
				Red   =  Background[23:16];
				Green =  Background[15:8];
				Blue  =  Background[7:0];
			end
		
	end
else if(Shape == 2)
		begin

		
		
		
			if(DrawX >= shape_x && DrawX < shape_x + shape_size_x && DrawY >= shape_y
			&& DrawY < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX - 16) >= shape_x && (DrawX - 16) < shape_x + shape_size_x && (DrawY) >= shape_y
			&& (DrawY) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX - 32) >= shape_x && (DrawX - 32) < shape_x + shape_size_x && (DrawY) >= shape_y
			&& (DrawY) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX - 48) >= shape_x && (DrawX - 48) < shape_x + shape_size_x && (DrawY) >= shape_y
			&& (DrawY) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if(DrawX < 250 || DrawX > 506 || (DrawX > 426 && (DrawY < 132 || DrawY > 148)) || (DrawX > 410 && DrawX < 427)|| DrawY < 100 || DrawY > 420)
        begin
            Red = 8'h00; 
            Green = 8'h00;
            Blue = 8'h00;
        end
		else if(DrawX > 426 && DrawX <= 442)
		begin 
				Red	= 	scoreFive[23:16];
				Green	=	scoreFive[15:8];
				Blue 	=	scoreFive[7:0];

		end
		else if(DrawX > 442 && DrawX <= 458)
		begin
				Red	= 	scoreFour[23:16];
				Green	=	scoreFour[15:8];
				Blue 	=	scoreFour[7:0];

		end
		else if(DrawX > 458 && DrawX <= 474)
		begin
				Red	= 	scoreThree[23:16];
				Green	=	scoreThree[15:8];
				Blue 	=	scoreThree[7:0];
		end
		else if(DrawX > 474 && DrawX <= 490)
		begin
				Red	= 	scoreTwo[23:16];
				Green	=	scoreTwo[15:8];
				Blue 	=	scoreTwo[7:0];
		end
		else if(DrawX > 490 && DrawX <=506)
		begin
				Red	= 	scoreOne[23:16];
				Green	=	scoreOne[15:8];
				Blue 	=	scoreOne[7:0];		
		end
		else if(Tetris_Array[X_Pos_Arr1][Y_Pos_Arr1] > 0)
			begin
				backShape = Tetris_Array[X_Pos_Arr1][Y_Pos_Arr1];
				Red	= 	databoi4[23:16];
				Green	=	databoi4[15:8];
				Blue 	=	databoi4[7:0];
			end
		else 
			begin
				Red   =  Background[23:16];
				Green =  Background[15:8];
				Blue  =  Background[7:0];
			end
		
	end
else if(Shape == 3)
		begin
		
 

		
			if(DrawX >= shape_x && DrawX < shape_x + shape_size_x && DrawY >= shape_y
			&& DrawY < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX - 16) >= shape_x && (DrawX - 16) < shape_x + shape_size_x && (DrawY) >= shape_y
			&& (DrawY) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX) >= shape_x && (DrawX) < shape_x + shape_size_x && (DrawY-16) >= shape_y
			&& (DrawY-16) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX - 16) >= shape_x && (DrawX - 16) < shape_x + shape_size_x && (DrawY-16) >= shape_y
			&& (DrawY-16) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if(DrawX < 250 || DrawX > 506 || (DrawX > 426 && (DrawY < 132 || DrawY > 148)) || (DrawX > 410 && DrawX < 427)|| DrawY < 100 || DrawY > 420)
        begin
            Red = 8'h00; 
            Green = 8'h00;
            Blue = 8'h00;
        end
		else if(DrawX > 426 && DrawX <= 442)
		begin 
				Red	= 	scoreFive[23:16];
				Green	=	scoreFive[15:8];
				Blue 	=	scoreFive[7:0];

		end
		else if(DrawX > 442 && DrawX <= 458)
		begin
				Red	= 	scoreFour[23:16];
				Green	=	scoreFour[15:8];
				Blue 	=	scoreFour[7:0];

		end
		else if(DrawX > 458 && DrawX <= 474)
		begin
				Red	= 	scoreThree[23:16];
				Green	=	scoreThree[15:8];
				Blue 	=	scoreThree[7:0];
		end
		else if(DrawX > 474 && DrawX <= 490)
		begin
				Red	= 	scoreTwo[23:16];
				Green	=	scoreTwo[15:8];
				Blue 	=	scoreTwo[7:0];
		end
		else if(DrawX > 490 && DrawX <=506)
		begin
				Red	= 	scoreOne[23:16];
				Green	=	scoreOne[15:8];
				Blue 	=	scoreOne[7:0];		
		end
		else if(Tetris_Array[X_Pos_Arr1][Y_Pos_Arr1] > 0)
			begin
				backShape = Tetris_Array[X_Pos_Arr1][Y_Pos_Arr1];
				Red	= 	databoi4[23:16];
				Green	=	databoi4[15:8];
				Blue 	=	databoi4[7:0];
			end
		else 
			begin
				Red   =  Background[23:16];
				Green =  Background[15:8];
				Blue  =  Background[7:0];
			end
		
	end
else if(Shape == 4)
		begin



			if(DrawX >= shape_x && DrawX < shape_x + shape_size_x && DrawY >= shape_y
			&& DrawY < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX) >= shape_x && (DrawX) < shape_x + shape_size_x && (DrawY-16) >= shape_y
			&& (DrawY-16) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX) >= shape_x && (DrawX) < shape_x + shape_size_x && (DrawY-32) >= shape_y
			&& (DrawY-32) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX - 16) >= shape_x && (DrawX - 16) < shape_x + shape_size_x && (DrawY-32) >= shape_y
			&& (DrawY-32) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if(DrawX < 250 || DrawX > 506 || (DrawX > 426 && (DrawY < 132 || DrawY > 148)) || (DrawX > 410 && DrawX < 427)|| DrawY < 100 || DrawY > 420)
        begin
            Red = 8'h00; 
            Green = 8'h00;
            Blue = 8'h00;
        end
		else if(DrawX > 426 && DrawX <= 442)
		begin 
				Red	= 	scoreFive[23:16];
				Green	=	scoreFive[15:8];
				Blue 	=	scoreFive[7:0];

		end
		else if(DrawX > 442 && DrawX <= 458)
		begin
				Red	= 	scoreFour[23:16];
				Green	=	scoreFour[15:8];
				Blue 	=	scoreFour[7:0];

		end
		else if(DrawX > 458 && DrawX <= 474)
		begin
				Red	= 	scoreThree[23:16];
				Green	=	scoreThree[15:8];
				Blue 	=	scoreThree[7:0];
		end
		else if(DrawX > 474 && DrawX <= 490)
		begin
				Red	= 	scoreTwo[23:16];
				Green	=	scoreTwo[15:8];
				Blue 	=	scoreTwo[7:0];
		end
		else if(DrawX > 490 && DrawX <=506)
		begin
				Red	= 	scoreOne[23:16];
				Green	=	scoreOne[15:8];
				Blue 	=	scoreOne[7:0];		
		end
		else if(Tetris_Array[X_Pos_Arr1][Y_Pos_Arr1] > 0)
			begin
				backShape = Tetris_Array[X_Pos_Arr1][Y_Pos_Arr1];
				Red	= 	databoi4[23:16];
				Green	=	databoi4[15:8];
				Blue 	=	databoi4[7:0];
			end
		else 
			begin
				Red   =  Background[23:16];
				Green =  Background[15:8];
				Blue  =  Background[7:0];
			end
		
	end
else if(Shape == 5)				//Current
		begin

			if(DrawX >= shape_x && DrawX < shape_x + shape_size_x && DrawY >= shape_y
			&& DrawY < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX - 16) >= shape_x && (DrawX - 16) < shape_x + shape_size_x && (DrawY) >= shape_y
			&& (DrawY) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX - 32) >= shape_x && (DrawX - 32) < shape_x + shape_size_x && (DrawY) >= shape_y
			&& (DrawY) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX) >= shape_x && (DrawX) < shape_x + shape_size_x && (DrawY - 16) >= shape_y
			&& (DrawY - 16) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if(DrawX < 250 || DrawX > 506 || (DrawX > 426 && (DrawY < 132 || DrawY > 148)) || (DrawX > 410 && DrawX < 427)|| DrawY < 100 || DrawY > 420)
        begin
            Red = 8'h00; 
            Green = 8'h00;
            Blue = 8'h00;
        end
		else if(DrawX > 426 && DrawX <= 442)
		begin 
				Red	= 	scoreFive[23:16];
				Green	=	scoreFive[15:8];
				Blue 	=	scoreFive[7:0];

		end
		else if(DrawX > 442 && DrawX <= 458)
		begin
				Red	= 	scoreFour[23:16];
				Green	=	scoreFour[15:8];
				Blue 	=	scoreFour[7:0];

		end
		else if(DrawX > 458 && DrawX <= 474)
		begin
				Red	= 	scoreThree[23:16];
				Green	=	scoreThree[15:8];
				Blue 	=	scoreThree[7:0];
		end
		else if(DrawX > 474 && DrawX <= 490)
		begin
				Red	= 	scoreTwo[23:16];
				Green	=	scoreTwo[15:8];
				Blue 	=	scoreTwo[7:0];
		end
		else if(DrawX > 490 && DrawX <=506)
		begin
				Red	= 	scoreOne[23:16];
				Green	=	scoreOne[15:8];
				Blue 	=	scoreOne[7:0];		
		end
		else if(Tetris_Array[X_Pos_Arr1][Y_Pos_Arr1] > 0)
			begin
				backShape = Tetris_Array[X_Pos_Arr1][Y_Pos_Arr1];
				Red	= 	databoi4[23:16];
				Green	=	databoi4[15:8];
				Blue 	=	databoi4[7:0];
			end
		else 
			begin
				Red   =  Background[23:16];
				Green =  Background[15:8];
				Blue  =  Background[7:0];
			end
	end
else if(Shape == 6)	//Current
		begin
		


			if(DrawX >= shape_x && DrawX < shape_x + shape_size_x && DrawY >= shape_y
			&& DrawY < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX-16) >= shape_x && (DrawX-16) < shape_x + shape_size_x && (DrawY) >= shape_y
			&& (DrawY) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX - 16) >= shape_x && (DrawX - 16) < shape_x + shape_size_x && (DrawY-16) >= shape_y
			&& (DrawY-16) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX-16) >= shape_x && (DrawX-16) < shape_x + shape_size_x && (DrawY-32) >= shape_y
			&& (DrawY-32) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
else if(DrawX < 250 || DrawX > 506 || (DrawX > 426 && (DrawY < 132 || DrawY > 148)) || (DrawX > 410 && DrawX < 427)|| DrawY < 100 || DrawY > 420)
        begin
            Red = 8'h00; 
            Green = 8'h00;
            Blue = 8'h00;
        end
		else if(DrawX > 426 && DrawX <= 442)
		begin 
				Red	= 	scoreFive[23:16];
				Green	=	scoreFive[15:8];
				Blue 	=	scoreFive[7:0];

		end
		else if(DrawX > 442 && DrawX <= 458)
		begin
				Red	= 	scoreFour[23:16];
				Green	=	scoreFour[15:8];
				Blue 	=	scoreFour[7:0];

		end
		else if(DrawX > 458 && DrawX <= 474)
		begin
				Red	= 	scoreThree[23:16];
				Green	=	scoreThree[15:8];
				Blue 	=	scoreThree[7:0];
		end
		else if(DrawX > 474 && DrawX <= 490)
		begin
				Red	= 	scoreTwo[23:16];
				Green	=	scoreTwo[15:8];
				Blue 	=	scoreTwo[7:0];
		end
		else if(DrawX > 490 && DrawX <=506)
		begin
				Red	= 	scoreOne[23:16];
				Green	=	scoreOne[15:8];
				Blue 	=	scoreOne[7:0];		
		end
		else if(Tetris_Array[X_Pos_Arr1][Y_Pos_Arr1] > 0)
			begin
				backShape = Tetris_Array[X_Pos_Arr1][Y_Pos_Arr1];
				Red	= 	databoi4[23:16];
				Green	=	databoi4[15:8];
				Blue 	=	databoi4[7:0];
			end
		else 
			begin
				Red   =  Background[23:16];
				Green =  Background[15:8];
				Blue  =  Background[7:0];
			end
	end
else if(Shape == 7)	//Current
		begin
		


			if(DrawX-32 >= shape_x && DrawX-32 < shape_x + shape_size_x && (DrawY) >= shape_y
			&& (DrawY) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX) >= shape_x && (DrawX) < shape_x + shape_size_x && (DrawY-16) >= shape_y
			&& (DrawY-16) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX - 16) >= shape_x && (DrawX - 16) < shape_x + shape_size_x && (DrawY-16) >= shape_y
			&& (DrawY-16) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX-32) >= shape_x && (DrawX-32) < shape_x + shape_size_x && (DrawY-16) >= shape_y
			&& (DrawY-16) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if(DrawX < 250 || DrawX > 506 || (DrawX > 426 && (DrawY < 132 || DrawY > 148)) || (DrawX > 410 && DrawX < 427)|| DrawY < 100 || DrawY > 420)
        begin
            Red = 8'h00; 
            Green = 8'h00;
            Blue = 8'h00;
        end
		else if(DrawX > 426 && DrawX <= 442)
		begin 
				Red	= 	scoreFive[23:16];
				Green	=	scoreFive[15:8];
				Blue 	=	scoreFive[7:0];

		end
		else if(DrawX > 442 && DrawX <= 458)
		begin
				Red	= 	scoreFour[23:16];
				Green	=	scoreFour[15:8];
				Blue 	=	scoreFour[7:0];

		end
		else if(DrawX > 458 && DrawX <= 474)
		begin
				Red	= 	scoreThree[23:16];
				Green	=	scoreThree[15:8];
				Blue 	=	scoreThree[7:0];
		end
		else if(DrawX > 474 && DrawX <= 490)
		begin
				Red	= 	scoreTwo[23:16];
				Green	=	scoreTwo[15:8];
				Blue 	=	scoreTwo[7:0];
		end
		else if(DrawX > 490 && DrawX <=506)
		begin
				Red	= 	scoreOne[23:16];
				Green	=	scoreOne[15:8];
				Blue 	=	scoreOne[7:0];		
		end
		else if(Tetris_Array[X_Pos_Arr1][Y_Pos_Arr1] > 0)
			begin
				backShape = Tetris_Array[X_Pos_Arr1][Y_Pos_Arr1];
				Red	= 	databoi4[23:16];
				Green	=	databoi4[15:8];
				Blue 	=	databoi4[7:0];
			end
		else 
			begin
				Red   =  Background[23:16];
				Green =  Background[15:8];
				Blue  =  Background[7:0];
			end
	end
else if(Shape == 8)
		begin


			if(DrawX - 16 >= shape_x && DrawX - 16 < shape_x + shape_size_x && DrawY >= shape_y
			&& DrawY < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX - 16) >= shape_x && (DrawX - 16) < shape_x + shape_size_x && (DrawY-16) >= shape_y
			&& (DrawY-16) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX) >= shape_x && (DrawX) < shape_x + shape_size_x && (DrawY-32) >= shape_y
			&& (DrawY-32) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX-16) >= shape_x && (DrawX-16) < shape_x + shape_size_x && (DrawY-32) >= shape_y
			&& (DrawY-32) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if(DrawX < 250 || DrawX > 506 || (DrawX > 426 && (DrawY < 132 || DrawY > 148)) || (DrawX > 410 && DrawX < 427)|| DrawY < 100 || DrawY > 420)
        begin
            Red = 8'h00; 
            Green = 8'h00;
            Blue = 8'h00;
        end
		else if(DrawX > 426 && DrawX <= 442)
		begin 
				Red	= 	scoreFive[23:16];
				Green	=	scoreFive[15:8];
				Blue 	=	scoreFive[7:0];

		end
		else if(DrawX > 442 && DrawX <= 458)
		begin
				Red	= 	scoreFour[23:16];
				Green	=	scoreFour[15:8];
				Blue 	=	scoreFour[7:0];

		end
		else if(DrawX > 458 && DrawX <= 474)
		begin
				Red	= 	scoreThree[23:16];
				Green	=	scoreThree[15:8];
				Blue 	=	scoreThree[7:0];
		end
		else if(DrawX > 474 && DrawX <= 490)
		begin
				Red	= 	scoreTwo[23:16];
				Green	=	scoreTwo[15:8];
				Blue 	=	scoreTwo[7:0];
		end
		else if(DrawX > 490 && DrawX <=506)
		begin
				Red	= 	scoreOne[23:16];
				Green	=	scoreOne[15:8];
				Blue 	=	scoreOne[7:0];		
		end
		else if(Tetris_Array[X_Pos_Arr1][Y_Pos_Arr1] > 0)
			begin
				backShape = Tetris_Array[X_Pos_Arr1][Y_Pos_Arr1];
				Red	= 	databoi4[23:16];
				Green	=	databoi4[15:8];
				Blue 	=	databoi4[7:0];
			end
		else 
			begin
				Red   =  Background[23:16];
				Green =  Background[15:8];
				Blue  =  Background[7:0];
			end
	end
else if(Shape == 9)
		begin
		


			if(DrawX >= shape_x && DrawX < shape_x + shape_size_x && DrawY >= shape_y
			&& DrawY < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX) >= shape_x && (DrawX) < shape_x + shape_size_x && (DrawY-16) >= shape_y
			&& (DrawY-16) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX - 16) >= shape_x && (DrawX - 16) < shape_x + shape_size_x && (DrawY - 16) >= shape_y
			&& (DrawY - 16) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX-32) >= shape_x && (DrawX-32) < shape_x + shape_size_x && (DrawY - 16) >= shape_y
			&& (DrawY - 16) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if(DrawX < 250 || DrawX > 506 || (DrawX > 426 && (DrawY < 132 || DrawY > 148)) || (DrawX > 410 && DrawX < 427)|| DrawY < 100 || DrawY > 420)
        begin
            Red = 8'h00; 
            Green = 8'h00;
            Blue = 8'h00;
        end
		else if(DrawX > 426 && DrawX <= 442)
		begin 
				Red	= 	scoreFive[23:16];
				Green	=	scoreFive[15:8];
				Blue 	=	scoreFive[7:0];

		end
		else if(DrawX > 442 && DrawX <= 458)
		begin
				Red	= 	scoreFour[23:16];
				Green	=	scoreFour[15:8];
				Blue 	=	scoreFour[7:0];

		end
		else if(DrawX > 458 && DrawX <= 474)
		begin
				Red	= 	scoreThree[23:16];
				Green	=	scoreThree[15:8];
				Blue 	=	scoreThree[7:0];
		end
		else if(DrawX > 474 && DrawX <= 490)
		begin
				Red	= 	scoreTwo[23:16];
				Green	=	scoreTwo[15:8];
				Blue 	=	scoreTwo[7:0];
		end
		else if(DrawX > 490 && DrawX <=506)
		begin
				Red	= 	scoreOne[23:16];
				Green	=	scoreOne[15:8];
				Blue 	=	scoreOne[7:0];		
		end
		else if(Tetris_Array[X_Pos_Arr1][Y_Pos_Arr1] > 0)
			begin
				backShape = Tetris_Array[X_Pos_Arr1][Y_Pos_Arr1];
				Red	= 	databoi4[23:16];
				Green	=	databoi4[15:8];
				Blue 	=	databoi4[7:0];
			end
		else 
			begin
				Red   =  Background[23:16];
				Green =  Background[15:8];
				Blue  =  Background[7:0];
			end
	end
else if(Shape == 10)
		begin
		


			if(DrawX >= shape_x && DrawX < shape_x + shape_size_x && DrawY >= shape_y
			&& DrawY < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX - 16) >= shape_x && (DrawX - 16) < shape_x + shape_size_x && (DrawY) >= shape_y
			&& (DrawY) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX) >= shape_x && (DrawX) < shape_x + shape_size_x && (DrawY - 16) >= shape_y
			&& (DrawY - 16) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX) >= shape_x && (DrawX) < shape_x + shape_size_x && (DrawY-32) >= shape_y
			&& (DrawY-32) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if(DrawX < 250 || DrawX > 506 || (DrawX > 426 && (DrawY < 132 || DrawY > 148)) || (DrawX > 410 && DrawX < 427)|| DrawY < 100 || DrawY > 420)
        begin
            Red = 8'h00; 
            Green = 8'h00;
            Blue = 8'h00;
        end
		else if(DrawX > 426 && DrawX <= 442)
		begin 
				Red	= 	scoreFive[23:16];
				Green	=	scoreFive[15:8];
				Blue 	=	scoreFive[7:0];

		end
		else if(DrawX > 442 && DrawX <= 458)
		begin
				Red	= 	scoreFour[23:16];
				Green	=	scoreFour[15:8];
				Blue 	=	scoreFour[7:0];

		end
		else if(DrawX > 458 && DrawX <= 474)
		begin
				Red	= 	scoreThree[23:16];
				Green	=	scoreThree[15:8];
				Blue 	=	scoreThree[7:0];
		end
		else if(DrawX > 474 && DrawX <= 490)
		begin
				Red	= 	scoreTwo[23:16];
				Green	=	scoreTwo[15:8];
				Blue 	=	scoreTwo[7:0];
		end
		else if(DrawX > 490 && DrawX <=506)
		begin
				Red	= 	scoreOne[23:16];
				Green	=	scoreOne[15:8];
				Blue 	=	scoreOne[7:0];		
		end
		else if(Tetris_Array[X_Pos_Arr1][Y_Pos_Arr1] > 0)
			begin
				backShape = Tetris_Array[X_Pos_Arr1][Y_Pos_Arr1];
				Red	= 	databoi4[23:16];
				Green	=	databoi4[15:8];
				Blue 	=	databoi4[7:0];
			end
		else 
			begin
				Red   =  Background[23:16];
				Green =  Background[15:8];
				Blue  =  Background[7:0];
			end
	end
else if(Shape == 11)
		begin
		
	 

			if(DrawX >= shape_x && DrawX < shape_x + shape_size_x && DrawY >= shape_y
			&& DrawY < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX - 16) >= shape_x && (DrawX - 16) < shape_x + shape_size_x && (DrawY) >= shape_y
			&& (DrawY) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX - 32) >= shape_x && (DrawX - 32) < shape_x + shape_size_x && (DrawY) >= shape_y
			&& (DrawY) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX-32) >= shape_x && (DrawX-32) < shape_x + shape_size_x && (DrawY - 16) >= shape_y
			&& (DrawY - 16) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if(DrawX < 250 || DrawX > 506 || (DrawX > 426 && (DrawY < 132 || DrawY > 148)) || (DrawX > 410 && DrawX < 427)|| DrawY < 100 || DrawY > 420)
        begin
            Red = 8'h00; 
            Green = 8'h00;
            Blue = 8'h00;
        end
		else if(DrawX > 426 && DrawX <= 442)
		begin 
				Red	= 	scoreFive[23:16];
				Green	=	scoreFive[15:8];
				Blue 	=	scoreFive[7:0];

		end
		else if(DrawX > 442 && DrawX <= 458)
		begin
				Red	= 	scoreFour[23:16];
				Green	=	scoreFour[15:8];
				Blue 	=	scoreFour[7:0];

		end
		else if(DrawX > 458 && DrawX <= 474)
		begin
				Red	= 	scoreThree[23:16];
				Green	=	scoreThree[15:8];
				Blue 	=	scoreThree[7:0];
		end
		else if(DrawX > 474 && DrawX <= 490)
		begin
				Red	= 	scoreTwo[23:16];
				Green	=	scoreTwo[15:8];
				Blue 	=	scoreTwo[7:0];
		end
		else if(DrawX > 490 && DrawX <=506)
		begin
				Red	= 	scoreOne[23:16];
				Green	=	scoreOne[15:8];
				Blue 	=	scoreOne[7:0];		
		end
		else if(Tetris_Array[X_Pos_Arr1][Y_Pos_Arr1] > 0)
			begin
				backShape = Tetris_Array[X_Pos_Arr1][Y_Pos_Arr1];
				Red	= 	databoi4[23:16];
				Green	=	databoi4[15:8];
				Blue 	=	databoi4[7:0];
			end
		else 
			begin
				Red   =  Background[23:16];
				Green =  Background[15:8];
				Blue  =  Background[7:0];
			end
	end
else if(Shape == 12)
		begin
		


			if(DrawX >= shape_x && DrawX < shape_x + shape_size_x && DrawY >= shape_y
			&& DrawY < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX - 16) >= shape_x && (DrawX - 16) < shape_x + shape_size_x && (DrawY) >= shape_y
			&& (DrawY) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX - 16) >= shape_x && (DrawX - 16) < shape_x + shape_size_x && (DrawY - 16) >= shape_y
			&& (DrawY - 16) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX-32) >= shape_x && (DrawX-32) < shape_x + shape_size_x && (DrawY - 16) >= shape_y
			&& (DrawY - 16) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if(DrawX < 250 || DrawX > 506 || (DrawX > 426 && (DrawY < 132 || DrawY > 148)) || (DrawX > 410 && DrawX < 427)|| DrawY < 100 || DrawY > 420)
        begin
            Red = 8'h00; 
            Green = 8'h00;
            Blue = 8'h00;
        end
		else if(DrawX > 426 && DrawX <= 442)
		begin 
				Red	= 	scoreFive[23:16];
				Green	=	scoreFive[15:8];
				Blue 	=	scoreFive[7:0];

		end
		else if(DrawX > 442 && DrawX <= 458)
		begin
				Red	= 	scoreFour[23:16];
				Green	=	scoreFour[15:8];
				Blue 	=	scoreFour[7:0];

		end
		else if(DrawX > 458 && DrawX <= 474)
		begin
				Red	= 	scoreThree[23:16];
				Green	=	scoreThree[15:8];
				Blue 	=	scoreThree[7:0];
		end
		else if(DrawX > 474 && DrawX <= 490)
		begin
				Red	= 	scoreTwo[23:16];
				Green	=	scoreTwo[15:8];
				Blue 	=	scoreTwo[7:0];
		end
		else if(DrawX > 490 && DrawX <=506)
		begin
				Red	= 	scoreOne[23:16];
				Green	=	scoreOne[15:8];
				Blue 	=	scoreOne[7:0];		
		end
		else if(Tetris_Array[X_Pos_Arr1][Y_Pos_Arr1] > 0)
			begin
				backShape = Tetris_Array[X_Pos_Arr1][Y_Pos_Arr1];
				Red	= 	databoi4[23:16];
				Green	=	databoi4[15:8];
				Blue 	=	databoi4[7:0];
			end
		else 
			begin
				Red   =  Background[23:16];
				Green =  Background[15:8];
				Blue  =  Background[7:0];
			end
	end
else if(Shape == 13)
		begin
		
	

			if((DrawX - 16) >= shape_x && (DrawX - 16) < shape_x + shape_size_x && DrawY >= shape_y
			&& DrawY < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX) >= shape_x && (DrawX) < shape_x + shape_size_x && (DrawY-16) >= shape_y
			&& (DrawY-16) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX - 16) >= shape_x && (DrawX - 16) < shape_x + shape_size_x && (DrawY - 16) >= shape_y
			&& (DrawY - 16) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX) >= shape_x && (DrawX) < shape_x + shape_size_x && (DrawY-32) >= shape_y
			&& (DrawY-32) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if(DrawX < 250 || DrawX > 506 || (DrawX > 426 && (DrawY < 132 || DrawY > 148)) || (DrawX > 410 && DrawX < 427)|| DrawY < 100 || DrawY > 420)
        begin
            Red = 8'h00; 
            Green = 8'h00;
            Blue = 8'h00;
        end
		else if(DrawX > 426 && DrawX <= 442)
		begin 
				Red	= 	scoreFive[23:16];
				Green	=	scoreFive[15:8];
				Blue 	=	scoreFive[7:0];

		end
		else if(DrawX > 442 && DrawX <= 458)
		begin
				Red	= 	scoreFour[23:16];
				Green	=	scoreFour[15:8];
				Blue 	=	scoreFour[7:0];

		end
		else if(DrawX > 458 && DrawX <= 474)
		begin
				Red	= 	scoreThree[23:16];
				Green	=	scoreThree[15:8];
				Blue 	=	scoreThree[7:0];
		end
		else if(DrawX > 474 && DrawX <= 490)
		begin
				Red	= 	scoreTwo[23:16];
				Green	=	scoreTwo[15:8];
				Blue 	=	scoreTwo[7:0];
		end
		else if(DrawX > 490 && DrawX <=506)
		begin
				Red	= 	scoreOne[23:16];
				Green	=	scoreOne[15:8];
				Blue 	=	scoreOne[7:0];		
		end
		else if(Tetris_Array[X_Pos_Arr1][Y_Pos_Arr1] > 0)
			begin
				backShape = Tetris_Array[X_Pos_Arr1][Y_Pos_Arr1];
				Red	= 	databoi4[23:16];
				Green	=	databoi4[15:8];
				Blue 	=	databoi4[7:0];
			end
		else 
			begin
				Red   =  Background[23:16];
				Green =  Background[15:8];
				Blue  =  Background[7:0];
			end
	end
else if(Shape == 14)
		begin

			if(DrawX - 16 >= shape_x && DrawX - 16 < shape_x + shape_size_x && DrawY >= shape_y
			&& DrawY < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX - 32) >= shape_x && (DrawX - 32) < shape_x + shape_size_x && (DrawY) >= shape_y
			&& (DrawY) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX) >= shape_x && (DrawX) < shape_x + shape_size_x && (DrawY - 16) >= shape_y
			&& (DrawY - 16) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX - 16) >= shape_x && (DrawX - 16) < shape_x + shape_size_x && (DrawY - 16) >= shape_y
			&& (DrawY - 16) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if(DrawX < 250 || DrawX > 506 || (DrawX > 426 && (DrawY < 132 || DrawY > 148)) || (DrawX > 410 && DrawX < 427)|| DrawY < 100 || DrawY > 420)
        begin
            Red = 8'h00; 
            Green = 8'h00;
            Blue = 8'h00;
        end
		else if(DrawX > 426 && DrawX <= 442)
		begin 
				Red	= 	scoreFive[23:16];
				Green	=	scoreFive[15:8];
				Blue 	=	scoreFive[7:0];

		end
		else if(DrawX > 442 && DrawX <= 458)
		begin
				Red	= 	scoreFour[23:16];
				Green	=	scoreFour[15:8];
				Blue 	=	scoreFour[7:0];

		end
		else if(DrawX > 458 && DrawX <= 474)
		begin
				Red	= 	scoreThree[23:16];
				Green	=	scoreThree[15:8];
				Blue 	=	scoreThree[7:0];
		end
		else if(DrawX > 474 && DrawX <= 490)
		begin
				Red	= 	scoreTwo[23:16];
				Green	=	scoreTwo[15:8];
				Blue 	=	scoreTwo[7:0];
		end
		else if(DrawX > 490 && DrawX <=506)
		begin
				Red	= 	scoreOne[23:16];
				Green	=	scoreOne[15:8];
				Blue 	=	scoreOne[7:0];		
		end
		else if(Tetris_Array[X_Pos_Arr1][Y_Pos_Arr1] > 0)
			begin
				backShape = Tetris_Array[X_Pos_Arr1][Y_Pos_Arr1];
				Red	= 	databoi4[23:16];
				Green	=	databoi4[15:8];
				Blue 	=	databoi4[7:0];
			end
		else 
			begin
				Red   =  Background[23:16];
				Green =  Background[15:8];
				Blue  =  Background[7:0];
			end
	end
else if(Shape == 15)
		begin

			if(DrawX >= shape_x && DrawX < shape_x + shape_size_x && DrawY >= shape_y
			&& DrawY < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX) >= shape_x && (DrawX) < shape_x + shape_size_x && (DrawY-16) >= shape_y
			&& (DrawY-16) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX - 16) >= shape_x && (DrawX - 16) < shape_x + shape_size_x && (DrawY - 16) >= shape_y
			&& (DrawY - 16) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX - 16) >= shape_x && (DrawX - 16) < shape_x + shape_size_x && (DrawY-32) >= shape_y
			&& (DrawY-32) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if(DrawX < 250 || DrawX > 506 || (DrawX > 426 && (DrawY < 132 || DrawY > 148)) || (DrawX > 410 && DrawX < 427)|| DrawY < 100 || DrawY > 420)
        begin
            Red = 8'h00; 
            Green = 8'h00;
            Blue = 8'h00;
        end
		else if(DrawX > 426 && DrawX <= 442)
		begin 
				Red	= 	scoreFive[23:16];
				Green	=	scoreFive[15:8];
				Blue 	=	scoreFive[7:0];

		end
		else if(DrawX > 442 && DrawX <= 458)
		begin
				Red	= 	scoreFour[23:16];
				Green	=	scoreFour[15:8];
				Blue 	=	scoreFour[7:0];

		end
		else if(DrawX > 458 && DrawX <= 474)
		begin
				Red	= 	scoreThree[23:16];
				Green	=	scoreThree[15:8];
				Blue 	=	scoreThree[7:0];
		end
		else if(DrawX > 474 && DrawX <= 490)
		begin
				Red	= 	scoreTwo[23:16];
				Green	=	scoreTwo[15:8];
				Blue 	=	scoreTwo[7:0];
		end
		else if(DrawX > 490 && DrawX <=506)
		begin
				Red	= 	scoreOne[23:16];
				Green	=	scoreOne[15:8];
				Blue 	=	scoreOne[7:0];		
		end
		else if(Tetris_Array[X_Pos_Arr1][Y_Pos_Arr1] > 0)
			begin
				backShape = Tetris_Array[X_Pos_Arr1][Y_Pos_Arr1];
				Red	= 	databoi4[23:16];
				Green	=	databoi4[15:8];
				Blue 	=	databoi4[7:0];
			end
		else 
			begin
				Red   =  Background[23:16];
				Green =  Background[15:8];
				Blue  =  Background[7:0];
			end
	end
else if(Shape == 16)
		begin

			if(DrawX - 16 >= shape_x && DrawX - 16 < shape_x + shape_size_x && DrawY >= shape_y
			&& DrawY < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX) >= shape_x && (DrawX) < shape_x + shape_size_x && (DrawY-16) >= shape_y
			&& (DrawY-16) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX - 16) >= shape_x && (DrawX - 16) < shape_x + shape_size_x && (DrawY - 16) >= shape_y
			&& (DrawY - 16) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX - 32) >= shape_x && (DrawX - 32) < shape_x + shape_size_x && (DrawY - 16) >= shape_y
			&& (DrawY - 16) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if(DrawX < 250 || DrawX > 506 || (DrawX > 426 && (DrawY < 132 || DrawY > 148)) || (DrawX > 410 && DrawX < 427)|| DrawY < 100 || DrawY > 420)
        begin
            Red = 8'h00; 
            Green = 8'h00;
            Blue = 8'h00;
        end
		else if(DrawX > 426 && DrawX <= 442)
		begin 
				Red	= 	scoreFive[23:16];
				Green	=	scoreFive[15:8];
				Blue 	=	scoreFive[7:0];

		end
		else if(DrawX > 442 && DrawX <= 458)
		begin
				Red	= 	scoreFour[23:16];
				Green	=	scoreFour[15:8];
				Blue 	=	scoreFour[7:0];

		end
		else if(DrawX > 458 && DrawX <= 474)
		begin
				Red	= 	scoreThree[23:16];
				Green	=	scoreThree[15:8];
				Blue 	=	scoreThree[7:0];
		end
		else if(DrawX > 474 && DrawX <= 490)
		begin
				Red	= 	scoreTwo[23:16];
				Green	=	scoreTwo[15:8];
				Blue 	=	scoreTwo[7:0];
		end
		else if(DrawX > 490 && DrawX <=506)
		begin
				Red	= 	scoreOne[23:16];
				Green	=	scoreOne[15:8];
				Blue 	=	scoreOne[7:0];		
		end
		else if(Tetris_Array[X_Pos_Arr1][Y_Pos_Arr1] > 0)
			begin
				backShape = Tetris_Array[X_Pos_Arr1][Y_Pos_Arr1];
				Red	= 	databoi4[23:16];
				Green	=	databoi4[15:8];
				Blue 	=	databoi4[7:0];
			end
		else 
			begin
				Red   =  Background[23:16];
				Green =  Background[15:8];
				Blue  =  Background[7:0];
			end
	end
else if(Shape == 17)
		begin
		

			if(DrawX >= shape_x && DrawX < shape_x + shape_size_x && DrawY >= shape_y
			&& DrawY < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX) >= shape_x && (DrawX) < shape_x + shape_size_x && (DrawY-16) >= shape_y
			&& (DrawY-16) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX - 16) >= shape_x && (DrawX - 16) < shape_x + shape_size_x && (DrawY - 16) >= shape_y
			&& (DrawY - 16) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX) >= shape_x && (DrawX) < shape_x + shape_size_x && (DrawY-32) >= shape_y
			&& (DrawY-32) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if(DrawX < 250 || DrawX > 506 || (DrawX > 426 && (DrawY < 132 || DrawY > 148)) || (DrawX > 410 && DrawX < 427)|| DrawY < 100 || DrawY > 420)
        begin
            Red = 8'h00; 
            Green = 8'h00;
            Blue = 8'h00;
        end
		else if(DrawX > 426 && DrawX <= 442)
		begin 
				Red	= 	scoreFive[23:16];
				Green	=	scoreFive[15:8];
				Blue 	=	scoreFive[7:0];

		end
		else if(DrawX > 442 && DrawX <= 458)
		begin
				Red	= 	scoreFour[23:16];
				Green	=	scoreFour[15:8];
				Blue 	=	scoreFour[7:0];

		end
		else if(DrawX > 458 && DrawX <= 474)
		begin
				Red	= 	scoreThree[23:16];
				Green	=	scoreThree[15:8];
				Blue 	=	scoreThree[7:0];
		end
		else if(DrawX > 474 && DrawX <= 490)
		begin
				Red	= 	scoreTwo[23:16];
				Green	=	scoreTwo[15:8];
				Blue 	=	scoreTwo[7:0];
		end
		else if(DrawX > 490 && DrawX <=506)
		begin
				Red	= 	scoreOne[23:16];
				Green	=	scoreOne[15:8];
				Blue 	=	scoreOne[7:0];		
		end
		else if(Tetris_Array[X_Pos_Arr1][Y_Pos_Arr1] > 0)
			begin
				backShape = Tetris_Array[X_Pos_Arr1][Y_Pos_Arr1];
				Red	= 	databoi4[23:16];
				Green	=	databoi4[15:8];
				Blue 	=	databoi4[7:0];
			end
		else 
			begin
				Red   =  Background[23:16];
				Green =  Background[15:8];
				Blue  =  Background[7:0];
			end
	end
else if(Shape == 18)
		begin
		


			if(DrawX >= shape_x && DrawX < shape_x + shape_size_x && DrawY >= shape_y
			&& DrawY < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX - 16) >= shape_x && (DrawX - 16) < shape_x + shape_size_x && (DrawY) >= shape_y
			&& (DrawY) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX -32) >= shape_x && (DrawX -32) < shape_x + shape_size_x && (DrawY) >= shape_y
			&& (DrawY) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX - 16) >= shape_x && (DrawX - 16) < shape_x + shape_size_x && (DrawY - 16) >= shape_y
			&& (DrawY - 16) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if(DrawX < 250 || DrawX > 506 || (DrawX > 426 && (DrawY < 132 || DrawY > 148)) || (DrawX > 410 && DrawX < 427)|| DrawY < 100 || DrawY > 420)
        begin
            Red = 8'h00; 
            Green = 8'h00;
            Blue = 8'h00;
        end
		else if(DrawX > 426 && DrawX <= 442)
		begin 
				Red	= 	scoreFive[23:16];
				Green	=	scoreFive[15:8];
				Blue 	=	scoreFive[7:0];

		end
		else if(DrawX > 442 && DrawX <= 458)
		begin
				Red	= 	scoreFour[23:16];
				Green	=	scoreFour[15:8];
				Blue 	=	scoreFour[7:0];

		end
		else if(DrawX > 458 && DrawX <= 474)
		begin
				Red	= 	scoreThree[23:16];
				Green	=	scoreThree[15:8];
				Blue 	=	scoreThree[7:0];
		end
		else if(DrawX > 474 && DrawX <= 490)
		begin
				Red	= 	scoreTwo[23:16];
				Green	=	scoreTwo[15:8];
				Blue 	=	scoreTwo[7:0];
		end
		else if(DrawX > 490 && DrawX <=506)
		begin
				Red	= 	scoreOne[23:16];
				Green	=	scoreOne[15:8];
				Blue 	=	scoreOne[7:0];		
		end
		else if(Tetris_Array[X_Pos_Arr1][Y_Pos_Arr1] > 0)
			begin
				backShape = Tetris_Array[X_Pos_Arr1][Y_Pos_Arr1];
				Red	= 	databoi4[23:16];
				Green	=	databoi4[15:8];
				Blue 	=	databoi4[7:0];
			end
		else 
			begin
				Red   =  Background[23:16];
				Green =  Background[15:8];
				Blue  =  Background[7:0];
			end
	end
else if(Shape == 19)
		begin
		

			if(DrawX - 16 >= shape_x && DrawX - 16 < shape_x + shape_size_x && DrawY >= shape_y
			&& DrawY < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX) >= shape_x && (DrawX) < shape_x + shape_size_x && (DrawY-16) >= shape_y
			&& (DrawY-16) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX - 16) >= shape_x && (DrawX - 16) < shape_x + shape_size_x && (DrawY - 16) >= shape_y
			&& (DrawY - 16) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if((DrawX - 16) >= shape_x && (DrawX - 16) < shape_x + shape_size_x && (DrawY-32) >= shape_y
			&& (DrawY-32) < shape_y + shape_size_y)
				begin
				Red	= 	databoi3[23:16];
				Green	=	databoi3[15:8];
				Blue 	=	databoi3[7:0];
				end
		else if(DrawX < 250 || DrawX > 506 || (DrawX > 426 && (DrawY < 132 || DrawY > 148)) || (DrawX > 410 && DrawX < 427)|| DrawY < 100 || DrawY > 420)
        begin
            Red = 8'h00; 
            Green = 8'h00;
            Blue = 8'h00;
        end
		else if(DrawX > 426 && DrawX <= 442)
		begin 
				Red	= 	scoreFive[23:16];
				Green	=	scoreFive[15:8];
				Blue 	=	scoreFive[7:0];

		end
		else if(DrawX > 442 && DrawX <= 458)
		begin
				Red	= 	scoreFour[23:16];
				Green	=	scoreFour[15:8];
				Blue 	=	scoreFour[7:0];

		end
		else if(DrawX > 458 && DrawX <= 474)
		begin
				Red	= 	scoreThree[23:16];
				Green	=	scoreThree[15:8];
				Blue 	=	scoreThree[7:0];
		end
		else if(DrawX > 474 && DrawX <= 490)
		begin
				Red	= 	scoreTwo[23:16];
				Green	=	scoreTwo[15:8];
				Blue 	=	scoreTwo[7:0];
		end
		else if(DrawX > 490 && DrawX <=506)
		begin
				Red	= 	scoreOne[23:16];
				Green	=	scoreOne[15:8];
				Blue 	=	scoreOne[7:0];		
		end
		else if(Tetris_Array[X_Pos_Arr1][Y_Pos_Arr1] > 0)
			begin
				backShape = Tetris_Array[X_Pos_Arr1][Y_Pos_Arr1];
				Red	= 	databoi4[23:16];
				Green	=	databoi4[15:8];
				Blue 	=	databoi4[7:0];
			end
		else 
			begin
				Red   =  Background[23:16];
				Green =  Background[15:8];
				Blue  =  Background[7:0];
			end
	end
	

	

else 	
  begin
  
	 if(DrawX < 250 || DrawX > 506 || (DrawX > 426 && (DrawY < 132 || DrawY > 148)) || (DrawX > 410 && DrawX < 427)|| DrawY < 100 || DrawY > 420)
        begin
            Red = 8'h00; 
            Green = 8'h00;
            Blue = 8'h00;
        end
		else if(DrawX > 426 && DrawX <= 442)
		begin 
				Red	= 	scoreFive[23:16];
				Green	=	scoreFive[15:8];
				Blue 	=	scoreFive[7:0];

		end
		else if(DrawX > 442 && DrawX <= 458)
		begin
				Red	= 	scoreFour[23:16];
				Green	=	scoreFour[15:8];
				Blue 	=	scoreFour[7:0];

		end
		else if(DrawX > 458 && DrawX <= 474)
		begin
				Red	= 	scoreThree[23:16];
				Green	=	scoreThree[15:8];
				Blue 	=	scoreThree[7:0];
		end
		else if(DrawX > 474 && DrawX <= 490)
		begin
				Red	= 	scoreTwo[23:16];
				Green	=	scoreTwo[15:8];
				Blue 	=	scoreTwo[7:0];
		end
		else if(DrawX > 490 && DrawX <=506)
		begin
				Red	= 	scoreOne[23:16];
				Green	=	scoreOne[15:8];
				Blue 	=	scoreOne[7:0];		
		end
	 else if(Tetris_Array[X_Pos_Arr1][Y_Pos_Arr1] > 0)
			begin
				backShape = Tetris_Array[X_Pos_Arr1][Y_Pos_Arr1];
				Red	= 	databoi4[23:16];
				Green	=	databoi4[15:8];
				Blue 	=	databoi4[7:0];
			end
    else 
			begin
				Red   =  Background[23:16];
				Green =  Background[15:8];
				Blue  =  Background[7:0];
			end
		end
	end
end	



// Assign color based on is_ball signal
//    always_comb
//    begin
//        if (is_ball == 1'b1) 
//        begin
//            // White ball
//            Red = 8'hff;
//            Green = 8'hff;
//            Blue = 8'hff;
//        end
//        else 
//        begin
//            // Background with nice color gradient
//            Red = 8'h3f; 
//            Green = 8'h00;
//            Blue = 8'h7f - {1'b0, DrawX[9:3]};
//        end
//    end 
//	 always_comb
//		begin
//		if(DrawX >= shape_x && DrawX < shape_x + shape_size_x && DrawY >= shape_y
//			&& DrawY < shape_y + shape_size_y)
//			begin 
//				shape_on = 1'b1;
//			end
//		else
//			begin
//			shape_on = 1'b0;
//			end
//		end
//	 
//				if(DrawX >= shape_x && DrawX < shape_x + shape_size_x && (DrawY - 32) >= shape_y
//			&& (DrawY - 32) < shape_y + shape_size_y)
//				begin
//				Red	= 	databoi[23:16];
//				Green	=	databoi[15:8];
//				Blue 	=	databoi[7:0];
//				end
//				else 
//        begin
//            // Background with nice color gradient
//            Red = 8'h3f; 
//            Green = 8'h00;
//            Blue = 8'h7f - {1'b0, DrawX[9:3]};
//        end
//				if(DrawX >= shape_x && DrawX < shape_x + shape_size_x && (DrawY - 48) >= shape_y
//			&& (DrawY - 48) < shape_y + shape_size_y)
//				begin
//				Red	= 	databoi[23:16];
//				Green	=	databoi[15:8];
//				Blue 	=	databoi[7:0];
//				end
//				else 
//        begin
//            // Background with nice color gradient
//            Red = 8'h3f; 
//            Green = 8'h00;
//            Blue = 8'h7f - {1'b0, DrawX[9:3]};
//        end

    
endmodule
