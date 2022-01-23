typedef enum {w_at, h_at, hu_at, b_at, bu_at,dont_care_at} access_type_t;

module MBE_DECODER(
	input  logic [3:0] MEM_BYTE_EN_BASE,
	input  logic [31:0] ADDR,
	output logic [1:0] ADDR_OFFSET,
	output logic [3:0] MEM_BYTE_EN,
	output logic [31:0] ALLIGNED_ADDR,
	output access_type_t ACCESS_TYPE      
);

always_comb begin
	ADDR_OFFSET = ADDR[1:0];
	ALLIGNED_ADDR = {ADDR[31:2], 2'b00};
	case (MEM_BYTE_EN_BASE)
		4'b1111: 
			begin
			//NOTE MAKE THIS THROW AN ERROR IF MISALLIGNED
			ACCESS_TYPE = w_at;
			MEM_BYTE_EN = MEM_BYTE_EN_BASE << ADDR[1:0];
			end
		4'b0011:
			begin
			ACCESS_TYPE = h_at;
			MEM_BYTE_EN = MEM_BYTE_EN_BASE << ADDR[1:0];
			end
		4'b1011:
			begin
			ACCESS_TYPE = hu_at;
			MEM_BYTE_EN = {2'b00,MEM_BYTE_EN_BASE[1:0]} << ADDR[1:0];
			end
		4'b0001:
			begin
			ACCESS_TYPE = b_at;
			MEM_BYTE_EN = MEM_BYTE_EN_BASE << ADDR[1:0];
			end
		4'b1001:
			begin
			ACCESS_TYPE = bu_at;
			MEM_BYTE_EN = {3'b000,MEM_BYTE_EN_BASE[0]} << ADDR[1:0];
			end
		default:
			begin
			ACCESS_TYPE = dont_care_at;
			MEM_BYTE_EN = 4'bxxxx;
			end
	endcase
end

endmodule : MBE_DECODER

module MEM(
	input logic clk,
	input logic rst,
	
	input logic WAIT_IF,
	
	input logic RESP_DCACHE,
	input logic [31:0] RDATA_DCACHE,
	
	input logic [31:0] ARITH_OUT_MEM,
	input logic MEMWRITE_MEM, MEMREAD_MEM,
	input logic [4:0] RD_MEM,
	input logic [3:0] MEM_BYTE_EN_BASE_MEM,
	input logic REGFILE_WR_EN_MEM,
	input logic [31:0] PC_PLUS_FOUR_MEM,
	input logic PC_PLUS_FOUR_EN_MEM,
	input logic [31:0] MEM_WDATA_MEM,          
	input logic [31:0] REGFILE_DATA_MEM_WB_REGISTER1,
	
	output logic WAIT_MEM,
	
	output logic [31:0] REGFILE_IN_MEM,
	
	output logic [31:0] REGFILE_IN_MEM_WB,
	output logic REGFILE_WR_EN_MEM_WB,
	output logic [4:0] RD_MEM_WB,
	
	output logic READ_DCACHE, WRITE_DCACHE,
   output logic [3:0] MEM_BYTE_EN_DCACHE,
	output logic [31:0] ADDR_DCACHE, WDATA_DCACHE

);

logic [3:0] MEM_BYTE_EN_BASE;
logic [31:0] ADDR;
logic [1:0] ADDR_OFFSET;
logic [3:0] MEM_BYTE_EN;
logic [31:0] ALLIGNED_ADDR;
access_type_t ACCESS_TYPE; 

logic [31:0] RDATA, RDATA_DCACHE_SHIFTED;     

assign MEM_BYTE_EN_BASE = MEM_BYTE_EN_BASE_MEM;
assign ADDR = ARITH_OUT_MEM;

MBE_DECODER mbe_decoder(.*);

logic [31:0] RDATA_REG;
logic RESP_REG;

always_comb begin
	//WAIT SIGNAL DETERMINATION (SEE RESP_REG LOGIC IN FF
	WAIT_MEM = (MEMREAD_MEM || MEMWRITE_MEM) && !(RESP_DCACHE || RESP_REG);
	//WAIT_MEM = 1'b0;
	//cache signal logic
	READ_DCACHE  = MEMREAD_MEM && !(RESP_REG);
	WRITE_DCACHE = MEMWRITE_MEM && !(RESP_REG); 
//	READ_DCACHE  = MEMREAD_MEM;
//	WRITE_DCACHE = MEMWRITE_MEM;
	
	MEM_BYTE_EN_DCACHE 	= MEM_BYTE_EN;
	ADDR_DCACHE  			= ALLIGNED_ADDR;
	WDATA_DCACHE 			= MEM_WDATA_MEM << (ADDR_OFFSET*8);  //  << (ADDR_OFFSET*8)???????????? FIRDT CANDIDATE FOR MEMORY MISALIGNE<NT FUCKUPS
	RDATA_DCACHE_SHIFTED = RDATA_DCACHE >> (ADDR_OFFSET * 8);
	
	unique case (ACCESS_TYPE)
		w_at: RDATA = RDATA_DCACHE_SHIFTED;
		hu_at: RDATA = {{16{1'b0}},RDATA_DCACHE_SHIFTED[15:0]};
		h_at: RDATA = {{16{RDATA_DCACHE_SHIFTED[15]}}, RDATA_DCACHE_SHIFTED[15:0]};
		bu_at: RDATA = {{24{1'b0}},RDATA_DCACHE_SHIFTED[7:0]};
		b_at: RDATA ={{24{RDATA_DCACHE_SHIFTED[7]}},RDATA_DCACHE_SHIFTED[7:0]};
		dont_care_at: RDATA = 32'hxxxxxxxx;
	endcase
	if (REGFILE_WR_EN_MEM) begin
			if (PC_PLUS_FOUR_EN_MEM) 					REGFILE_IN_MEM = PC_PLUS_FOUR_MEM;
			else if (MEMREAD_MEM && RESP_DCACHE) 	REGFILE_IN_MEM = RDATA;
			else if (MEMREAD_MEM) 						REGFILE_IN_MEM = RDATA_REG;
			else 												REGFILE_IN_MEM = ARITH_OUT_MEM;
		end else 											REGFILE_IN_MEM = 32'h00000000;
end
	
always_ff @(posedge clk) begin
	if (rst) begin
		RESP_REG <= 1'b0;
		REGFILE_IN_MEM_WB <= 32'hxxxxxxxx;
		RDATA_REG <= 32'h00000000;
		REGFILE_WR_EN_MEM_WB <= 1'b0;
		RD_MEM_WB <= 5'bxxxx;
	end else if (WAIT_IF || WAIT_MEM) begin
	
		REGFILE_IN_MEM_WB <= REGFILE_IN_MEM_WB;
		RD_MEM_WB <= RD_MEM_WB;
		REGFILE_WR_EN_MEM_WB <= REGFILE_WR_EN_MEM_WB;
		
		if (MEMREAD_MEM && RESP_DCACHE) begin
			RDATA_REG <= RDATA;
			RESP_REG <= 1'b1;
		end else if (MEMWRITE_MEM && RESP_DCACHE) begin
			RDATA_REG <= ARITH_OUT_MEM;
			RESP_REG <= 1'b1;
		end else begin
			RDATA_REG <= RDATA_REG;
			RESP_REG <= RESP_REG;
		end
	end else begin
		REGFILE_IN_MEM_WB <= REGFILE_IN_MEM;
		RD_MEM_WB <= RD_MEM;
		REGFILE_WR_EN_MEM_WB <= REGFILE_WR_EN_MEM;
		
		RESP_REG <= 1'b0;
		RDATA_REG <= RDATA_REG;
		
	end
end
endmodule : MEM
