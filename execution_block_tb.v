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
		
		// #5 clk = ~clk;
		
		#10;
		A = 16'h4000;
		B = 16'hC000;
		op_dec = 1;
		data_in = 16'h0008;

		// #5 clk = ~clk;

		#10;
		A = 16'h4000;
		B = 16'hC000;
		op_dec = 2;
		data_in =16'h0008;
		
		// #5 clk = ~clk;
		
		#10;
		A = 16'h4000;
		B = 16'hC000;
		op_dec = 4;
		data_in = 16'h0008;
		
		// #5 clk = ~clk;

		#10;
		A = 16'h4000;
		B = 16'hC000;
		op_dec = 5;
		data_in = 16'h0008;
		
		// #5 clk = ~clk;
		 
		#10;
		A = 16'h4000;
		B = 16'hC000;
		op_dec = 6;
		data_in = 16'h0008;
		
		// #5 clk = ~clk;
		 
		#10;
		A = 16'h4000;
		B = 16'hC000;
		op_dec = 7;
		data_in = 16'h0008;
		
		// #5 clk = ~clk;
		 
		#10;
		A = 16'h4000;
		B = 16'hC000;
		op_dec = 8;
		data_in = 16'h0008;
		
		// #5 clk = ~clk;
		 
		#10;
		A = 16'h4000;
		B = 16'hC000;
		op_dec = 9;
		data_in = 16'h0008;
		
		// #5 clk = ~clk;
		 
		#10;
		A = 16'h4000;
		B = 16'hC000;
		op_dec = 10;
		data_in = 16'h0008;
		
		// #5 clk = ~clk;
		 
		#10;
		A = 16'h4000;
		B = 16'hC000;
		op_dec = 12;
		data_in = 16'h0008;
		
		// #5 clk = ~clk;
		
		#10;
		A = 16'h4000;
		B = 16'hC000;
		op_dec = 13;
		data_in = 16'h0008;
		
		// #5 clk = ~clk;
		 
		#10;
		A = 16'h4000;
		B = 16'hC000;
		op_dec = 14;
		data_in = 16'h0008;
		
		// #5 clk = ~clk;
		 
		#10;
		A = 16'h4000;
		B = 16'hC000;
		op_dec = 15;
		data_in = 16'h0008;
		
		// #5 clk = ~clk;
		 
		#10;
		A = 16'h4000;
		B = 16'hC000;
		op_dec = 16;
		data_in = 16'h0008;
		
		// #5 clk = ~clk;
		 
		#10;
		A = 16'h4000;
		B = 16'hC000;
		op_dec = 17;
		data_in = 16'h0008;
		
		// #5 clk = ~clk;
		 
		#10;
		A = 16'h4000;
		B = 16'hC000;
		op_dec = 20;
		data_in = 16'h0008;
		
		// #5 clk = ~clk;
		 
		#10;
		A = 16'h4000;
		B = 16'hC000;
		op_dec = 21;
		data_in = 16'h0008;
		
		// #5 clk = ~clk;
		 
		#10;
		A = 16'h4000;
		B = 16'hC000;
		op_dec = 22;
		data_in = 16'h0008;
		
		// #5 clk = ~clk;
		 
		#10;
		A = 16'h4000;
		B = 16'hC000;
		op_dec = 23;
		data_in = 16'h0008;
		
		// #5 clk = ~clk;
		 
		#10;
		A = 16'h4000;
		B = 16'hC000;
		op_dec = 24;
		data_in = 16'h0008;
		
		// #5 clk = ~clk;
		 
		#10;
		A = 16'hC000;
		B = 16'h0001;
		op_dec = 25;
		data_in = 16'h0008;
		
		// #5 clk = ~clk;
		 
		#10;
		A = 16'hC000;
		B = 16'h0001;
		op_dec = 26;
		data_in = 16'h0008;
		
		// #5 clk = ~clk;
		 
		#10;
		A = 16'hC000;
		B = 16'h0001;
		op_dec = 27;
		data_in = 16'h0008;
		
		// #5 clk = ~clk;
		 
		#10;
		A = 16'hC000;
		B = 16'h0001;
		op_dec = 28;
		data_in = 16'h0008;
		
		// #5 clk = ~clk;
		 
		#10;
		A = 16'hC000;
		B = 16'h0001;
		op_dec = 29;
		data_in = 16'h0008;
		
		// #5 clk = ~clk;
		 
		#10;
		A = 16'hC000;
		B = 16'h0001;
		op_dec = 30;
		data_in = 16'h0008;
		
		// #5 clk = ~clk;
		 
		#10;
		A = 16'hC000;
		B = 16'h0001;
		op_dec = 31;
		data_in = 16'h0008;
		 
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

