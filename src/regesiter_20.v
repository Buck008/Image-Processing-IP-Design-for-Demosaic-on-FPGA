`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/05 21:35:45
// Design Name: 
// Module Name: regesiter_20
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module register_20
	(
		CLK,
		RESET,
        CLK_en,
		in,
		out
	);
	 
	parameter N=20;
	 
	input 				CLK,CLK_en;
	input					RESET;
	input		[N-1:0]	in;
	
	output	[N-1:0]	out;
	
	reg 		[N-1:0]	out;

	always @(posedge CLK or negedge RESET)begin
		if(!RESET)
			out <= 0;
		else if(!CLK_en)begin
			out <= out;
		end
		else begin
			 out <= in;
		end
	end			

			
endmodule
