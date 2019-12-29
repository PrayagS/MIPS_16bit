`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:08:46 09/19/2019
// Design Name:   jump_control_block
// Module Name:   /media/yashrajkakkad/DATA/SEAS/Semester 3/CO Lab/MIPS_16bit/jump_control_block_tb.v
// Project Name:  MIPS_16bit
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: jump_control_block
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module jump_control_block_tb;

	// Inputs
	reg [15:0] jmp_address_pm;
	reg [15:0] current_address;
	reg [5:0] op;
	reg [1:0] flag_ex;
	reg interrupt;
	reg clk;
	reg reset;

	// Outputs
	wire [15:0] jmp_loc;
	wire pc_mux_sel;

	// Instantiate the Unit Under Test (UUT)
	jump_control_block uut (
		.jmp_loc(jmp_loc), 
		.pc_mux_sel(pc_mux_sel), 
		.jmp_address_pm(jmp_address_pm), 
		.current_address(current_address), 
		.op(op), 
		.flag_ex(flag_ex), 
		.interrupt(interrupt), 
		.clk(clk), 
		.reset(reset)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		current_address = 16'h0001;
		jmp_address_pm = 0;
		flag_ex = 2'b11;
		interrupt = 1'b0;
		reset = 1;
		op = 0;

		#2;
		reset = 0;

		#6;
		reset = 1;

		#8;
		interrupt = 1'b1;

		#10;
		jmp_address_pm = 16'h0008;
		interrupt = 1'b0;

		#10;
		op = 6'h18;

		#20;
		op = 6'h10;
		flag_ex = 0;

		#10;
		//I changed this
		jmp_address_pm = 16'h0010;
		op = 6'h1e;
		
		#20;
		//I changed this
		jmp_address_pm = 16'h0011;
		op=6'h01;
		
		#20;
		jmp_address_pm = 16'h1010;
		op = 6'h1e;
	end

	always #5 clk = ~clk;
endmodule

