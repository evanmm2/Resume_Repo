module mp4(
input logic clk,
input logic rst,

//PHYSICAL MEMORY SIGNALS
output logic mem_read,
output logic mem_write,
output logic [63:0] mem_wdata,
output logic [31:0] mem_addr,
input logic mem_resp,
input logic [63:0] mem_rdata

);

//CACHE_IF INPUT/OUTPUTS
logic [31:0] RDATA_ICACHE;
logic RESP_ICACHE;
logic WRITE_ICACHE;
logic [31:0] WDATA_ICACHE;
logic [3:0] MEM_BYTE_EN_ICACHE;
logic READ_ICACHE;
logic [31:0] ADDR_ICACHE;

//CACHE_D INPUT/OUTPUTS
logic WRITE_DCACHE;
logic READ_DCACHE;
logic [31:0] WDATA_DCACHE;
logic [31:0] ADDR_DCACHE;
logic [3:0] MEM_BYTE_EN_DCACHE;
logic RESP_DCACHE;
logic [31:0] RDATA_DCACHE;

//SIGNALS BETWEEN ICACHE AND ARBITER
logic READ_ICACHE_A;
logic [31:0] ADDR_ICACHE_A;
logic RESP_ICACHE_A;
logic [255:0] RDATA_ICACHE_A;

//SIGNALS BETWEEN DCACHE AND ARBITER
logic READ_DCACHE_A;
logic WRITE_DCACHE_A;
logic [31:0] ADDR_DCACHE_A;
logic [255:0] WDATA_DCACHE_A;
logic RESP_DCACHE_A;
logic [255:0] RDATA_DCACHE_A;

//SIGNALS BETWEEN ARBITER AND CACHELINE_ADAPTOR
logic PMEM_RESP_A;
logic [255:0] PMEM_RDATA_A;
logic PMEM_READ_A;
logic PMEM_WRITE_A;
logic [31:0] ADDRESS_PMEM_A;
logic [255:0] PMEM_WDATA_A;


datapath datapath_mod(
	.*
);

cache cache_if_mod (
	.mem_read(READ_ICACHE),
	.mem_write(WRITE_ICACHE),
	.mem_byte_enable_cpu(MEM_BYTE_EN_ICACHE),
	.mem_address(ADDR_ICACHE),
	.mem_wdata_cpu(WDATA_ICACHE),
	.mem_resp(RESP_ICACHE),
	.mem_rdata_cpu(RDATA_ICACHE),
	.pmem_resp(RESP_ICACHE_A),
	.pmem_rdata(RDATA_ICACHE_A),
	.pmem_wdata(),
	.pmem_address(ADDR_ICACHE_A),
	.pmem_read(READ_ICACHE_A),
	.pmem_write(),
	.*
);

cache cache_d_mod (
	.mem_read(READ_DCACHE),
	.mem_write(WRITE_DCACHE),
	.mem_byte_enable_cpu(MEM_BYTE_EN_DCACHE),
	.mem_address(ADDR_DCACHE),
	.mem_wdata_cpu(WDATA_DCACHE),
	.mem_resp(RESP_DCACHE),
	.mem_rdata_cpu(RDATA_DCACHE),
	.pmem_resp(RESP_DCACHE_A),
	.pmem_rdata(RDATA_DCACHE_A),
	.pmem_wdata(WDATA_DCACHE_A),
	.pmem_address(ADDR_DCACHE_A),
	.pmem_read(READ_DCACHE_A),
	.pmem_write(WRITE_DCACHE_A),
	.*
);

arbiter arbiter_mod (
	.READ_ICACHE(READ_ICACHE_A),
	.ADDR_ICACHE(ADDR_ICACHE_A),
	.RESP_ICACHE(RESP_ICACHE_A),
	.RDATA_ICACHE(RDATA_ICACHE_A),
	.READ_DCACHE(READ_DCACHE_A),
	.WRITE_DCACHE(WRITE_DCACHE_A),
	.ADDR_DCACHE(ADDR_DCACHE_A),
	.WDATA_DCACHE(WDATA_DCACHE_A),
	.RESP_DCACHE(RESP_DCACHE_A),
	.RDATA_DCACHE(RDATA_DCACHE_A),
	.PMEM_RESP(PMEM_RESP_A),
	.PMEM_RDATA(PMEM_RDATA_A),
	.PMEM_READ(PMEM_READ_A),
	.PMEM_WRITE(PMEM_WRITE_A),
	.ADDRESS_PMEM(ADDRESS_PMEM_A),
	.PMEM_WDATA(PMEM_WDATA_A),
	.*
);

cacheline_adaptor cacheline_adaptor_mod (
	.line_i(PMEM_WDATA_A),
   .line_o(PMEM_RDATA_A),
   .address_i(ADDRESS_PMEM_A),
   .read_i(PMEM_READ_A),
   .write_i(PMEM_WRITE_A),
   .resp_o(PMEM_RESP_A),
	.burst_i(mem_rdata),
   .burst_o(mem_wdata),
   .address_o(mem_addr),
   .read_o(mem_read),
   .write_o(mem_write),
	.resp_i(mem_resp),
	.*
);

endmodule : mp4
