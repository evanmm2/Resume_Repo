/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module  startRAM
(
		
		input [10:0] StartAddress,
		input Clk,
		output logic [23:0] data_Out
);

logic [23:0] StartScreen [0:2047];

initial
begin
	 $readmemh("StartScreenDone.txt", StartScreen);
		

end


always_ff @ (posedge Clk) begin
	data_Out<= StartScreen[StartAddress];
	
end

endmodule
