`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:016:27 08/216/2019
// Design Name:   execution_block
// Module Name:   /media/yashrajkakkad/DATA/SEAS/Semester 3/CO Lab/Assignment 1/execution_block _fri/execution_block/execution_block/execution_block_tb.v
// Project Name:  execution_block
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: execution_block
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module execution_block_tb;

	// Inputs
	reg [15:0] A;
	reg [15:0] B;
	reg [15:0] data_in;
	reg [5:0] op_dec;
	reg clk;
	reg reset;

	// Outputs
	wire [15:0] ans_ex;
	wire [15:0] DM_data;
	wire [15:0] data_out;
	wire [1:0] flag_ex;

	// Instantiate the Unit Under Test (UUT)
	execution_block uut (
		.ans_ex(ans_ex), 
		.DM_data(DM_data), 
		.data_out(data_out), 
		.flag_ex(flag_ex),
		.A(A), 
		.B(B), 
		.data_in(data_in), 
		.op_dec(op_dec), 
		.clk(clk), 
		.reset(reset)
	);

	initial begin
		// Initialize Inputs
		A = 0;
		B = 0;
		data_in = 0;
		clk = 0;
		reset = 1;

		#2;
		reset = 0;
				
		#6;
		reset = 1;
		
		#2;
		A = 16'h4000;
		B = 16'hC000;
		op_dec = 0;
		data_in = 16'h0008;
		
		#10;
		op_dec = 1;

		#10;
		op_dec = 2;
		
		#10;
		op_dec = 4;

		#10;
		op_dec = 5;
		 
		#10;
		op_dec = 6;
		 
		#10;
		op_dec = 7;
		 
		#10;
		op_dec = 8;
		
		#10;
		op_dec = 9;
		 
		#10;
		op_dec = 10;
		 
		#10;
		op_dec = 12;
		
		#10;
		op_dec = 13;
		 
		#10;
		op_dec = 14;

		#10;
		op_dec = 15;
		 
		#10;
		op_dec = 16;
		 
		#10;
		op_dec = 17;
		 
		#10;
		op_dec = 20;
		 
		#10;
		op_dec = 21;
		 
		#10;
		op_dec = 22;
		 
		#10;
		op_dec = 23;
		 
		#10;
		op_dec = 24;
		 
		#10;
		A = 16'hC000;
		B = 16'h0001;
		op_dec = 25;
		 
		#10;
		op_dec = 26;
		 
		#10;
		op_dec = 27;
		 
		#10;
		op_dec = 28;
		 
		#10;
		op_dec = 29;
		 
		#10;
		op_dec = 30;
		 
		#10;
		op_dec = 31;
		 
		//Added for self-testing
		#10;		
		A = 16'h4000;
		B = 16'hC000;
		op_dec = 1;
		
		#10;
		op_dec = 28;
		
		#10;
		op_dec = 29;
	end
	
	always #5 clk = ~clk;
    
endmodule

