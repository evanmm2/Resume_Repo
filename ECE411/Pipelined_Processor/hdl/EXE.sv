module EXE(
	input logic clk,
	input logic rst,
	
	//WAIT SIGNALS
	input logic WAIT_IF, WAIT_MEM,
	
	//Input From ID
	//ARITH CONTROLS
	input logic [31:0] ALU_IN1_EXE, ALU_IN2_EXE, CMP_IN1_EXE, CMP_IN2_EXE,
	input logic [2:0] ALU_OP_EXE, CMP_OP_EXE,
	//REGFILE CONTROLS (WHEN REGFILE TAKES MEMORY MEMREAD_EXE MATTERS ALSO)
	input logic [4:0] RD_EXE,
	input logic REGFILE_WR_EN_EXE,
	input logic [1:0] REGFILE_MUX_SEL_EXE,
	
	input logic PC_PLUS_FOUR_EN_EXE,
	//POSSIBLE CORNER CASE REGFILE INPUTS
	input logic [31:0] U_IMM_EXE,
	input logic [31:0] PC_PLUS_FOUR_EXE,
	//CACHE CONTROLS 
	input logic MEMREAD_EXE, MEMWRITE_EXE,
	input logic [3:0] MEM_BYTE_EN_BASE_EXE,
	input logic [31:0] MEM_WDATA_EXE,
	
	//JUMP CONTROLS
	input logic BR_EN_CHECK_EXE, JUMP_EN_EXE,    

	//FORWARDING MUX SELECTS
	input logic [1:0] RS1_FORWARD_SEL,
	input logic [1:0] RS2_FORWARD_SEL,
	
	//FORWARDING REGISTERS
	input logic [4:0] RS1_EXE,
	input logic [4:0] RS2_EXE,
	
	//FORWARDING TO TELL IF WE ARE USING REG FOR INPUT OR NOT
	input logic ALU1_USING_REG, ALU2_USING_REG, CMP1_USING_REG, CMP2_USING_REG,
	
	//FORWARDING VALUE FROM MEM_WB
	input logic [31:0] REGFILE_IN_MEM_WB,
	input logic [31:0] REGFILE_IN_MEM,
	
	//OUTPUT TO DATAPATH
	output logic 		  BR_EN,
	
	//OUTPUT TO MEM
	//ARITH RESULT FOR RD_IN, MEMADDR, AND PC_JUMP
	output logic [31:0] ARITH_OUT_MEM,
	
	//MEMORY CONTROLS
	output logic        MEMREAD_MEM, MEMWRITE_MEM,
	output logic [3:0]  MEM_BYTE_EN_BASE_MEM,
	output logic [31:0]  MEM_WDATA_MEM,
	
	//REGFILECONTROLS
	output logic [4:0]  RD_MEM,
	output logic        REGFILE_WR_EN_MEM,   
	output logic 		  PC_PLUS_FOUR_EN_MEM,
	output logic [31:0] PC_PLUS_FOUR_MEM,
	
	output logic [31:0] PC_JUMP
);

//Internal Signals
logic [31:0] ALU_OUT, REGFILE_MUX_OUT;
logic CMP_OUT;
logic BR_EN_NEXT;
logic [31:0] ALU1_INPUT;
logic [31:0] ALU2_INPUT;
logic [31:0] CMP1_INPUT;
logic [31:0] CMP2_INPUT;

alu ALU (
	.aluop(ALU_OP_EXE),
	.a(ALU1_INPUT),
	.b(ALU2_INPUT),
	.f(ALU_OUT)
);

cmp CMP (
	.cmp1(CMP1_INPUT),
	.cmp2(CMP2_INPUT),
	.cmpop(CMP_OP_EXE),
	.br_en(CMP_OUT)
);

