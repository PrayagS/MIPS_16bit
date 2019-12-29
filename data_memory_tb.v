`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:56:32 09/05/2019
// Design Name:   data_memory
// Module Name:   /media/yashrajkakkad/DATA/SEAS/Semester 3/CO Lab/MIPS_16bit/data_memory_tb.v
// Project Name:  MIPS_16bit
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: data_memory
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module data_memory_tb;

	// Inputs
	reg [15:0] ans_ex;
	reg [15:0] DM_data;
	reg mem_rw_ex;
	reg mem_en_ex;
	reg mem_mux_sel_dm;
	reg reset;
	reg clk;

	// Outputs
	wire [15:0] ans_dm;

	// Instantiate the Unit Under Test (UUT)
	data_memory uut (
		.ans_dm(ans_dm), 
		.ans_ex(ans_ex), 
		.DM_data(DM_data), 
		.mem_rw_ex(mem_rw_ex), 
		.mem_en_ex(mem_en_ex), 
		.mem_mux_sel_dm(mem_mux_sel_dm), 
		.reset(reset), 
		.clk(clk)
	);

	initial begin
		// Initialize Inputs
		ans_ex = 16'h0003;
		DM_data = 16'hFFFF;
		mem_rw_ex = 0;
		mem_en_ex = 0;
		mem_mux_sel_dm = 0;
		reset = 1;
		clk = 0;

		#2;
		reset = 0;
		
		#6;
		reset = 1;
		
		#2;
		mem_en_ex = 1;
		mem_mux_sel_dm = 1;
		
		#10;
		mem_rw_ex = 1;
		
		#10;
		mem_rw_ex = 0;
	end

	always #5 clk = ~clk;
endmodule

