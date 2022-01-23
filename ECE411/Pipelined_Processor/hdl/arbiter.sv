module arbiter
(
	input logic clk,
	input logic rst,
	
	//if_cache 
	input logic READ_ICACHE,
	input logic [31:0] ADDR_ICACHE,
	output logic RESP_ICACHE,
	output logic [255:0] RDATA_ICACHE,
	
	//data_cache
	input logic READ_DCACHE,
	input logic WRITE_DCACHE,
	input logic [31:0] ADDR_DCACHE,
	input logic [255:0] WDATA_DCACHE,
	output logic RESP_DCACHE,
	output logic [255:0] RDATA_DCACHE,
	
	//pmem
	input logic PMEM_RESP,
	input logic [255:0] PMEM_RDATA,
	output logic PMEM_READ,
	output logic PMEM_WRITE,
	output logic [31:0] ADDRESS_PMEM,
	output logic [255:0] PMEM_WDATA
);

//signal declerations
logic cache_sel;
logic [255:0] ADAPTOR_REG;
logic [255:0] ADAPTOR_REG_NEXT;


//datapath
always_comb begin
	unique case (cache_sel)
		1'b0: begin
			ADDRESS_PMEM = ADDR_ICACHE;
			PMEM_WDATA = 32'h00000000;
			RDATA_ICACHE = ADAPTOR_REG;
			
			//set these outputs for Data cache
			RDATA_DCACHE = 32'h00000000;
		end
		1'b1: begin
			ADDRESS_PMEM = ADDR_DCACHE;
			PMEM_WDATA = WDATA_DCACHE;
			RDATA_DCACHE = ADAPTOR_REG;
			
			//set these outputs for Data cache
			RDATA_ICACHE = 32'h00000000;
		end
	endcase
end

//state def
enum int unsigned {
	wait_state = 0,
	if_state = 1,
	d_state = 2,
	if_done = 3,
	d_done = 4
} state, next_state;

//state machine actions
always_comb begin
	ADAPTOR_REG_NEXT = 256'h0;
	unique case (state)
		wait_state: begin
							cache_sel = 1'b0;
							RESP_ICACHE = 1'b0;
							RESP_DCACHE = 1'b0;
							PMEM_WRITE = 1'b0;
							PMEM_READ = 1'b0;
						end
		if_state:	begin
							cache_sel = 1'b0;
							RESP_ICACHE = 1'b0;
							RESP_DCACHE = 1'b0;
							ADAPTOR_REG_NEXT = PMEM_RDATA;
							PMEM_WRITE = 1'b0;
							PMEM_READ = 1'b1;
						end
		d_state:		begin
							cache_sel = 1'b1;
							RESP_ICACHE = 1'b0;
							RESP_DCACHE = 1'b0;
							ADAPTOR_REG_NEXT = PMEM_RDATA;
							PMEM_WRITE = WRITE_DCACHE;
							PMEM_READ = READ_DCACHE;
						end
		if_done:		begin
							cache_sel = 1'b0;
							RESP_ICACHE = 1'b1;
							RESP_DCACHE = 1'b0;
							PMEM_WRITE = 1'b0;
							PMEM_READ = 1'b0;
						end
		d_done:		begin
							cache_sel = 1'b1;
							RESP_ICACHE = 1'b0;
							RESP_DCACHE = 1'b1;
							PMEM_WRITE = 1'b0;
							PMEM_READ = 1'b0;
						end
	endcase
end

//state transitions
always_comb begin
	unique case (state)
		wait_state: begin
			if (READ_ICACHE)
				next_state = if_state;
			else if (READ_DCACHE | WRITE_DCACHE)
				next_state = d_state;
			else 
				next_state = wait_state;
		end
		if_state: begin
			if (PMEM_RESP)
				next_state = if_done;
			else 
				next_state = if_state;
		end
		if_done: begin
			if (READ_DCACHE | WRITE_DCACHE)
				next_state = d_state;
			else 
				next_state = wait_state;
		end
		d_state: begin
			if (PMEM_RESP)
				next_state = d_done;
			else 
				next_state = d_state;
		end
		d_done: begin
			if (READ_ICACHE)
				next_state = if_state;
			else 
				next_state = wait_state;
		end
	endcase
end

//state assignment
always_ff @(posedge clk or posedge rst) begin
	if (rst)
		state <= wait_state;
	else
		state <= next_state;
		
	if(rst)
		ADAPTOR_REG <= 256'h0;
	else
		ADAPTOR_REG <= ADAPTOR_REG_NEXT;
end

endmodule : arbiter