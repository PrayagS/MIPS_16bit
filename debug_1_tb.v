`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:23:42 10/10/2019
// Design Name:   debug_1
// Module Name:   /mnt/DATA/SEAS/Semester 3/CO Lab/MIPS_16bit/debug_1_tb.v
// Project Name:  MIPS_16bit
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: debug_1
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module debug_1_tb;

	// Inputs
	reg [15:0] data_in;
	reg clk;
	reg interrupt;
	reg reset;

	// Outputs
	wire [15:0] data_out;
	wire [31:0] ins;
	wire [15:0] A;
	wire [15:0] B;
	wire [15:0] current_address;
	wire [15:0] ans_ex;
	wire [15:0] ans_dm;
	wire [15:0] ans_wb;
	wire [1:0] mux_sel_A;
	wire [1:0] mux_sel_B;
	wire imm_sel;

	// Instantiate the Unit Under Test (UUT)
	debug_1 uut (
		.data_out(data_out), 
		.ins(ins), 
		.A(A), 
		.B(B), 
		.current_address(current_address), 
		.ans_ex(ans_ex), 
		.ans_dm(ans_dm), 
		.ans_wb(ans_wb), 
		.mux_sel_A(mux_sel_A), 
		.mux_sel_B(mux_sel_B), 
		.imm_sel(imm_sel), 
		.data_in(data_in), 
		.clk(clk), 
		.interrupt(interrupt), 
		.reset(reset)
	);

	initial begin
		data_in = 0;
		clk = 0;
		interrupt = 0;
		reset = 1;

		#200;
		reset = 0;

		#500;
		reset = 1;
	end
      
	always #500 clk = ~clk;
endmodule

