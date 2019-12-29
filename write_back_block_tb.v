`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:01:30 09/12/2019
// Design Name:   write_back_block
// Module Name:   /media/yashrajkakkad/DATA/SEAS/Semester 3/CO Lab/MIPS_16bit/write_back_block_tb.v
// Project Name:  MIPS_16bit
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: write_back_block
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module write_back_block_tb;

	// Inputs
	reg [15:0] ans_dm;
	reg clk;
	reg reset;

	// Outputs
	wire [15:0] ans_wb;

	// Instantiate the Unit Under Test (UUT)
	write_back_block uut (
		.ans_wb(ans_wb), 
		.ans_dm(ans_dm), 
		.clk(clk), 
		.reset(reset)
	);

	initial begin
		// Initialize Inputs
		ans_dm = 0;
		clk = 0;
		reset = 1;

		#2;
		reset = 0;

		#3;
		reset = 1;

		#5;
		ans_dm = 16'hABCD;

		#5;
		ans_dm = 16'hFFFF;

		#5;
		ans_dm = 16'hDCBA;
		
		#5;
		ans_dm = 16'h0000;
	end

	always	#5 clk= ~clk;
      
endmodule

