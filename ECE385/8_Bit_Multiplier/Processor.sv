//4-bit logic processor top level module
//for use with ECE 385 Fall 2016
//last modified by Zuofu Cheng


//Always use input/output logic types when possible, prevents issues with tools that have strict type enforcement

module Processor (input logic   Clk,     // Internal
                                Reset,   // Push button 0   
                                ClearA_LoadB,   // Push button 2
                                Run, // Push button 3
                  input  logic [7:0]  S,     // input data// DEBUG
                  output logic [7:0]  Aval,    // DEBUG
                                Bval,    // DEBUG
                  output logic [6:0]  AhexL,
                                AhexU,
                                BhexL,
                                BhexU,
					   output logic X
						);

	 //local logic variables go here
	 logic Reset_SH, ClearA_LoadB_SH, Run_SH;
	 logic Ld_A, Ld_B, newA, newB, opA, opB, bitA, bitB, Shift_En, fn, xout, ClrA;
	 logic [7:0] A, B, Din_S, Sum;
	 
	 
	 //We can use the "assign" statement to do simple combinational logic
	 assign Aval = A;
	 assign Bval = B; //Concatenate is a common operation in HDL
	 
	 //Instantiation of modules here
	 register_unit    reg_unit (
                        .Clk,
                        .Reset(Reset_SH),
                        .Ld_A(Ld_A), //note these are inferred assignments, because of the existence a logic variable of the same name
                        .Ld_B(Ld_B),
                        .Shift_En(Shift_En),
								.X,
                        .Sum(Sum),
								.S(Din_S),
								.ClrA,
                        .A(A),
                        .B(B));
								
    eight_Bit_Add_Sub   Add_Sub(
								.A(A),
								.B(B[0]),
                        .S(Din_S),
                        .fn(fn),
                        .Sum(Sum),
								.xout(xout)
								);
								
								
	 d_flip 					dflip(
								.d(xout),
								.Clk,
								.Ld_A,
								.Reset(Reset_SH),
								.q(X)
								);

	 control          control_unit (
                        .Clk(Clk),
                        .Reset(Reset_SH),
                        .ClearA_LoadB(ClearA_LoadB_SH),
                        .Run(Run_SH),
                        .Shift_En(Shift_En),
                        .Ld_A,
								.ClrA,
								.fn(fn),
                        .Ld_B
								);
	
	 HexDriver        HexAL (
                        .In0(A[3:0]),
                        .Out0(AhexL) );
	 HexDriver        HexBL (
                        .In0(B[3:0]),
                        .Out0(BhexL) );
								
	 //When you extend to 8-bits, you will need more HEX drivers to view upper nibble of registers, for now set to 0
	 HexDriver        HexAU (
                        .In0(A[7:4]),
                        .Out0(AhexU) );	
	 HexDriver        HexBU (
                       .In0(B[7:4]),
                        .Out0(BhexU) );
								
	  //Input synchronizers required for asynchronous inputs (in this case, from the switches)
	  //These are array module instantiations
	  //Note: S stands for SYNCHRONIZED, H stands for active HIGH
	  //Note: We can invert the levels inside the port assignments
	  sync button_sync[2:0] (Clk, {~Reset, ~ClearA_LoadB, ~Run}, {Reset_SH, ClearA_LoadB_SH, Run_SH});
	  sync Din_sync[7:0] (Clk, S, Din_S);
	  
endmodule

