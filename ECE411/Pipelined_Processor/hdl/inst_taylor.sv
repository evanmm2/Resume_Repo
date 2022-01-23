module INST_TAYLOR (
	input  logic [31:0] IR,
	
	output logic [31:0] I_IMM, S_IMM,  U_IMM, B_IMM, J_IMM,
	output logic [4:0]  RS1, RS2, RD,
	
	output logic [6:0]  OPCODE,
	output logic [2:0]  FUNCT_3,
	output logic [6:0]  FUNCT_7
);

assign OPCODE  = IR [6:0];
assign RS1 	   = IR [19:15];
assign RS2 	   = IR [24:20];
assign RD      = IR [11:7];
assign FUNCT_3 	= IR [14:12];
assign FUNCT_7	= IR [31:25];
assign I_IMM   = {{21{IR[31]}}, IR[30:20]};
assign S_IMM   = {{21{IR[31]}}, IR[30:25], IR[11:7]};
assign B_IMM   = {{20{IR[31]}}, IR[7], IR[30:25], IR[11:8], 1'b0};
assign U_IMM   = {IR[31:12], 12'h000};
assign J_IMM   = {{12{IR[31]}}, IR[19:12], IR[20], IR[30:21], 1'b0};

endmodule : INST_TAYLOR