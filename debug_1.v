`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:52:21 10/10/2019 
// Design Name: 
// Module Name:    debug_1 
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
module debug_1(data_out, ins, A, B, current_address, ans_ex, ans_dm, ans_wb, mux_sel_A, mux_sel_B, imm_sel,
data_in, clk, interrupt, reset);

//Output for MIPS
output [15:0] data_out;

//Outputs for verification and timing analysis
output [31:0] ins;
output [15:0] A, B, current_address, ans_ex, ans_dm, ans_wb;
output [1:0] mux_sel_A, mux_sel_B;
output imm_sel;

//Input for MIPS
input [15:0] data_in;
input clk, interrupt, reset;

//Data exchanged between different blocks
wire [15:0] DM_data;
wire [1:0] flag_ex;
wire [5:0] op_dec;
wire pc_mux_sel, stall, stall_pm; 
wire [15:0] jmp_loc, imm;
wire [4:0] RW_dm;
wire mem_mux_sel_dm, mem_rw_ex, mem_en_ex;
wire [15:0] jmp_address_pm = ins[15:0];
wire [4:0] RA = ins[20:16];
wire [4:0] RB = ins[15:11];

execution_block ex(ans_ex, DM_data, data_out, flag_ex, A, B, data_in, op_dec, clk, reset);
program_memory pm(ins, current_address, jmp_loc, pc_mux_sel, stall, stall_pm, reset, clk);
register_bank rb(A, B, ans_ex, ans_dm, ans_wb, imm, RA, RB, RW_dm, mux_sel_A, mux_sel_B, imm_sel, clk);
data_memory dm(ans_dm, ans_ex, DM_data, mem_rw_ex, mem_en_ex, mem_mux_sel_dm, reset, clk);
write_back_block wb(ans_wb, ans_dm, clk, reset);

// Control blocks
stall_control_block sc(stall, stall_pm, op_dec, clk, reset);
jump_control_block jc(jmp_loc, pc_mux_sel, jmp_address_pm, current_address, op_dec, flag_ex, interrupt, clk, reset);
data_dependency_block dd(imm, op_dec, RW_dm, mux_sel_A, mux_sel_B, imm_sel, mem_en_ex, mem_rw_ex,mem_mux_sel_dm, ins, clk, reset);

endmodule