always_comb begin
	unique case (REGFILE_MUX_SEL_EXE)
		2'b00: REGFILE_MUX_OUT = ALU_OUT;
		2'b01: REGFILE_MUX_OUT = {{31{1'b0}},CMP_OUT};
		2'b10: REGFILE_MUX_OUT = U_IMM_EXE;
		2'b11: REGFILE_MUX_OUT = 32'h00000000;
		default: REGFILE_MUX_OUT = 32'hxxxxxxxx;
	endcase
	
	//ALU_RS1 FORWARD MUX
	unique case (RS1_FORWARD_SEL)
		//NOT FORWARDING
		2'b00: ALU1_INPUT = ALU_IN1_EXE;
		//FORWARDING FROM MEM STAGE
		2'b01: begin
					 if (ALU1_USING_REG)
						ALU1_INPUT = REGFILE_IN_MEM;
					 else
						ALU1_INPUT = ALU_IN1_EXE;
					 end
		//FORWARDING FROM MEM_WB STAGE
		2'b10: begin
					if (ALU1_USING_REG)
						ALU1_INPUT = REGFILE_IN_MEM_WB;
					else
						ALU1_INPUT = ALU_IN1_EXE;
				 end
		default: ALU1_INPUT = 32'hxxxxxxxx;
	endcase
	
	//ALU_RS2 FORWARDING MUX
	unique case (RS2_FORWARD_SEL)
		//NOT FORWARDING
		2'b00: ALU2_INPUT = ALU_IN2_EXE;
		//FORWARDING FROM MEM STAGE
		2'b01: begin
					 if (ALU2_USING_REG)
						ALU2_INPUT = REGFILE_IN_MEM;
					 else
						ALU2_INPUT = ALU_IN2_EXE;
					 end
		//FORWARDING FROM MEM_WB STAGE
		2'b10: begin
					if (ALU2_USING_REG)
						ALU2_INPUT = REGFILE_IN_MEM_WB;
					else
						ALU2_INPUT = ALU_IN2_EXE;
				 end
		default: ALU2_INPUT = 32'hxxxxxxxx;
	endcase
	
	//FORWARDING FROM CMP1
	//THIS CASE STATMENT COULD BE CONTAINED IN ABOVE, BUT THIS IS CLEANER IMO
	unique case (RS1_FORWARD_SEL)
		//NOT FORWARDING
		2'b00: CMP1_INPUT = CMP_IN1_EXE;
		//FORWARDING FROM MEM STAGE
		2'b01: begin
					 if (CMP1_USING_REG)
						CMP1_INPUT = REGFILE_IN_MEM;
					 else
						CMP1_INPUT = CMP_IN1_EXE;
					 end
		//FORWARDING FROM MEM_WB STAGE
		2'b10: begin
					if (CMP1_USING_REG)
						CMP1_INPUT = REGFILE_IN_MEM_WB;
					else
						CMP1_INPUT = CMP_IN1_EXE;
				 end
		default: CMP1_INPUT = 32'hxxxxxxxx;
	endcase
	
	unique case (RS2_FORWARD_SEL)
		//NOT FORWARDING
		2'b00: CMP2_INPUT = CMP_IN2_EXE;
		//FORWARDING FROM MEM STAGE
		2'b01: begin
					 if (CMP2_USING_REG)
						CMP2_INPUT = REGFILE_IN_MEM;
					 else
						CMP2_INPUT = CMP_IN2_EXE;
					 end
		//FORWARDING FROM MEM_WB STAGE
		2'b10: begin
					if (CMP2_USING_REG)
						CMP2_INPUT = REGFILE_IN_MEM_WB;
					else
						CMP2_INPUT = CMP_IN2_EXE;
				 end
		default: CMP2_INPUT = 32'hxxxxxxxx;
	endcase
	
	if (JUMP_EN_EXE || (BR_EN_CHECK_EXE && CMP_OUT)) BR_EN_NEXT = 1'b1;
	else BR_EN_NEXT = 1'b0;
end

always_ff @(posedge clk) begin
	if (rst | BR_EN) begin
		BR_EN 					<=	1'b0;
		ARITH_OUT_MEM 			<= 32'hxxxxxxxx;
		MEMREAD_MEM 			<= 1'b0;
		MEMWRITE_MEM 			<= 1'b0;
		MEM_BYTE_EN_BASE_MEM <= 4'b0000;
		MEM_WDATA_MEM 			<= 32'hxxxxxxxx;
		RD_MEM 					<= 5'bxxxxx;
		REGFILE_WR_EN_MEM 	<= 1'b0;
		PC_JUMP 					<= 32'hxxxxxxxx;
		PC_PLUS_FOUR_EN_MEM  <= 1'b0;
		PC_PLUS_FOUR_MEM     <= 32'hxxxxxxxx;
	end else if (WAIT_IF || WAIT_MEM) begin
		BR_EN 					<=	BR_EN 					;
		ARITH_OUT_MEM 			<= ARITH_OUT_MEM		 	;
		MEMREAD_MEM 			<= MEMREAD_MEM 			;
		MEMWRITE_MEM 			<= MEMWRITE_MEM 			;
		MEM_BYTE_EN_BASE_MEM <= MEM_BYTE_EN_BASE_MEM ;
		MEM_WDATA_MEM 			<= MEM_WDATA_MEM 			;
		RD_MEM 					<= RD_MEM 					;
		REGFILE_WR_EN_MEM 	<= REGFILE_WR_EN_MEM 	; 
		PC_JUMP					<= REGFILE_MUX_OUT		;
		PC_PLUS_FOUR_EN_MEM  <= PC_PLUS_FOUR_EN_MEM 	;
		PC_PLUS_FOUR_MEM     <= PC_PLUS_FOUR_MEM    	;
	end else begin
		BR_EN 					<=	BR_EN_NEXT 				;
		ARITH_OUT_MEM 			<= REGFILE_MUX_OUT 		;
		MEMREAD_MEM 			<= MEMREAD_EXE				;
		MEMWRITE_MEM 			<= MEMWRITE_EXE 			;
		MEM_BYTE_EN_BASE_MEM <= MEM_BYTE_EN_BASE_EXE ;
		MEM_WDATA_MEM 			<= MEM_WDATA_EXE 			;
		RD_MEM 					<= RD_EXE 					;
		REGFILE_WR_EN_MEM 	<= REGFILE_WR_EN_EXE 	;
		PC_JUMP					<= REGFILE_MUX_OUT		;
		PC_PLUS_FOUR_EN_MEM  <= PC_PLUS_FOUR_EN_EXE 	;
		PC_PLUS_FOUR_MEM     <= PC_PLUS_FOUR_EXE    	;
	end
end
endmodule: EXE