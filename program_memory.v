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
module program_memory(
    );

PMem program_mem_block (
  .clka(clk), // input clk
  .addra(current_address), // input [15 : 0] current_address
  .douta(PM_out) // output [31 : 0] PM_out
);


endmodule
