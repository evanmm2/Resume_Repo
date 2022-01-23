module register_unit (input  logic Clk, Reset, Ld_A, Ld_B, ClrA,
                            Shift_En,
							 input  logic X,
							 input  logic [7:0]  Sum, S,
                      output logic [7:0]  A,
                      output logic [7:0]  B);

logic reset_all, A_out;
assign reset_all = (Ld_B|Reset)|ClrA;

    reg_8  reg_A (.Clk(Clk), .Reset(reset_all), .Load(Ld_A), .Shift_En(Shift_En), .D(Sum), .Shift_In(X), 
	               .Shift_Out(A_out), .Data_Out(A));
    reg_8  reg_B (.Shift_En(Shift_En), .D(S), .Clk(Clk), .Reset(Reset), .Shift_In(A_out), .Load(Ld_B),
	               .Shift_Out(), .Data_Out(B));

endmodule

module d_flip (input logic d, Clk, Reset, Ld_A,
					output logic q);
					
			always_ff @ (posedge Clk)
			begin
			if (Reset)
			q <=1'b0;
			else if (Ld_A)
			q <= d;
			else 
			q <= q;
			end
			
			
endmodule 