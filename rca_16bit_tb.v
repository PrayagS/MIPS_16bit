`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:52:38 08/22/2019
// Design Name:   rca_16bit
// Module Name:   C:/Users/student/Desktop/New folder/execution_block/rca_16bit_tb.v
// Project Name:  execution_block
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: rca_16bit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module rca_16bit_tb;

	// Inputs
	reg [15:0] A;
	reg [15:0] B;
	reg operator;

	// Outputs
	wire [15:0] s_d;
	wire c_b;
	wire overflow;

	// Instantiate the Unit Under Test (UUT)
	rca_16bit uut (
		.s_d(s_d), 
		.c_b(c_b), 
		.overflow(overflow), 
		.A(A), 
		.B(B), 
		.operator(operator)
	);

	initial begin
		// Initialize Inputs
		A = 0;
		B = 0;
		operator = 0;

		// Wait 100 ns for global reset to finish
		#100;
		A = 5;
		B = 10;
		
		#100;
		operator = 1;
		A = 10;
		B = 5;

		#100;
		operator = 0;
		A = 16'b0111111111111111;
		B = 16'b0000000000000001;
		
		// Add stimulus here

	end
      
endmodule

