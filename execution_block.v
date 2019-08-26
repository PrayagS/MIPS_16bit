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
wire [15:0] ans_rsa, data_out_buff;
wire [15:0] ans_tmp;

parameter ADD = 6'b000000;
parameter SUB = 6'b000001;
parameter MOV = 6'b000010;
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

//cprv add_sub = 14 bits
//A[14:0]+ B[14:0]
//cfinal add-sub= 15th bit + cprv;

rsa r (ans_rsa, A, B);
two_c two_com(ans_two_c, B);

assign ans_tmp = (op_dec == ADD) ? A + B
               : (op_dec == SUB) ? A - B
               : (op_dec == MOV) ? B 
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
					: (op_dec == JNZ) ? ans_ex : ans_ex;

assign overflow = ((op_dec == ADD  || op_dec == ADI ) && (A[15] == B[15]) && (ans_tmp[15] != A[15])) ? 1'b1
                : ((op_dec == SUB || op_dec== SBI) && (A[15] == ans_two_c) && (ans_tmp[15] != A[15])) ? 1'b1
                : (~(op_dec == ADD || op_dec == SUB || op_dec == ADI || op_dec == SBI || op_dec == JV || op_dec == JNV || op_dec == JZ || op_dec == JNZ)) ? 1'b0 : 1'b0;

assign zero = ((ans_tmp == 16'b0000000000000000) && ~((op_dec == RET) || (op_dec == HLT) 
	|| (op_dec == LD) || (op_dec == ST) || (op_dec == OUT) || (op_dec == JMP) || op_dec == JV || op_dec == JNV || op_dec == JZ || op_dec == JNZ)) ? 1'b1
            : ((op_dec == RET) || (op_dec == HLT) ||  (op_dec == LD) || (op_dec == ST) || (op_dec == OUT) || (op_dec == JMP)) ? 1'b0 : 1'b0;

assign data_out_buff = (op_dec == OUT) ? A : data_out;

assign flag_ex[0] = ((op_dec == JV) || (op_dec == JNV) || (op_dec == JZ) ||(op_dec == JNZ))? flag_prv[0] : overflow;
assign flag_ex[1] = ((op_dec == JV) || (op_dec == JNV) || (op_dec == JZ) ||(op_dec == JNZ))? flag_prv[1] : zero;

//always@(posedge clk)
//begin
//	ans_ex = ans_tmp;
//	flag_prv = flag_ex;
//	data_out = data_out_buff;
//	DM_data = B;
//end
//
//always@(reset)
//begin
//	if(reset == 1'b0)
//	begin
//		flag_prv = 2'b00;
//		//ans_ex = 16'b0000000000000000;
//		data_out = 16'b0000000000000000;
//		DM_data = 16'b0000000000000000;
//	end
//end

always@(posedge clk)
begin
	if(reset == 1'b0)
	begin
		flag_prv = 2'b00;
		ans_ex = 16'b0000000000000000;
		data_out = 16'b0000000000000000;
		DM_data = 16'b0000000000000000;
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

//module full_adder(sum, cout, A, B, cin);
//
//output sum, cout;
//input A, B, cin;
//
//assign sum = A ^ B ^ cin;
//assign cout = A & B;
//
//endmodule
//
//module rca_16bit(s_d, c_b, overflow, A, B, operator);
//
//output [15:0] s_d;
//output c_b, overflow;
//input [15:0] A, B;
//input operator;
//wire [15:0] carryout_tmp, carryin_tmp;
//
//assign carryin_tmp[0:15] = {1'b0, carryout_tmp[0:14]};
//
//full_adder fa [15:0] (s_d, carry_tmp, A, B, carryin_tmp);
//
//assign c_b = carryout_tmp[15];
//assign overflow = c_b ^ carryout_tmp[14];
//
//endmodule

module rsa(ans_rsa, A, B);
output [15:0] ans_rsa;
input signed [15:0] A;
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
