module keypress_state_machine (
input [7:0]keycode,
input Reset, Clk,
output [3:0] keypress
);

enum logic [3:0]{Hold, A_press, A_hold, D_press, D_hold, S_press, S_hold, W_press, W_hold, R_press, R_hold} State, Next_State;

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
			case(keycode[7:0])
				8'h1A: //W key
					Next_State = W_press;
				8'h16: //S key
					Next_State = S_press;
				8'h04: //A key
					Next_State = A_press;
				8'h07: //D key
					Next_State = D_press;
				8'h15: //R key
					Next_State = R_press;
				default:;
			endcase
		end
		
		A_press:
		begin
		Next_State = A_hold;
		end
		
		A_hold:
		begin
		if (keycode == 8'h00)
			Next_State = Hold;
		end
		
		D_press:
		begin
		Next_State = D_hold;
		end
		
		D_hold:
		begin
			if (keycode == 8'h00)
				Next_State = Hold;
		end
		
		S_press:
		begin
			Next_State = S_hold;
		end
		
		S_hold:
		begin
			if (keycode == 8'h00)
				Next_State = Hold; 
		end
		
		W_press:
		begin
			Next_State = W_hold;
		end
		
		W_hold:
		begin
			if (keycode == 8'h00)
				Next_State = Hold;
		end

		R_press:
			begin
				Next_State = R_hold;
			end
		
		R_hold:
			begin
				if (keycode == 8'h00)
					Next_State = Hold;
			end
		
		default: ;
	
	endcase
end

always_comb
begin
	keypress = 4'h0;
	
	unique case (State)
		W_press:
			keypress = 4'h1;
		A_press:
			keypress = 4'h2;
		S_press:
			keypress = 4'h3;
		S_hold:
			keypress = 4'h3;
		D_press:
			keypress = 4'h4;
		R_press:
			keypress = 4'h5; //R key
		default:;
	endcase
end
endmodule 