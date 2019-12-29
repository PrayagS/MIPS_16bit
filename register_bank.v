`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:14:04 09/05/2019 
// Design Name: 
// Module Name:    register_bank 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module register_bank(A, B, ans_ex, ans_dm, ans_wb, imm, RA, RB, RW_dm, mux_sel_A, mux_sel_B, imm_sel, clk);
output [15:0] A, B;
input [15:0] ans_ex, ans_dm, ans_wb, imm;
input [4:0] RA, RB, RW_dm;
input [1:0] mux_sel_A, mux_sel_B;
input imm_sel, clk;
wire [15:0] BI;

reg [15:0] reg_bank_data [0:31];
reg [15:0] AR, BR;

always@(posedge clk)
begin
	AR <= reg_bank_data[RA];
	BR <= reg_bank_data[RB];
	reg_bank_data[RW_dm] <= ans_dm;
end

assign A = (mux_sel_A == 2'b00) ? AR : 
			  (mux_sel_A == 2'b01) ? ans_ex : 
			  (mux_sel_A == 2'b10) ? ans_dm : ans_wb;
assign BI = (mux_sel_B == 2'b00) ? BR : 
			  (mux_sel_B == 2'b01) ? ans_ex : 
			  (mux_sel_B == 2'b10) ? ans_dm : ans_wb;
assign B = (imm_sel == 1'b0) ? BI : imm;

endmodule
