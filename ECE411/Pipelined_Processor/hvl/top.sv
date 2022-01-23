module mp4_tb;
`timescale 1ns/10ps

/********************* Do not touch for proper compilation *******************/
// Instantiate Interfaces
tb_itf itf();
rvfi_itf rvfi(itf.clk, itf.rst);

// Instantiate Testbench
source_tb tb(
    .magic_mem_itf(itf),
    .mem_itf(itf),
    .sm_itf(itf),
    .tb_itf(itf),
    .rvfi(rvfi)
);

// For local simulation, add signal for Modelsim to display by default
// Note that this signal does nothing and is not used for anything
bit f;
/****************************** End do not touch *****************************/

/************************ Signals necessary for monitor **********************/
logic first, second, third, fourth;
always_ff @(posedge itf.clk) begin
	if (((dut.datapath_mod.PC_JUMP + 8) == (dut.datapath_mod.PC_ID)) && dut.datapath_mod.BR_EN)
		first <= 1'b1;
	else 
		first <= 1'b0;
	second <= first;
	third <= second;
	fourth <= third;
	rvfi.halt <= fourth;
end
/*
assign rvfi.commit = (dut.datapath_mod.mem_mod.commit); // Set high when a valid instruction is modifying regfile or PC
//assign itf.halt = (dut.datapath_mod.exe_mod.PC_JUMP_IF == dut.datapath_mod.exe_mod.PC_EXE) && dut.datapath_mod.exe_mod.BR_EN_MEM;  // Set high when you detect an infinite loop. IF PC_NEXT = PC_IF
initial rvfi.order = 0;
always @(posedge itf.clk iff rvfi.commit) rvfi.order <= rvfi.order + 1; // Modify for OoO


//The following signals need to be set:
//Instruction and trap:
assign rvfi.inst 			= dut.datapath_mod.CACHE_DATA_MEM;
assign rvfi.trap 			= dut.datapath_mod.mem_mod.trap;
assign rvfi.halt			= dut.datapath_mod.KILL_ME_HARDER;

//Regfile:
assign rvfi.rs1_addr			= dut.datapath_mod.mem_mod.RS1_MEM;
assign rvfi.rs2_addr			= dut.datapath_mod.mem_mod.RS2_MEM;
assign rvfi.rs1_rdata			= dut.datapath_mod.mem_mod.RS1_OUT_MEM;
assign rvfi.rs2_rdata			= dut.datapath_mod.mem_mod.RS2_OUT_MEM;
assign rvfi.load_regfile		= dut.datapath_mod.REGFILE_LOAD_MEM_WB;
assign rvfi.rd_addr			= dut.datapath_mod.REGFILE_DESTINATION_MEM_WB;
assign rvfi.rd_wdata			= dut.datapath_mod.REGFILE_DATA_MEM_WB;

//PC:
assign rvfi.pc_rdata		= dut.datapath_mod.mem_mod.PC_RDATA_MON_MEM_WB;
assign rvfi.pc_wdata		= dut.datapath_mod.mem_mod.PC_WDATA_MON_MEM_WB;

//Memory:
assign rvfi.mem_addr		= dut.datapath_mod.mem_mod.ADDRESS_WB;
assign rvfi.mem_rmask		= dut.datapath_mod.mem_mod.rmask;
assign rvfi.mem_wmask		= dut.datapath_mod.mem_mod.wmask;
assign rvfi.mem_rdata		= dut.datapath_mod.mem_mod.RDATA_WB;
assign rvfi.mem_wdata		= dut.datapath_mod.mem_mod.WDATA_WB;


//Please refer to rvfi_itf.sv for more information.
*/

/**************************** End RVFIMON signals ****************************/

/********************* Assign Shadow Memory Signals Here *********************/
// This section not required until CP2

//The following signals need to be set:
//icache signals:
    assign itf.inst_read = dut.RDATA_ICACHE;
    assign itf.inst_addr = dut.ADDR_ICACHE;
    assign itf.inst_resp = dut.RESP_ICACHE;
    assign itf.inst_rdata = dut.RDATA_ICACHE;

//dcache signals:
    assign itf.data_read = dut.READ_DCACHE;
    assign itf.data_write = dut.WRITE_DCACHE;
    assign itf.data_mbe = dut.MEM_BYTE_EN_DCACHE;
    assign itf.data_addr = dut.ADDR_DCACHE;
    assign itf.data_wdata = dut.WDATA_DCACHE;
    assign itf.data_resp = dut.RESP_DCACHE;
    assign itf.data_rdata = dut.RDATA_DCACHE;

//Please refer to tb_itf.sv for more information.


/*********************** End Shadow Memory Assignments ***********************/

// Set this to the proper value
assign itf.registers = dut.datapath_mod.regfile_mod.data;

/*********************** Instantiate your design here ************************/

//The following signals need to be connected to your top level:
//Clock and reset signals:
    
    
mp4 dut(
	.clk(itf.clk),
	.rst(itf.rst),
	.mem_read(itf.mem_read),
	.mem_write(itf.mem_write),
	.mem_wdata(itf.mem_wdata),
	.mem_addr(itf.mem_addr),
	.mem_resp(itf.mem_resp),
	.mem_rdata(itf.mem_rdata)
);
//ICACHE ASSIGNMENTS
	assign inst_read = dut.READ_ICACHE;
    assign inst_addr = dut.ADDR_ICACHE;
    assign inst_resp = dut.RESP_ICACHE;
    assign inst_rdata = dut.RDATA_ICACHE;

//DCACHE ASSIGNMENTS
	assign data_read = dut.READ_DCACHE;
    assign data_write = dut.WRITE_DCACHE;
    assign data_mbe = dut.MEM_BYTE_EN_DCACHE;
    assign data_addr = dut.ADDR_DCACHE;
    assign data_wdata = dut.WDATA_DCACHE;
    assign data_resp = dut.RESP_DCACHE;
    assign data_rdata = dut.RDATA_DCACHE;

/*
riscv_formal_monitor_rv32imc monitor(
	.clock(itf.clk),
	.reset(itf.rst),
	.rvfi_valid(rvfi.commit), 
	.rvfi_order(rvfi.order),  
	.rvfi_halt(rvfi.halt),
    .rvfi_insn(rvfi.inst),
    .rvfi_trap(rvfi.trap),


    .rvfi_rs1_addr(rvfi.rs1_addr),
    .rvfi_rs2_addr(rvfi.rs2_addr),
    .rvfi_rs1_rdata(rvfi.rs1_rdata),
    .rvfi_rs2_rdata(rvfi.rs2_rdata),
    .rvfi_intr(rvfi.load_regfile),
    .rvfi_rd_addr(rvfi.rd_addr),
    .rvfi_rd_wdata(rvfi.rd_wdata),

    .rvfi_pc_rdata(rvfi.pc_rdata),
    .rvfi_pc_wdata(rvfi.pc_wdata),


    .rvfi_mem_addr(rvfi.mem_addr),
    .rvfi_mem_rmask(rvfi.mem_rmask),
    .rvfi_mem_wmask(rvfi.mem_wmask),
    .rvfi_mem_rdata(rvfi.mem_rdata),
    .rvfi_mem_wdata(rvfi.mem_wdata)
);
*/
/*
Burst Memory Ports:
    itf.mem_read
    itf.mem_write
    itf.mem_wdata
    itf.mem_rdata
    itf.mem_addr
    itf.mem_resp

Please refer to tb_itf.sv for more information.
*/

/***************************** End Instantiation *****************************/

endmodule
