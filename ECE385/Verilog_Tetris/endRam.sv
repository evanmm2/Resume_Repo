/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module  endRAM
(
		
		input [10:0] EndAddress,
		input Clk,
		output logic [23:0] data_Out
);

logic [23:0] EndScreen [0:2047];

initial
begin
	 $readmemh("EndScreenDone.txt", EndScreen);
		

end


always_ff @ (posedge Clk) begin
	data_Out<= EndScreen[EndAddress];
	
end

endmodule
