module blockshape (
input Clk, Reset,
input [3:0]keypress, // 4'h1 = W, 4'h2 = A, 4'h3 = S, 4'h4 = D, 4'h5 = R;
input [3:0]Next_Shape,
input noRotate,
input newShape,
input lost,
output [9:0] Shape_X_Size, Shape_Y_Size,
output [4:0] Shape


);
enum logic [4:0] {Hold, I_Vertical, I_Horizontal, Square, L_Upright, L_Right,
L_Upsidedown, L_Left, J_Upright, J_Right, J_Upsidedown, J_Left,
Z_Horizontal, Z_Vertical, S_Horizontal, S_Vertical, T_Upright, T_Right,
T_Upsidedown, T_Left} State, Next_State;

always_ff @ (posedge Clk)
begin
	if (Reset)
		begin
			State <= Hold;
		end
	else
		State <= Next_State;
		
end


always_comb
begin

	Next_State = State;
	
	unique case (State)
		Hold:
		begin
			case(Next_Shape[3:0])
				4'h1: //I block
					Next_State = I_Vertical;
				4'h2: //Square block
					Next_State = Square;
				4'h3: //L block
					Next_State = L_Upright;
				4'h4: //J block
					Next_State = J_Upright;
				4'h5: //Z block
					Next_State = Z_Horizontal;
				4'h6: //S block
					Next_State = S_Horizontal;
				4'h7: //T block
					Next_State = T_Upright;
				default:;
			endcase
		end
		
		I_Vertical:
		begin
			if(keypress[3:0] == 4'h1 && (~noRotate) && (~lost))
				Next_State = I_Horizontal;
			else if (newShape)
				Next_State = Hold;
			else
				Next_State = I_Vertical;
		end

		I_Horizontal:
		begin
			if (newShape)
				Next_State = Hold;
			else if (keypress[3:0] == 4'h1 && (~noRotate) && (~lost))
				Next_State = I_Vertical;
			else
				Next_State = I_Horizontal;
		end
		Square:
		begin
			if (newShape)
				Next_State = Hold;
			else
				Next_State = Square;
		end
		
		L_Upright:
		begin
			if(newShape)
				Next_State = Hold;
			else if (keypress[3:0] == 4'h1 && (~noRotate) && (~lost))
				Next_State = L_Right;
			else
				Next_State = L_Upright;
		end
		
		L_Right:
		begin
			if(newShape)
				Next_State = Hold;
			else if (keypress[3:0] == 4'h1 && (~noRotate) && (~lost))
				Next_State = L_Upsidedown;
			else
				Next_State = L_Right;
		end
		
		L_Upsidedown:
		begin
			if(newShape)
				Next_State = Hold;
			else if (keypress[3:0] == 4'h1 && (~noRotate) && (~lost))
				Next_State = L_Left;
			else
				Next_State = L_Upsidedown;
		end
		
		L_Left:
		begin
			if(newShape)
				Next_State = Hold;
			else if (keypress[3:0] == 4'h1 && (~noRotate) && (~lost))
				Next_State = L_Upright;
			else
				Next_State = L_Left; 
		end
		
		J_Upright:
		begin
			if(newShape)
				Next_State = Hold;
			else if (keypress[3:0] == 4'h1 && (~noRotate) && (~lost))
				Next_State = J_Right;
			else
				Next_State = J_Upright;
		end

		J_Right:
		begin
			if(newShape)
				Next_State = Hold;
			else if (keypress[3:0] == 4'h1 && (~noRotate) && (~lost))
				Next_State = J_Upsidedown;
			else
				Next_State = J_Right;
		end
		
		J_Upsidedown:
		begin
			if(newShape)
				Next_State = Hold;
			else if (keypress[3:0] == 4'h1 && (~noRotate) && (~lost))
				Next_State = J_Left;
			else
				Next_State = J_Upsidedown;
		end

		J_Left:
		begin
			if(newShape)
				Next_State = Hold;
			else if (keypress[3:0] == 4'h1 && (~noRotate) && (~lost))
				Next_State = J_Upright;
			else
				Next_State = J_Left;
		end

		Z_Horizontal:
		begin
			if(newShape)
				Next_State = Hold;
			else if (keypress[3:0] == 4'h1 && (~noRotate) && (~lost))
				Next_State = Z_Vertical;
			else
				Next_State = Z_Horizontal;
		end
		
		Z_Vertical:
		begin
			if(newShape)
				Next_State = Hold;
			else if (keypress[3:0] == 4'h1 && (~noRotate) && (~lost))
				Next_State = Z_Horizontal;
		end

		S_Horizontal:
		begin
			if(newShape)
				Next_State = Hold;
			else if (keypress[3:0] == 4'h1 && (~noRotate) && (~lost))
				Next_State = S_Vertical;
		end

		S_Vertical:
		begin
			if(newShape)
				Next_State = Hold;
			else if (keypress[3:0] == 4'h1 && (~noRotate) && (~lost))
				Next_State = S_Horizontal;
		end

		T_Upright:
		begin
			if(newShape)
				Next_State = Hold;
			else if (keypress[3:0] == 4'h1 && (~noRotate) && (~lost))
				Next_State = T_Right;
		end

		T_Right:
		begin
			if(newShape)
				Next_State = Hold;
			else if (keypress[3:0] == 4'h1 && (~noRotate) && (~lost))
				Next_State = T_Upsidedown;
		end

		T_Upsidedown:
		begin
			if(newShape)
				Next_State = Hold;
			else if (keypress[3:0] == 4'h1 && (~noRotate) && (~lost))
				Next_State = T_Left;
		end

		T_Left:
		begin
			if(newShape)
				Next_State = Hold;
			else if (keypress[3:0] == 4'h1 && (~noRotate) && (~lost))
				Next_State = T_Upright;
		end

		default: ;
		
	endcase
end

always_comb
begin

	Shape_X_Size = 10'd16;
	Shape_Y_Size = 10'd16;
	Shape = 5'd0;
	
	case (State)
		I_Vertical:
		begin
			Shape_X_Size = 10'd16;
			Shape_Y_Size = 10'd64;
			Shape = 5'd1;
		end

		I_Horizontal:
		begin
			Shape_X_Size = 10'd64;
			Shape_Y_Size = 10'd16;
			Shape = 5'd2;
		end

		Square:
		begin
			Shape_X_Size = 10'd32;
			Shape_Y_Size = 10'd32;
			Shape = 5'd3;
		end

		L_Upright:
		begin
			Shape_X_Size = 10'd32;
			Shape_Y_Size = 10'd48;
			Shape = 5'd4;
		end

		L_Right:
		begin
			Shape_X_Size = 10'd48;
			Shape_Y_Size = 10'd32;
			Shape = 5'd5;
		end

		L_Upsidedown:
		begin
			Shape_X_Size = 10'd32;
			Shape_Y_Size = 10'd48;
			Shape = 5'd6;
		end

		L_Left:
		begin
			Shape_X_Size = 10'd48;
			Shape_Y_Size = 10'd32;
			Shape = 5'd7;
		end

		J_Upright:
		begin
			Shape_X_Size = 10'd32;
			Shape_Y_Size = 10'd48;
			Shape = 5'd8;
		end

		J_Right:
		begin
			Shape_X_Size = 10'd48;
			Shape_Y_Size = 10'd32;
			Shape = 5'd9;
		end

		J_Upsidedown:
		begin
			Shape_X_Size = 10'd32;
			Shape_Y_Size = 10'd48;
			Shape = 5'd10;
		end

		J_Left:
		begin
			Shape_X_Size = 10'd48;
			Shape_Y_Size = 10'd32;
			Shape = 5'd11;
		end

		Z_Horizontal:
		begin
			Shape_X_Size = 10'd48;
			Shape_Y_Size = 10'd32;
			Shape = 5'd12;
		end

		Z_Vertical:
		begin
			Shape_X_Size = 10'd32;
			Shape_Y_Size = 10'd48;
			Shape = 5'd13;
		end

		S_Horizontal:
		begin
			Shape_X_Size = 10'd48;
			Shape_Y_Size = 10'd32;
			Shape = 5'd14;
		end

		S_Vertical:
		begin
			Shape_X_Size = 10'd32;
			Shape_Y_Size = 10'd48;
			Shape = 5'd15;
		end

		T_Upright:
		begin
			Shape_X_Size = 10'd48;
			Shape_Y_Size = 10'd32;
			Shape = 5'd16;
		end

		T_Right:
		begin
			Shape_X_Size = 10'd32;
			Shape_Y_Size = 10'd48;
			Shape = 5'd17;
		end

		T_Upsidedown:
		begin
			Shape_X_Size = 10'd48;
			Shape_Y_Size = 10'd32;
			Shape = 5'd18;
		end

		T_Left:
		begin
			Shape_X_Size = 10'd32;
			Shape_Y_Size = 10'd48;
			Shape = 5'd19;
		end

		default:;
	endcase
end


endmodule 