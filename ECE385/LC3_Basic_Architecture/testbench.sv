module testbench();

timeunit 10ns;	// Half clock cycle at 50 MHz
			// This is the amount of time represented by #1 
timeprecision 1ns;



logic [15:0] S;
logic Clk, Reset, Run, Continue;
logic [11:0] LED;
logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;
logic CE, UB, LB, OE, WE;
logic [19:0] ADDR;
wire [15:0] Data;


logic [15:0]MAR, MDR, IR, PC;








lab6_toplevel L6(.*);




always begin : CLOCK_GENERATION
#1 Clk = ~Clk;
end

initial begin: CLOCK_INITIALIZATION
    Clk = 0;
end 



always_comb begin: INTERNAL_MONITORING 
PC = L6.my_slc.d0.PC;
MAR = L6.my_slc.d0.MAR;
MDR = L6.my_slc.d0.MDR;
IR = L6.my_slc.d0.IR;
end





initial begin: TEST_VECTORS


Reset=0;
Run=1;
Continue=1;

#2 Reset=1;
#2 Run=0;
#2 Run=1;

#5 Continue=0;
#5 Continue=1;

#10 Continue=0;
#10 Continue=1;

end

endmodule
