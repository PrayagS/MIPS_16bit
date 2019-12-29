`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:38:35 12/10/2019
// Design Name:   floating_ieee754
// Module Name:   /mnt/DATA/SEAS/Semester 3/CO Lab/MIPS_16bit_copy_copy/floating_ieee754_tb.v
// Project Name:  MIPS_16bit
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: floating_ieee754
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module floating_ieee754_tb;

	// Inputs
	reg [15:0] A;
	reg [15:0] B;

	// Outputs
	wire [15:0] result;
	wire [11:0] mantissa_A;
	wire [11:0] mantissa_B;
	wire [4:0] exp_result;

	// Instantiate the Unit Under Test (UUT)
	floating_ieee754 uut (
		.result(result), 
		.mantissa_A(mantissa_A),
		.mantissa_B(mantissa_B),
		.exp_result(exp_result),
		.A(A), 
		.B(B)
	);

	initial begin
		// Initialize Inputs
		//A = 16'b0;
		//B = 16'b0;
		
		
		A= 16'b0_10010_0100000000;
		B= 16'b0_01111_0000000000;

		#100;
//		
		A = 16'b0011110000000001;
		B = 16'b0011110000000011;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		//3.25 + 1.75
		A = 16'b0_01111_1100000000;
		B = 16'b0_10000_1010000000;
		
//		#100;

		 // 14.75 + 12.25
		A=16'b0_10010_1001100000;
		B=16'b0_10010_1100100000;
		
//		#100;
		
		// 1+1
		A=16'b0_01111_0000000000;
		B=16'b0_01111_0000000000;
		
//		#100;
		
		// 2.5 + 10.5  khotu aave che
		A=16'b0_10010_0101000000;
		B=16'b0_01101_0100000000;
		
		#100;
	end
      
endmodule

