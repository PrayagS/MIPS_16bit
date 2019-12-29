`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:58:31 09/12/2019 
// Design Name: 
// Module Name:    write_back_block 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module write_back_block(ans_wb, ans_dm, clk, reset);
input [15:0] ans_dm;
input clk, reset;
output reg [15:0] ans_wb;

//ans_wb gets the value of ans_dm, if not reset
always@(posedge clk)
begin
	if(reset) //Clock synchronous and negative level triggered
		ans_wb <= ans_dm;
	else
		ans_wb <= 0;
end


endmodule
