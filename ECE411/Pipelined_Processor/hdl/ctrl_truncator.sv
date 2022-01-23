`define op_lui   7'b0110111
`define op_auipc 7'b0010111
`define op_jal   7'b1101111
`define op_jalr  7'b1100111
`define op_br    7'b1100011
`define op_load  7'b0000011
`define op_store 7'b0100011
`define op_imm   7'b0010011
`define op_reg   7'b0110011

`define lw    3'b010
`define lh    3'b001
`define lhu	  3'b101
`define lb    3'b000
`define lbu   3'b100

`define sw    3'b010
`define sh    3'b001
`define sb    3'b000


import mux_types::*;

module CTRL_TRUNCATOR (
	input  logic [6:0]   OPCODE,
	input  logic [2:0]   FUNCT_3,
	input  logic [6:0]   FUNCT_7,
	
	output alumux1_sel_t ALUMUX1_SEL, 
	output alumux2_sel_t ALUMUX2_SEL,
	output cmpmux_sel_t  CMPMUX_SEL,   
	
	output logic PC_PLUS_FOUR_EN,
	
	output logic [2:0]  ALU_OP, CMP_OP,
	output logic        MEMWRITE, MEMREAD,
	output logic [3:0]  MEM_BYTE_EN_BASE,
	output logic        REGFILE_WR_EN,
	output logic [1:0]  REGFILE_MUX_SEL,
	output logic        JUMP_EN, BR_CHECK          
	);

	
	
always_comb begin
	//signals required for safety
	REGFILE_WR_EN   = 1'b0;
	MEMWRITE        = 1'b0;
	MEMREAD 			 = 1'b0;
	BR_CHECK			 = 1'b0;
	JUMP_EN			 = 1'b0;
	MEM_BYTE_EN_BASE = 4'b0000;
	
	PC_PLUS_FOUR_EN = 1'bx;
	ALUMUX1_SEL = mux_types::dont_care_mux1;
	ALUMUX2_SEL = mux_types::dont_care_mux2;
	CMPMUX_SEL  = mux_types::dont_care_cmp;
	ALU_OP      = 3'bxxx;
	CMP_OP      = 3'bxxx;
	REGFILE_MUX_SEL = 2'bxx;
	
	case (OPCODE) 
		`op_lui:
			begin
			REGFILE_WR_EN   		= 1'b1;	// Need to write to register
			REGFILE_MUX_SEL		= 2'b10;	// Want to access imm value, not arithmetic value
			MEM_BYTE_EN_BASE 		= 4'b1111;
			end
		`op_auipc:
			begin
			ALUMUX1_SEL 			= mux_types::pc_mux1; //pc + u_imm = arith 
			ALUMUX2_SEL				= mux_types::u_imm_mux2;
			REGFILE_WR_EN   		= 1'b1;
			REGFILE_MUX_SEL      = 2'b00;
			MEM_BYTE_EN_BASE 		= 4'b1111;
			ALU_OP					= 3'b000;
			end
      `op_jal: 
			begin
			ALUMUX1_SEL		 		= mux_types::pc_mux1; //pc + j_imm = arith
			ALUMUX2_SEL   			= mux_types::j_imm_mux2;
			REGFILE_WR_EN   		= 1'b1;	// Need to write to register
			REGFILE_MUX_SEL		= 2'b00;	// Want to access Arithmetic value
			PC_PLUS_FOUR_EN      = 1'b1;
			JUMP_EN					= 1'b1;
			ALU_OP					= 3'b000;
			end	
      `op_jalr: 
			begin
			ALUMUX1_SEL		 		= mux_types::rs1_out_mux1; //pc + j_imm = arith
			ALUMUX2_SEL				= mux_types::i_imm_mux2;
			REGFILE_WR_EN   		= 1'b1;	// Need to write to register
			REGFILE_MUX_SEL		= 2'b00;	// Want to access Arithmetic value
			PC_PLUS_FOUR_EN      = 1'b1;
			JUMP_EN 					= 1'b1;
			ALU_OP					= 3'b000;
			end		
      `op_br:
			begin
			ALUMUX1_SEL		 		= mux_types::pc_mux1;
			ALUMUX2_SEL				= mux_types::b_imm_mux2;
			CMP_OP 					= FUNCT_3;
			CMPMUX_SEL      		= mux_types::rs2_out_cmp;
			BR_CHECK					= 1'b1;
			ALU_OP					= 3'b000;
			REGFILE_MUX_SEL		= 2'b00;
			//REGFILE_SEL_NEXT		= 2'b11;	//So rd_wdata is 0 for monitor
			end
      `op_load: 
			begin
			REGFILE_WR_EN			= 1'b1;
			REGFILE_MUX_SEL		= 2'b00;
			MEMREAD              = 1'b1;
			ALUMUX1_SEL 			= mux_types::rs1_out_mux1;
			ALUMUX2_SEL 			= mux_types::i_imm_mux2;
			ALU_OP					= 3'b000;
			case (FUNCT_3) 
				`lw: MEM_BYTE_EN_BASE  = 4'b1111;
				`lh: MEM_BYTE_EN_BASE  = 4'b0011;
				`lhu: MEM_BYTE_EN_BASE = 4'b1011; //msb encodes unsignedness
				`lb: MEM_BYTE_EN_BASE  = 4'b0001;
				`lbu: MEM_BYTE_EN_BASE = 4'b1001;
				default: MEM_BYTE_EN_BASE = 4'b0000; //NOTE! throw error
			endcase
			end
		`op_store:
			begin
			MEMWRITE             = 1'b1;
			REGFILE_MUX_SEL		= 2'b00;
			ALUMUX1_SEL 			= mux_types::rs1_out_mux1;
			ALUMUX2_SEL 			= mux_types::s_imm_mux2;
			ALU_OP					= 3'b000;
			case (FUNCT_3) 
				`sw: MEM_BYTE_EN_BASE  = 4'b1111;
				`sh: MEM_BYTE_EN_BASE  = 4'b0011;
				`sb: MEM_BYTE_EN_BASE  = 4'b0001;
				default: MEM_BYTE_EN_BASE  = 4'b0000;//NOTE throw error
			endcase
			end
		`op_imm:
			begin
			REGFILE_WR_EN             	= 1'b1;
			ALUMUX1_SEL               	= mux_types::rs1_out_mux1;
			ALUMUX2_SEL               	= mux_types::i_imm_mux2;
			CMPMUX_SEL 						= mux_types::i_imm_cmp;
			CMP_OP							= FUNCT_3;
			
			if (FUNCT_3 == 3'b010 || FUNCT_3 == 3'b011) begin
				ALU_OP 						= 3'bxxx;
				REGFILE_MUX_SEL 			= 2'b01;
					
			end else if (FUNCT_3 == 3'b101) begin	
				if (FUNCT_7 == 7'b0000000) ALU_OP 	= 3'b101;
				else ALU_OP = 3'b010;
				REGFILE_MUX_SEL 			= 2'b00;
				
			end else begin
				ALU_OP 						= FUNCT_3;
				REGFILE_MUX_SEL 			= 2'b00;
			end		
			end
		`op_reg:  
			begin
			REGFILE_WR_EN  				= 1'b1;
			ALUMUX1_SEL						= mux_types::rs1_out_mux1;
			ALUMUX2_SEL						= mux_types::rs2_out_mux2;
			CMPMUX_SEL						= mux_types::rs2_out_cmp;
			CMP_OP							= FUNCT_3;
			
			if (FUNCT_3 == 3'b000) begin
				REGFILE_MUX_SEL = 2'b00;
				if (FUNCT_7 == 7'b0000000) 	ALU_OP = 3'b000;
				else 							  	ALU_OP = 3'b011;
			
			end else if (FUNCT_3 == 3'b010 || FUNCT_3 == 3'b011) begin
				REGFILE_MUX_SEL = 2'b01;
				ALU_OP			 = 3'bxxx;
				
			end else begin
				REGFILE_MUX_SEL = 2'b00;
				ALU_OP 			 = FUNCT_3;
			end
			end
		default:;
	endcase

end
endmodule : CTRL_TRUNCATOR