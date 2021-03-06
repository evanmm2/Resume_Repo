//-------------------------------------------------------------------------
//    Block.sv    
//
// 	Based on Block.sv by                                                        --
//    Viral Mehta                                                        --
//    Spring 2005                                                        --
//                                                                       --
//    Modified by Stephen Kempf 03-01-2006                               --
//                              03-12-2007                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Po-Han Huang  12-08-2017                               --
//    Spring 2018 Distribution                                           --
//                                                                       --
//    For use with ECE 385 Lab 8                                         --
//    UIUC ECE Department                                                --
//-------------------------------------------------------------------------


module  sblock (input  		  Clk,                // 50 MHz clock
               input 		  Reset,              // Active-high reset signal
					input 		  newShape,     // Signal for new shape(~60Hz)
					input [3:0]   keypress,
               input [9:0]   DrawX, DrawY, 	    // Current pixel coordinates
					input [9:0]	  Shape_X_Size, Shape_Y_Size,
					input 		  Stop_X_Left, Stop_X_Right, //from ArrayCheck
               input         blockBelow,
					input 		  lost, start,
					output logic  touchdown,
					output logic  [9:0] Block_X_Pos, Block_Y_Pos
					
				  );
    
    parameter [9:0] Block_X_Start = 10'd330;  // Center position on the X axis
    parameter [9:0] Block_Y_Start = 10'd100;  // Center position on the Y axis
    parameter [9:0] Block_X_Min = 10'd250;       // Leftmost point on the X axis
    parameter [9:0] Block_X_Max = 10'd410;     // Rightmost point on the X axis
    parameter [9:0] Block_Y_Min = 10'd100;       // Topmost point on the Y axis
    parameter [9:0] Block_Y_Max = 10'd420;     // Bottommost point on the Y axis
    parameter [9:0] Block_X_Step = 10'd16;      // Step size on the X axis
    parameter [9:0] Block_Y_Step = 10'd16;      // Step size on the Y axis
    
    logic [9:0] Block_Y_Motion;
    logic [9:0] Block_X_Pos_in, Block_Y_Pos_in, Block_Y_Motion_in;
	 logic touchdown_in;
	 logic [9:0][19:0][4:0] Tetris_Array ;
	 logic [23:0] Y_Counter, Y_Counter_in;
    
    //////// Do not modify the always_ff blocks. ////////
    // Detect rising edge of frame_clk
    // Update registers

    always_ff @ (posedge Clk)
    begin
        if (Reset || (keypress[3:0] == 4'h5) || newShape || lost || start)
        begin
            Block_X_Pos <= Block_X_Start;
            Block_Y_Pos <= Block_Y_Start;
            Block_Y_Motion <= Block_Y_Step;
				touchdown <= 1'd0;
				Y_Counter <= 24'd0;
        end
        else
        begin
            Block_X_Pos <= Block_X_Pos_in;
            Block_Y_Pos <= Block_Y_Pos_in;
            Block_Y_Motion <= Block_Y_Motion_in;
				Y_Counter <= Y_Counter_in;
            touchdown <= touchdown_in;
				
				
        end
    end
    //////// Do not modify the always_ff blocks. ////////
    
    // You need to modify always_comb block.
    always_comb
    begin
        // By default, keep motion and position unchanged
        Block_X_Pos_in = Block_X_Pos;
        Block_Y_Pos_in = Block_Y_Pos;
        Block_Y_Motion_in = Block_Y_Motion;
        
        
        // Update position and motion only at rising edge of frame clock
		  // Update position whenever
//        if (frame_clk_rising_edge)
//        begin
            // Be careful when using comparators with "logic" datatype because compiler treats 
            //   both sides of the operator as UNSIGNED numbers.
            // e.g. Block_Y_Pos - Block_Size <= Block_Y_Min 
            // If Block_Y_Pos is 0, then Block_Y_Pos - Block_Size will not be -4, but rather a large positive number.
				
				
				// Key inputs for A and D
				case (keypress[3:0])
					4'h2: begin //A pressed, move left
						if ((Block_X_Pos > Block_X_Min) && ~(Stop_X_Left))
							begin
							Block_X_Pos_in = Block_X_Pos - Block_X_Step;
							end
						else
							Block_X_Pos_in = Block_X_Pos;
					end
				
					4'h4: begin //D pressed
						if ((Block_X_Pos + Shape_X_Size < Block_X_Max) && ~(Stop_X_Right))
							begin
							Block_X_Pos_in = Block_X_Pos + Block_X_Step;
							end
						else
							Block_X_Pos_in = Block_X_Pos;
					end
								
					default: ;
				
				endcase
		//Y Movement		

            if (Block_Y_Pos <= Block_Y_Min) begin  // Block is the top
					 Block_Y_Motion_in = Block_Y_Step;  // 2's complement.  
					 end
					 
            else if (Block_Y_Pos  + Shape_Y_Size >= Block_Y_Max) begin  // Block is at the bottom edge, BOUNCE!
					 Block_Y_Motion_in = 10'd0;
					 end
					 
			else
                Block_Y_Motion_in = Block_Y_Step;

            //Y movement if it matches counter;
            if (Y_Counter == 28'h0fffffd)
					begin
                    if (blockBelow) //If block below touchdown = 1
                    begin
                        Block_Y_Pos_in = Block_Y_Pos;
                        touchdown_in = 1'd1;
                        Y_Counter_in = 28'd0;
                    end

                    else if (Block_Y_Motion == 10'd0) //If at bottom of screen, touchdown = 1
                    begin
                        touchdown_in = 1'd1;
                        Block_Y_Pos_in = Block_Y_Pos;
                        Y_Counter_in = 28'd0;
                    end

                    else //Otherwise move down
                    begin
                        Block_Y_Pos_in = Block_Y_Pos + Block_Y_Motion;
                        Y_Counter_in = 28'd0;
                        touchdown_in = 1'd0;
						  end
					end	
            else if ((Y_Counter == 28'h03ffffd) && keypress == 4'h3)
                begin
                    if (blockBelow) //If block below and faster
                    begin
                        Block_Y_Pos_in = Block_Y_Pos;
                        touchdown_in = 1'd1;
                        Y_Counter_in = 28'd0;
                    end

                    else if (Block_Y_Motion == 10'd0) //If at bottom of screen and faster
                    begin
                        touchdown_in = 1'd1;
                        Y_Counter_in = 28'd0;
                        Block_Y_Pos_in = Block_Y_Pos;
                    end

                    else //Otherwise and fast, move down
                    begin
                        Block_Y_Pos_in = Block_Y_Pos + Block_Y_Motion;
                        Y_Counter_in = 28'd0;
                        touchdown_in = 1'd0;
						end
					
					end
            else 
				begin
                Block_Y_Pos_in = Block_Y_Pos;
                Y_Counter_in = Y_Counter + 1'd1;
                touchdown_in = touchdown;
				end
					 
		//Check if block hit the bottom of the screen or if there's a block below it
				// if ((Block_Y_Motion_in == 10'd0) && (Y_Counter == ))
				// 	touchdown = 1'd1;
				// else
				// 	touchdown = 1'd0;
					 
				
        
        /**************************************************************************************
            ATTENTION! Please answer the following quesiton in your lab report! Points will be allocated for the answers!
            Hidden Question #2/2:
               Notice that Block_Y_Pos is updated using Block_Y_Motion. 
              Will the new value of Block_Y_Motion be used when Block_Y_Pos is updated, or the old? 
              What is the difference between writing
                "Block_Y_Pos_in = Block_Y_Pos + Block_Y_Motion;" and 
                "Block_Y_Pos_in = Block_Y_Pos + Block_Y_Motion_in;"?
              How will this impact behavior of the Block during a bounce, and how might that interact with a response to a keypress?
              Give an answer in your Post-Lab.
        **************************************************************************************/
    end
    
    // Compute whether the pixel corresponds to Block or background
    /* Since the multiplicants are required to be signed, we have to first cast them
       from logic to int (signed by default) before they are multiplied. */

endmodule
