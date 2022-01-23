module datapath (
	input logic clk,
	input logic rst,
	// ICACHE INPUT/OUTPUTS
	input logic [31:0] RDATA_ICACHE,
	input logic RESP_ICACHE,
	output logic READ_ICACHE,
	output logic WRITE_ICACHE,
	output logic [3:0] MEM_BYTE_EN_ICACHE,
	output logic [31:0] WDATA_ICACHE,
	output logic [31:0] ADDR_ICACHE,
	// D CACHE INPUT/OUTPUTS
	output logic WRITE_DCACHE,
	output logic READ_DCACHE,
	output logic [31:0] WDATA_DCACHE,
	output logic [3:0] MEM_BYTE_EN_DCACHE,
	output logic [31:0] ADDR_DCACHE,
	input logic [31:0] RDATA_DCACHE,
	input logic RESP_DCACHE
);

/*datapath interstage signals including regfile io*/
logic WAIT_IF, WAIT_MEM;
logic BR_EN;
logic [31:0] PC_JUMP;
logic [31:0] RS1_OUT, RS2_OUT, REGFILE_IN_REGFILE;
logic [4:0] RS1, RS2, RD_REGFILE;
logic REGFILE_WR_EN_REGFILE;

//hazard signals


//IF INPUT REGS

//ID INPUT REGS

logic [31:0] PC_ID, IR_ID;

//EXE INPUT REGS
logic [31:0] ALU_IN1_EXE, ALU_IN2_EXE, CMP_IN1_EXE, CMP_IN2_EXE;
logic [2:0] ALU_OP_EXE, CMP_OP_EXE;
logic [4:0] RD_EXE;
logic REGFILE_WR_EN_EXE;
logic [1:0] REGFILE_MUX_SEL_EXE;
logic PC_PLUS_FOUR_EN_EXE;
logic [31:0] U_IMM_EXE;
logic [31:0] PC_PLUS_FOUR_EXE;
logic MEMREAD_EXE, MEMWRITE_EXE;
logic [3:0] MEM_BYTE_EN_BASE_EXE;
logic [31:0] MEM_WDATA_EXE;
logic BR_EN_CHECK_EXE, JUMP_EN_EXE;

//MEM INPUT REGS   

logic [31:0] ARITH_OUT_MEM;
logic MEMWRITE_MEM, MEMREAD_MEM;
logic [4:0] RD_MEM;
logic [3:0] MEM_BYTE_EN_BASE_MEM;
logic REGFILE_WR_EN_MEM;
logic [31:0] PC_PLUS_FOUR_MEM;
logic PC_PLUS_FOUR_EN_MEM;
logic [31:0] MEM_WDATA_MEM;     

//MEM WB INPUT REGS

logic [31:0] REGFILE_IN_MEM_WB;
logic REGFILE_WR_EN_MEM_WB;
logic [4:0] RD_MEM_WB;

//FORWARDING OUTPUTS
logic [1:0] RS1_FORWARD_SEL;
logic [1:0] RS2_FORWARD_SEL;
logic RS1_FORWARD_ID;
logic RS2_FORWARD_ID;

logic [4:0] RS1_EXE;
logic [4:0] RS2_EXE;

logic [31:0] REGFILE_IN_MEM;

logic ALU1_USING_REG;
logic ALU2_USING_REG;
logic CMP1_USING_REG;
logic CMP2_USING_REG;

logic [31:0] REGFILE_DATA_MEM_WB_REGISTER1;
logic [31:0] REGFILE_DATA_MEM_WB_REGISTER2;

IF instruction_fetch(.*);
ID instruction_decode(.*);
EXE execution_state(.*);
MEM memory_io_stage(.*);
MEM_WB mem_write_back_stage(.*);


regfile regfile_mod(
	.clk(clk), .rst(rst), .load(REGFILE_WR_EN_REGFILE), .in(REGFILE_IN_REGFILE), .src_a(RS1), .src_b(RS2), .dest(RD_REGFILE),
	.reg_a(RS1_OUT), .reg_b(RS2_OUT)
);

forwarding_unit forward_mod(
	.*
);


endmodule : datapath