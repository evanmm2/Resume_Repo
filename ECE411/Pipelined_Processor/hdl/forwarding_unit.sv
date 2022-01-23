module forwarding_unit
(
	input logic [4:0] RD_MEM,
	input logic [4:0] RD_MEM_WB,
	input logic [4:0] RS1_EXE,
	input logic [4:0] RS2_EXE,
	input logic [4:0] RS1,
	input logic [4:0] RS2,
	
	input logic REGFILE_WR_EN_MEM,
	input logic REGFILE_WR_EN_MEM_WB,
	
	output logic [1:0] RS1_FORWARD_SEL,
	output logic [1:0] RS2_FORWARD_SEL,
	output logic RS1_FORWARD_ID,
	output logic RS2_FORWARD_ID
);
logic RS1_FORWARD_EXE;
logic RS2_FORWARD_EXE;
logic RS1_FORWARD_MEM;
logic RS2_FORWARD_MEM;

//00 does not forward, 01 forwards from mem state(arith_out), 10 forwards from
//mem_wb(regfile_in), and 11 is an impossible config
assign RS1_FORWARD_SEL = {RS1_FORWARD_MEM, RS1_FORWARD_EXE};
assign RS2_FORWARD_SEL = {RS2_FORWARD_MEM, RS2_FORWARD_EXE};

always_comb begin
	
	//if we are going to write to registers and the rd is not r0 and rd matches r1
	//in the ex state
	if ((REGFILE_WR_EN_MEM & (RD_MEM != 5'b00000)) & (RD_MEM == RS1_EXE))
		RS1_FORWARD_EXE = 1'b1;
	else 
		RS1_FORWARD_EXE = 1'b0;
		
	//if we are going to write to registers and the rd is not r0 and rd matches r2
	//in the ex state
	if ((REGFILE_WR_EN_MEM & (RD_MEM != 5'b00000)) & (RD_MEM == RS2_EXE))
		RS2_FORWARD_EXE = 1'b1;
	else 
		RS2_FORWARD_EXE = 1'b0;
		
	//if we are going to write to registers and the rd is not r0 and rd matches r1
	//in the ex state and we are not forwarding from mem state
	if ((REGFILE_WR_EN_MEM_WB & (RD_MEM_WB != 5'b00000)) & (RD_MEM_WB == RS1_EXE) & 
		!(RS1_FORWARD_EXE))
		RS1_FORWARD_MEM = 1'b1;
	else 
		RS1_FORWARD_MEM = 1'b0;
		
	//if we are going to write to registers and the rd is not r0 and rd matches r2
	//in the ex state and we are not forwarding from mem state
	if ((REGFILE_WR_EN_MEM_WB && (RD_MEM_WB != 5'b00000)) && (RD_MEM_WB == RS2_EXE) && 
		!(RS2_FORWARD_EXE)) //RS2_EXE = RD_MEM_WB
		RS2_FORWARD_MEM = 1'b1;
	else 
		RS2_FORWARD_MEM = 1'b0;
		
	//From RS1
	if((REGFILE_WR_EN_MEM_WB & (RD_MEM_WB != 5'b00000)) & (RD_MEM_WB == RS1))
		RS1_FORWARD_ID = 1'b1;
	else
		RS1_FORWARD_ID = 1'b0;
		
	if((REGFILE_WR_EN_MEM_WB & (RD_MEM_WB != 5'b00000)) & (RD_MEM_WB == RS2))
		RS2_FORWARD_ID = 1'b1;
	else
		RS2_FORWARD_ID = 1'b0;
	
end

endmodule : forwarding_unit