import mux_types::*;

module IF (
	input logic clk,
	input logic rst,
	//INPUTS
	//jump related signals
	input logic BR_EN,
	input logic [31:0] PC_JUMP,
	
	//WAIT SIGNALS IN
	input logic WAIT_MEM,
	
	//ICACHE SIGNALS
	input logic RESP_ICACHE,
	input logic [31:0] RDATA_ICACHE,
	
	//OUTPUTS
	//OUTPUTS TO ID
	output logic [31:0] PC_ID,
	output logic [31:0] IR_ID,
	
	//ICACHE SIGNALS OUT
	output logic [31:0] ADDR_ICACHE,
	output logic READ_ICACHE,
	output logic [3:0] MEM_BYTE_EN_ICACHE,
	output logic [31:0] WDATA_ICACHE,
	output logic WRITE_ICACHE,

	//WAIT SIGNALS OUT
	output logic WAIT_IF
);
//pc convention. PC_NEXT is the combinationally determined next value of pc_if. pc_id is the previous value of pc_if etc through the stages.
//each stage is stored before the stage its named for and so is the pc of the instruction that stage is working on 

//internal registers
logic [31:0] PC_IF;
logic [31:0] IR_IF;
logic RESP_REG;

assign WRITE_ICACHE = 1'b0;
assign WDATA_ICACHE = 32'hxxxxxxxx;
assign MEM_BYTE_EN_ICACHE = 4'b1111;  // HARD CODE THIS HERE SO WE CAN USE THE SAME CACHE FOR IF AND MEM
assign WAIT_IF = (!(RESP_ICACHE || RESP_REG) && !BR_EN);
//assign WAIT_IF = 1'b0;
assign READ_ICACHE = (!(RESP_REG)) && !BR_EN;
//assign READ_ICACHE = 1'b1;
assign ADDR_ICACHE = PC_IF;

always_ff @(posedge clk) begin
	if(rst) begin
		PC_IF <= 32'h00000060;
		IR_IF <= 32'h00000000;
		PC_ID <= 32'h00000000;
		IR_ID <= 32'h00000000;
		RESP_REG <= 1'b0;
	end else if (BR_EN && !WAIT_MEM) begin
		PC_IF <= PC_JUMP;
		IR_IF <= 32'h00000000;
		PC_ID <= 32'h00000000;
		IR_ID <= 32'h00000000;
		RESP_REG <= 1'b0;
	end else if (WAIT_IF || WAIT_MEM) begin
		PC_IF <= PC_IF;
		PC_ID <= PC_ID;
		IR_ID <= IR_ID;
		if (RESP_ICACHE) begin
			RESP_REG <= 1'b1;
			IR_IF <= RDATA_ICACHE;
		end
	end else begin
		PC_IF <= PC_IF+4;
		PC_ID <= PC_IF;
		if (RESP_ICACHE) IR_ID <= RDATA_ICACHE;
		else IR_ID <= IR_IF;
		RESP_REG <= 1'b0;
		IR_IF <= 32'h00000000;
	end
end

endmodule : IF