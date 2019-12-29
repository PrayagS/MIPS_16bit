`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:11:19 10/03/2019 
// Design Name: 
// Module Name:    data_dependency_block 
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
module data_dependency_block(imm,op_dec,RW_dm,mux_sel_A,mux_sel_B,imm_sel,mem_en_ex,mem_rw_ex,mem_mux_sel_dm,ins,clk,reset);
output reg [15:0] imm;
output reg [5:0] op_dec;
output reg [4:0] RW_dm;
output [1:0] mux_sel_A,mux_sel_B;
output mem_en_ex,mem_rw_ex,mem_mux_sel_dm;
output imm_sel;

input [31:0] ins;
input clk,reset;

wire [5:0] op_tmp = ins[31:26];
// assign op_tmp[0] = ins[26];
// assign op_tmp[1] = ins[27];
// assign op_tmp[2] = ins[28];
// assign op_tmp[3] = ins[29];
// assign op_tmp[4] = ins[30];
// assign op_tmp[5] = ins[31];

always@(posedge clk)
begin
	if(reset)
	begin
		op_dec <= op_tmp;	
	end
	else
	begin
		op_dec <= 0;
	end
end


wire LD_fb_after_LD;

assign JMP = op_tmp == 6'b011000; 
assign Cond_J = op_tmp[5] == 0 && op_tmp[4] == 1 && op_tmp[3] == 1 && op_tmp[2] == 1;
assign LD_fb = op_tmp == 6'b010100 && ~LD_fb_after_LD; 
assign Imm = op_tmp[5] == 0 && op_tmp[4] == 0 && op_tmp[3] == 1;
assign LD_op = op_tmp==6'b010100;
assign ST =  op_tmp==6'b010101;

d_flip_flop LD_fb_dff(LD_fb_after_LD, LD_fb, clk, reset);

wire [14:0] jump_flag;
assign jump_flag = ~(JMP || Cond_J || LD_fb_after_LD) ? 15'b111111111111111 : 15'b0;

wire [14:0] tmp=ins[25:11];

wire [14:0] operand_addresses = tmp & jump_flag;

wire [4:0] RB=operand_addresses[4:0];
wire [4:0] RA=operand_addresses[9:5];
wire [4:0] RD=operand_addresses[14:10];

reg [4:0] RD_if_id, RD_id_ex, RD_ex_mem, RD_mem_wb;
reg [4:0] RA_if_id, RB_if_id;

always@(posedge clk)
begin
	if(reset)
	begin
		RD_if_id <= RD;
		RD_id_ex <= RD_if_id;
		RD_ex_mem <= RD_id_ex;
		RD_mem_wb <= RD_ex_mem;
		RW_dm <= RD_id_ex;
		
		RA_if_id <= RA;
		RB_if_id <= RB;
	end
	else
	begin
		RD_if_id <= 0;
		RD_id_ex <= 0;
		RD_ex_mem <= 0;
		RD_mem_wb <= 0;
		RW_dm <= 0;
		
		RA_if_id <= 0;
		RB_if_id <= 0;		
	end	
end

wire RA_equals_id_ex = (RA_if_id == RD_id_ex);
wire RA_equals_ex_mem = (RA_if_id == RD_ex_mem);
wire RA_equals_mem_wb = (RA_if_id == RD_mem_wb);

assign mux_sel_A = (RA_equals_id_ex) ? 2'b01 : (RA_equals_ex_mem) ? 2'b10 : (RA_equals_mem_wb) ? 2'b11 : 2'b00;
 
wire RB_equals_id_ex = (RB_if_id == RD_id_ex);
wire RB_equals_ex_mem = (RB_if_id == RD_ex_mem);
wire RB_equals_mem_wb = (RB_if_id == RD_mem_wb);

assign mux_sel_B = (RB_equals_id_ex) ? 2'b01 : (RB_equals_ex_mem) ? 2'b10 : (RB_equals_mem_wb) ? 2'b11 : 2'b00;
 

wire [15:0] imm_tmp = ins[15:0];
always@(posedge clk)
begin
	if(reset)
	begin
		imm <= imm_tmp;
	end
	else
	begin
		imm <= 0;
	end
end  



d_flip_flop imm_sel_dff(imm_sel,Imm,clk,reset);


d_flip_flop delayed_mem_rw_ex_dff(out_delayed_mem_rw_ex, ins[0], clk, reset);
d_flip_flop mem_rw_ex_dff(mem_rw_ex, out_delayed_mem_rw_ex, clk, reset);
d_flip_flop delayed_mem_en_ex_dff(out_delayed_mem_en_ex, ST, clk, reset);

wire LD_op_after_LD;
wire LD_op_and_prv = ~LD_op_after_LD && LD_op;
d_flip_flop delayed_LD_dff(LD_op_after_LD, LD_op_and_prv, clk, reset);

wire LD_or_ST = (LD_op_after_LD || out_delayed_mem_en_ex );
wire delayed_mmsd_in = ~out_delayed_mem_rw_ex & LD_or_ST; 
wire mmsd_in;

d_flip_flop delayed_mem_mux_sel_dm_dff(mmsd_in, delayed_mmsd_in, clk, reset);
d_flip_flop mem_mux_sel_dm_dff(mem_mux_sel_dm, mmsd_in, clk, reset);

d_flip_flop mem_en_ex_dff(mem_en_ex, LD_or_ST,clk, reset);


endmodule

// module d_flip_flop(Q,D,clk,reset);
// output reg Q;
// input D, clk, reset;
// always@(posedge clk)
// 	begin
// 		if(reset)
// 			Q <= D;
// 		else
// 			Q <= 1'b0;
// 	end
// endmodule

