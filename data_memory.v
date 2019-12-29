`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:43:22 09/05/2019 
// Design Name: 
// Module Name:    data_memory 
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
module data_memory(ans_dm, ans_ex, DM_data, mem_rw_ex, mem_en_ex, mem_mux_sel_dm, reset, clk);
output [15:0] ans_dm;
input [15:0] ans_ex, DM_data;
input mem_rw_ex, mem_en_ex, mem_mux_sel_dm, reset, clk;
reg [15:0] ex_out;
wire [15:0] DM_out;

DMem data_mem_block (
  .clka(clk), // input clka
  .ena(mem_en_ex), // input ena
  .wea(mem_rw_ex), // input [0 : 0] wea
  .addra(ans_ex), // input [15 : 0] addra
  .dina(DM_data), // input [15 : 0] dina
  .douta(DM_out) // output [15 : 0] douta
);

always@(posedge clk)
begin
	if(reset == 1'b0)
	begin
		ex_out <= 16'b0;
	end
	else
	begin
		ex_out <= ans_ex;		
	end
end

assign ans_dm = (mem_mux_sel_dm == 1'b1) ? DM_out : ex_out;


endmodule
