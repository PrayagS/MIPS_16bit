`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:20:08 08/22/2019 
// Design Name: 
// Module Name:    execution_block 
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
module execution_block(ans_ex, DM_data, data_out, flag_ex, A, B, data_in, op_dec, clk, reset);

output reg [15:0] ans_ex, DM_data, data_out;
output [1:0] flag_ex;
input [15:0] A, B;
input [15:0] data_in;
input [5:0] op_dec;
input clk, reset;
reg [1:0] flag_prv;
wire [15:0] ans_rsa, data_out_buff, ans_mul;
wire [15:0] ans_tmp;

// Opcodes defined as parameters for better readability and usability
parameter ADD = 6'b000000;
parameter SUB = 6'b000001;
parameter MOV = 6'b000010;
parameter MUL = 6'b000011;

parameter AND = 6'b000100;
parameter OR  = 6'b000101;
parameter XOR = 6'b000110;
parameter NOT = 6'b000111;

parameter ADI = 6'b001000;
parameter SBI = 6'b001001;
parameter MVI = 6'b001010;

parameter ANI = 6'b001100;
parameter ORI = 6'b001101;
parameter XRI = 6'b001110;
parameter NTI = 6'b001111;

parameter RET = 6'b010000;
parameter HLT = 6'b010001;

parameter LD  = 6'b010100;
parameter ST  = 6'b010101;
parameter IN  = 6'b010110;

parameter OUT = 6'b010111;
parameter JMP = 6'b011000;

parameter LS  = 6'b011001;
parameter RS  = 6'b011010;
parameter RSA = 6'b011011;

parameter JV  = 6'b011100;
parameter JNV = 6'b011101;
parameter JZ  = 6'b011110;
parameter JNZ = 6'b011111;

rsa r(ans_rsa, A, B); // Module for right shift arithmetic
two_c two_com(ans_two_c, B); // Module for generating two's complement. It returns its most significant bit
booth booth_mul(ans_mul, mul_overflow, A, B);

assign ans_tmp = (op_dec == ADD) ? A + B
               : (op_dec == SUB) ? A - B
               : (op_dec == MOV) ? B
					: (op_dec == MUL) ? ans_mul
					: (op_dec == AND) ? A & B
					: (op_dec == OR) ? A | B
					: (op_dec == XOR) ? A ^ B
					: (op_dec == NOT) ?  ~B
					: (op_dec == ADI) ? A + B
					: (op_dec == SBI) ? A - B
					: (op_dec == MVI) ? B
					: (op_dec == ANI) ? A & B
					: (op_dec == ORI) ? A | B
					: (op_dec == XRI) ? A ^ B
					: (op_dec == NTI) ? ~B
					: (op_dec == RET) ? ans_ex
					: (op_dec == HLT) ? ans_ex
					: (op_dec == LD) ? A
					: (op_dec == ST) ? A
					: (op_dec == IN) ? data_in
					: (op_dec == OUT) ? ans_ex
					: (op_dec == JMP) ? ans_ex
					: (op_dec == LS) ? A << B
					: (op_dec == RS) ? A >> B
					: (op_dec == RSA) ? ans_rsa
					: (op_dec == JV) ? ans_ex
					: (op_dec == JNV) ? ans_ex
					: (op_dec == JZ) ? ans_ex
					: (op_dec == JNZ) ? ans_ex : 16'b0;
					
assign overflow = ((op_dec == ADD  || op_dec == ADI ) && (A[15] == B[15]) && (ans_tmp[15] != A[15])) ? 1'b1
                : ((op_dec == SUB || op_dec== SBI) && (A[15] == ans_two_c) && (ans_tmp[15] != A[15])) ? 1'b1 // Separate condition using two's complement of B in case of subtraction 
					 : ((op_dec == MUL) && mul_overflow == 1'b1) ? 1'b1 : 1'b0; 
					 
assign zero = ((ans_tmp == 16'b0) && ~((op_dec == RET) || (op_dec == HLT) 
	|| (op_dec == LD) || (op_dec == ST) || (op_dec == OUT) || (op_dec == JMP) || op_dec == JV || op_dec == JNV || op_dec == JZ || op_dec == JNZ)) ? 1'b1 : 1'b0;

assign data_out_buff = (op_dec == OUT) ? A : data_out;

// Preserve flags in certain operations
assign flag_ex[0] = ((op_dec == JV) || (op_dec == JNV) || (op_dec == JZ) ||(op_dec == JNZ))? flag_prv[0] : overflow;
assign flag_ex[1] = ((op_dec == JV) || (op_dec == JNV) || (op_dec == JZ) ||(op_dec == JNZ))? flag_prv[1] : zero;

always@(posedge clk)
begin
	if(reset == 1'b0)
	begin
		flag_prv = 2'b0;
		ans_ex = 16'b0;
		data_out = 16'b0;
		DM_data = 16'b0;
	end
	else
	begin
		ans_ex = ans_tmp;
		flag_prv = flag_ex;
		data_out = data_out_buff;
		DM_data = B;
	end
end
endmodule

module rsa(ans_rsa, A, B);
output [15:0] ans_rsa;
input signed [15:0] A; //Inbuilt RSA works only if the operand is signed
input [15:0] B;
assign ans_rsa = A >>> B;
endmodule

// 2's complement
module two_c(ans_two_c,B);
output ans_two_c;
input [15:0] B;
wire [15:0] w;
assign w = ~B+1'b1;
assign ans_two_c = w[15];
endmodule

module booth(ans_mul, mul_overflow, A, B);
input signed [15:0] A, B;
output reg signed [15:0] ans_mul;
output reg mul_overflow;
reg signed [31:0] copy_z;
reg signed [31:0] Z;
reg [1:0] temp;
integer i;
reg E1;
reg [15:0] B1;

always @(A, B)
	begin
		Z = 32'd0;
		E1 = 1'd0;
		B1 = -B;
		Z[15:0] = A;
		for (i = 0; i < 16; i = i + 1)
			begin
				temp = {A[i], E1};
				case (temp)
					2'd2: Z[31:16] = Z[31:16] + B1;
					2'd1: Z[31:16] = Z[31:16] + B;
					default: begin end
				endcase
				Z = Z >> 1;
				Z[31] = Z[30];
				E1 = A[i];
			end
		if(Z[31] == 1'b1)
			begin
				copy_z = ~Z + 1'b1;
				if (copy_z[31:15] == 16'b0)
					begin
						mul_overflow = 1'b0;
					end
				else
					begin
						mul_overflow = 1'b1;
					end
				ans_mul = copy_z[15:0];
				ans_mul = ~ans_mul + 1'b1;
			end
		else 
			begin
				if (Z[31:15] == 16'b0)
					begin
						mul_overflow = 1'b0;
					end
				else
					begin
						mul_overflow = 1'b1;
					end
				ans_mul = Z[15:0];
			end
	end
endmodule
