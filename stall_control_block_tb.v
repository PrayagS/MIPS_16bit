`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:51:24 09/12/2019
// Design Name:   stall_control_block
// Module Name:   /media/yashrajkakkad/DATA/SEAS/Semester 3/CO Lab/MIPS_16bit/stall_control_block_tb.v
// Project Name:  MIPS_16bit
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: stall_control_block
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module stall_control_block_tb;

	// Inputs
	reg [5:0] op;
	reg clk;
	reg reset;

	// Outputs
	wire stall;
	wire stall_pm;

	// Instantiate the Unit Under Test (UUT)
	stall_control_block uut (
		.stall(stall), 
		.stall_pm(stall_pm), 
		.op(op), 
		.clk(clk), 
		.reset(reset)
	);

	initial begin
		// Initialize Inputs
		op = 0;
		clk = 0;
		reset = 1'b1;

		#2;
		reset = 0;

		#6;
		reset = 1;
		
		#8;
		op = 6'b010100;
		
		#20;
		op = 6'b0;
		
		#10;
		op = 6'b011110;
		
		#30;
		op = 6'b0;
		
		#10;
		op = 6'b010001;
		
	end
	
	always #5 clk = ~clk;
      
endmodule

