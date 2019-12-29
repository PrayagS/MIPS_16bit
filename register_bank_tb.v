`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:29:54 09/05/2019
// Design Name:   register_bank
// Module Name:   /media/yashrajkakkad/DATA/SEAS/Semester 3/CO Lab/MIPS_16bit/register_bank_tb.v
// Project Name:  MIPS_16bit
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: register_bank
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module register_bank_tb;

	// Inputs
	reg [15:0] ans_ex;
	reg [15:0] ans_dm;
	reg [15:0] ans_wb;
	reg [15:0] imm;
	reg [4:0] RA;
	reg [4:0] RB;
	reg [4:0] RW_dm;
	reg [1:0] mux_sel_A;
	reg [1:0] mux_sel_B;
	reg imm_sel;
	reg clk;

	// Outputs
	wire [15:0] A;
	wire [15:0] B;

	// Instantiate the Unit Under Test (UUT)
	register_bank uut (
		.A(A), 
		.B(B), 
		.ans_ex(ans_ex), 
		.ans_dm(ans_dm), 
		.ans_wb(ans_wb), 
		.imm(imm), 
		.RA(RA), 
		.RB(RB), 
		.RW_dm(RW_dm), 
		.mux_sel_A(mux_sel_A), 
		.mux_sel_B(mux_sel_B), 
		.imm_sel(imm_sel), 
		.clk(clk)
	);

	initial begin
		// Initialize Inputs
		ans_ex = 16'hC000;
		ans_dm = 16'hD000;
		ans_wb = 16'hE000;
		imm = 16'hFFFF;
		RA = 5'b00101;
		RB = 5'b00110;
		RW_dm = 5'b00111;
		mux_sel_A = 0;
		mux_sel_B = 0;
		imm_sel = 1;
		clk = 0;

		#10;
		RB = 5'b00111;
		imm_sel = 0;
		mux_sel_A = 2'b10;
		mux_sel_B = 2'b01;
		
		#10;
		mux_sel_A = 2'b11;
		mux_sel_B = 2'b00;
				
	end

	always #5 clk = ~clk;
endmodule

