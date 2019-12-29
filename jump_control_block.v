`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:01:23 09/19/2019 
// Design Name: 
// Module Name:    jump_control_block 
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
module jump_control_block(jmp_loc, pc_mux_sel, jmp_address_pm, current_address, op, flag_ex, interrupt, clk, reset);

input [15:0] jmp_address_pm, current_address;
input [5:0] op;
input [1:0] flag_ex;
input interrupt, clk;
input reset;
output [15:0] jmp_loc;
output pc_mux_sel;

//Wires corresponding to op_code
wire JV, JNV, JZ, JNZ, JMP, RET;

assign JV = (op == 6'b011100) ? 1'b1 : 1'b0;
assign JNV = (op == 6'b011101) ? 1'b1 : 1'b0;
assign JZ  = (op == 6'b011110) ? 1'b1 : 1'b0;
assign JNZ = (op == 6'b011111) ? 1'b1 : 1'b0;
assign JMP = (op == 6'b011000) ? 1'b1 : 1'b0;
assign RET = (op == 6'b010000) ? 1'b1 : 1'b0;

//Outputs of the D-flip flops
wire [1:0] Q;

d_flip_flop dff0(Q[0], interrupt, clk, reset);
d_flip_flop dff1(Q[1], Q[0], clk, reset);

wire [1:0] flag_ex_mux [0:1];
reg [1:0] flag_ex_delayed;
assign flag_ex_mux[0] = Q[1] ? flag_ex: flag_ex_delayed;
assign flag_ex_mux[1] = RET ? flag_ex_delayed : flag_ex;
always@(posedge clk)
begin
	if(reset)
	begin
		flag_ex_delayed <= flag_ex_mux[0];
	end
	else
	begin
		flag_ex_delayed <= 0;
	end	
end

assign pc_mux_sel = (JV && flag_ex_mux[1][0]) || (JNV && ~flag_ex_mux[1][0]) 
						|| (JZ && flag_ex_mux[1][1]) || (JNZ && ~flag_ex_mux[1][1])
						|| JMP || RET || Q[0];

//parameter INC_VALUE = 1'b1;
wire [15:0] incremented_address = current_address + 1'b1;
wire [15:0] current_address_mux = interrupt ? incremented_address : address_delayed;
reg [15:0] address_delayed;
always@(posedge clk)
begin
	if(reset)
	begin
		address_delayed <= current_address_mux;	
	end
	else
	begin
		address_delayed <= 0;
	end
end

wire [15:0] return_address_mux = RET ? address_delayed : jmp_address_mux;
wire [15:0] jmp_address_mux = Q[0] ? 16'hf000 : jmp_address_pm;

assign jmp_loc = return_address_mux;

endmodule

