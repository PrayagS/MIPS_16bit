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

reg [31:0] cache [4095:0];
reg [3:0] tag [4095:0];
reg valid [4095:0];

PMem program_mem_block (
  .clka(clk), // input clk
  .addra(current_address), // input [15 : 0] current_address
  .douta(PM_out) // output [31 : 0] PM_out
);

assign CAJ = (stall == 1'b1) ? hold_address : next_address;
assign CAR = (pc_mux_sel == 1'b1) ? jmp_loc : CAJ;
assign {address_carry, IA} = current_address + 1; // Concantenation to store carry in address_carry if generated
assign current_address = (reset == 1'b1) ? CAR : 16'b0;
wire [31:0] final_out;
assign ins_pm = (stall_pm == 1'b1) ? ins_prv : final_out;
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

wire [3:0] tag_cur = current_address[15:12];
//wire [7:0] cb_cur = current_address[11:4];
wire [3:0] tag_cache = tag[current_address[11:0]];
//wire [3:0] offset_cur = current_address[3:0];
assign final_out = (valid[current_address[11:0]] && (tag_cur == tag_cache))? cache[current_address[11:0]] : PM_out;

wire [31:0] PM_prev; //Previous output from program memory.
d_flip_flop dff[31:0](PM_prev, PM_out, clk, reset); //Storing PM_out to PM_prev.

integer i;
always @(posedge clk)
begin
	if(reset == 1'b1)
	begin
		cache[hold_address[11:0]] <= PM_prev;
		tag[hold_address[11:0]] <= hold_address[15:12];
		valid[hold_address[11:0]] <= 1'b1;
	end
	else
	begin
		for(i = 0; i < 4096; i = i + 1)
		begin
			cache[i] <= 0;
			tag[i] <= 0;
			valid[i] <= 0;
		end
	end
end

//always @(posedge clk)
//begin
//		if (tag_cur == tag_cache)
//		begin
//			
//		end
//end

endmodule
