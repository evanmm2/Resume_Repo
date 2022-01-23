//Two-always example for state machine

module control (input  logic Clk, Reset, ClearA_LoadB, Run,
                output logic Shift_En, Ld_A, Ld_B, fn, ClrA);

    // Declare signals curr_state, next_state of type enum
    // with enum values of A, B, ..., F as the state values
	 // Note that the length implies a max of 8 states, so you will need to bump this up for 8-bits
    enum logic [5:0] {A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S}   curr_state, next_state; 

	//updates flip flop, current state is the only one
    always_ff @ (posedge Clk)  
    begin
        if (Reset)
            curr_state <= A;
        else 
            curr_state <= next_state;
    end

    // Assign outputs based on state
	always_comb
    begin
        
		  next_state  = curr_state;	//required because I haven't enumerated all possibilities below
        unique case (curr_state) 

            A :    if (Run)
                       next_state = B;
            B :    next_state = C; //clear A
            C :    next_state = D; //Add
            D :    next_state = E;//Shift
            E :    next_state = F;//Add
				F :    next_state = G;//Shift
				G :    next_state = H;//ADD
				H :    next_state = I;//SHIFT
				I :    next_state = J;//ADD
				J :    next_state = K;//SHIFT
				K :    next_state = L;//ADD
				L :    next_state = M;//SHIFT
				M :    next_state = N;//ADD
				N :    next_state = O;//SHIFT
				O :    next_state = P;//ADD
				P :    next_state = Q;//SHIFT
				Q :    next_state = R;//SUBTRact
				R :    next_state = S;//SHIFT
				
            S :    if (~Run) 
                       next_state = A;
							  
        endcase
   
		  // Assign outputs based on ‘state’
        case (curr_state) 
	   	   A: 
	         begin
					 Ld_A = 1'b0;
                Ld_B = ClearA_LoadB;
                Shift_En = 1'b0;
					 fn = 1'b0;
					 ClrA = 1'b0;
		      end
				B:
				begin
					 Ld_A = 1'b0;
                Ld_B = 1'b0;
                Shift_En = 1'b0;
					 fn = 1'b0;
					 ClrA = 1'b1;
		      end
				
				C, E, G, I, K, M, O: //Adding
				begin
				Ld_B = 1'b0;
				Ld_A = 1'b1;
				Shift_En = 1'b0;
				fn = 1'b0;
				ClrA = 1'b0;
				end
				
				Q:							//Subtracting
				begin
				Ld_B= 1'b0;
				Shift_En = 1'b0;
				Ld_A = 1'b1;
				fn = 1'b1;
				ClrA = 1'b0;
				end
	   	   
				S:
		      begin
                Ld_B = 1'b0;
					 Ld_A = 1'b0;
					 fn = 1'b0;
                Shift_En = 1'b0; //End case
					 ClrA = 1'b0;
		      end
				default:  //default case, shifting
		      begin 
                Ld_B = 1'b0;
                Shift_En = 1'b1;
					 fn = 1'b0;
					 Ld_A = 1'b0;
					 ClrA = 1'b0;
		      end
        endcase
    end

endmodule
