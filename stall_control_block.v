`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:31:35 09/12/2019 
// Design Name: 
// Module Name:    stall_control_block 
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
module stall_control_block(stall, stall_pm, op, clk, reset);
input [5:0] op;
input clk,reset;
output stall, stall_pm;

//Output of AND Gates will be stored here
wire HLT, LD_op, JUMP;

// Assigning appropriate values
assign HLT = (op[0] && ~op[1] && ~op[2] && ~op[3] && op[4] && ~op[5]); 
assign LD_op = (~op[0] && ~op[1] && op[2] && ~op[3] && op[4] && ~op[5] && ~Q[0]) ;
assign JUMP = (op[2] && op[3] && op[4] && ~op[5] && ~Q[3]);
  
assign stall = ( HLT || JUMP || LD_op);
assign stall_pm = Q[2];

// Outputs of D Flip Flops
wire [3:0] Q;

d_flip_flop dff0(Q[0], LD_op, clk, reset);
d_flip_flop dff1(Q[1], JUMP, clk, reset);
d_flip_flop dff2(Q[2], stall, clk, reset);
d_flip_flop dff3(Q[3], Q[1], clk, reset);

endmodule

//D Flip Flop module
module d_flip_flop(Q,D,clk,reset);
output reg Q;
input D, clk, reset;
always@(posedge clk)
begin
	if(reset)
		Q <= D;
	else
		Q <= 1'b0;
end
endmodule
