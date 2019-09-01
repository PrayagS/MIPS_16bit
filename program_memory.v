`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:26:12 08/29/2019 
// Design Name: 
// Module Name:    program_memory 
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
module program_memory(ins, current_address, jmp_loc, pc_mux_sel, stall, stall_pm, reset, clk);

output [31:0] ins;
output [15:0] current_address;

input [15:0] jmp_loc;
input pc_mux_sel, stall, stall_pm, reset, clk;

reg [15:0] next_address, hold_address;
wire address_carry; // carry wire in case it is generated while incrementing the address
wire [31:0] ins_pm;
reg [31:0] ins_prv;
wire [31:0] PM_out;
wire [15:0] CAJ, CAR, IA;

PMem program_mem_block (
  .clka(clk), // input clk
  .addra(current_address), // input [15 : 0] current_address
  .douta(PM_out) // output [31 : 0] PM_out
);

assign CAJ = (stall == 1'b1) ? hold_address : next_address;
assign CAR = (pc_mux_sel == 1'b1) ? jmp_loc : CAJ;
assign {address_carry, IA} = current_address + 1; // Concantenation to store carry in address_carry if generated
assign current_address = (reset == 1'b1) ? CAR : 16'b0;

assign ins_pm = (stall_pm == 1'b1) ? ins_prv : PM_out;
assign ins = (reset == 1'b1) ? ins_pm : 32'b0;

always @(posedge clk)
begin
	if (reset == 1'b0)
	begin
		ins_prv <= 32'b0;
		hold_address <= 16'b0;
		next_address <= 16'b0;
	end
	else
	begin
		ins_prv <= ins;
		hold_address <= current_address;
		next_address <= IA;
	end
end

endmodule
