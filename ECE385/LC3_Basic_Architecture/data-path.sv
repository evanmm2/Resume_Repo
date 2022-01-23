module datapath (
input logic Clk, Reset,
input logic MIO_EN,
input logic GatePC, GateMDR, GateALU, GateMARMUX, 
input logic LD_MAR, LD_MDR, LD_IR, LD_BEN, LD_CC, LD_REG, LD_PC, LD_LED, 
input logic ADDR1MUX, DRMUXS, SR1MUXS, SR2MUXS,
input logic Mem_OE, Mem_WE,
input logic [15:0]  Data_from_SRAM, Data_to_SRAM,
input logic [1:0]PCMUXS, ADDR2MUXS, ALUKS,
output logic [15:0]MAR, MDR, IR, PC,
output logic BEN_OUT
);
	logic [15:0] PCMUXOut, BUS;
	logic [15:0] IR5, IR7, IR10, IR11, ZEXT7;
	logic [15:0] ADDR2Out, ADDR1Out;
	logic [15:0] ADDER_Out, MDRMUXOut;
	logic [15:0] SR2_OUT, SR1_OUT, SR2MUX_OUT;
	logic [15:0] ALUK_OUT;
	logic [19:0] ADDR;
	logic [2:0]  DR_IN, SR1_IN, SR2;
	logic Nin, Zin, Pin;
	logic Nout, Zout, Pout;
	logic Jump_Bit;
	
//Muxes: There should be a total of around 7 muxes. Maybe 8
Mux4 #(16) PCMUX (.d0(PC + 1), .d1(BUS), .d2(ADDER_OUT), .d3(0), .s(PCMUXS), .y(PCMUXOut)); 
Mux2 #(16) MDRMUX(.d0(BUS), .d1(Data_from_SRAM), .s(MIO_EN), .y(MDRMUXOut));
Mux4 #(16) ADDER2MUX(.d0(4'h0000), .d1(IR10), .d2(IR7), .d3(IR5), .s(ADDR2MUX), .y(ADDR2Out));
Mux2 #(16) ADDER1MUX(.d0(PC), .d1(SR1_OUT), .s(ADDR1MUX), .y(ADDR1Out));
Mux2 #(16) SR2MUX(.d0(SR2_OUT), .d1(IR11), .s(SR2MUXS), .y(SR2MUX_OUT));
Mux2 #(16) SR1MUX(.d0(IR[11:9]), .d1(IR[8:6]), .s(SR1MUXS), .y(SR1_IN));
Mux2 #(16) DRMUX(.d0(IR[11:9]), .d1(3'b111), .s(DRMUXS), .y(DR_IN));
//4 Gates
GateMux Gates (.*, .Selector({GatePC, GateMARMUX, GateALU, GateMDR}), .Adder(ADDER_OUT),  .ALU(ALUK_OUT), .PC(PC), .MDR(MDR), .BUS(BUS));


// Flip Flops holding important data

flipflop PCFlop  (.Clk(Clk), .data(PCMUXOut), .Reset(Reset), .Load(LD_PC), .outdata(PC));

flipflop MARFlop (.Clk(Clk), .data(BUS), .Reset(Reset), .Load(LD_MAR), .outdata(MAR));

flipflop MDRFlop (.Clk(Clk), .data(MDRMUXOut), .Reset(Reset), .Load(LD_MDR), .outdata(MDR));

flipflop IRFlop  (.Clk(Clk), .data(BUS), .Reset(Reset), .Load(LD_IR), .outdata(IR));

//Sign Extension Blocks: There should be 4 for the main section. One zero exten for the memory area

SEXT5 extend_5 (.INPUT(IR[10:0]), .OUTPUT(IR5));
 
SEXT7 extend_7 (.INPUT(IR[8:0]), .OUTPUT(IR7));

SEXT9 extend_10 (.INPUT(IR[5:0]), .OUTPUT(IR10));

SEXT11 extend_11(.INPUT(IR[4:0]), .OUTPUT(IR11));

//ALUK

ALUK ALUK1 (.A(SR1_OUT), .B(SR2MUX_OUT), .Selector(ALUKS), .OUTPUT(ALUK_OUT));



//ALU to PC


carry_select_adder Adder (.A(ADDR1Out),.B(ADDR2Out),.Sum(ADDER_OUT),.CO());


//Register File

register_file Rfile (.A(BUS), .DRMUX(DR_IN), .SR2(IR[2:0]), .SR1MUX(SR1_IN), .SR1_OUT(SR1_OUT), .SR2_OUT(SR2_OUT)); 

// Control Signals Used: PCMUXS, MIO_EN, ADDR2MUX, ADDR1MUX, SR2MUXS, SR1MUXS, LD_PC
// Control Signals Cont: LD_MAR, LD_MDR, LD_IR, GatePC, GateMARMUX, GateALU, GateMDR
// Control Signals Cont: DRMUXS,

// Control Signals we Need to still implement: LD_BEN, LD_CC, LD_REG, LD_LED, Mem_OE, Mem_WE
// Control Signals We still need to implement: Data_from_sram, Data_to_sram. ALUKS

NZP_IN_LOGIC NZPIN(.BUS(BUS), .Nin(Nin), .Zin(Zin), .Pin(Pin));
NZP NZP_BLOCK(.Clk(Clk), .Load(LD_CC), .Reset(Reset), .Nin(Nin), .Zin(Zin), .Pin(Pin), .Pout(Pout), .Zout(Zout), .Nout(Nout));
NZP_OUT_LOGIC NZP_OUTPUT(.Nin(Nin), .Zin(Zin), .Pin(Pin), .IR(IR[11:9]), .Jump_Bit(Jump_Bit));

flipflop BENflop  (.Clk(Clk), .data(Jump_Bit), .Reset(Reset), .Load(LD_BEN), .outdata(BEN_OUT));

endmodule 