`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:16:24 12/10/2019 
// Design Name: 
// Module Name:    floating_ieee754 
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
module floating_ieee754(result, mantissa_A, mantissa_B, exp_result, A, B);
	output [15:0] result;
	input [15:0] A;
	input [15:0] B;
	wire sign_A = A[15];
	wire sign_B = B[15];
	wire [4:0] exp_A = A[14:10];
	wire [4:0] exp_B = B[14:10];
	output reg [11:0] mantissa_A; //= {1'b1, A[9:0]};
	output reg [11:0] mantissa_B; //= {1'b1, B[9:0]};
	reg [4:0] exp_diff;
	output reg [4:0] exp_result;
	wire [11:0] temp_mantissa_A = {2'b01, A[9:0]};
	wire [11:0] temp_mantissa_B = {2'b01, B[9:0]};
//	assign temp_mantissa_A[10] =  1'b1;
//	temp_mantissa_A[9:0] = A[9:0];
//	temp_mantissa_B[10] = 1'b1;
//	temp_mantissa_B[9:0] = B[9:0];
	
	always@(temp_mantissa_A or temp_mantissa_B)
	begin
		$display("A: %b", A);
		$display("B: %b", B);
		$display("A- %b",temp_mantissa_A);
		$display("B- %b",temp_mantissa_B);
		if(exp_A > exp_B)
		begin
			mantissa_B <= (temp_mantissa_B >> (exp_A - exp_B));
			mantissa_A <= temp_mantissa_A;
			exp_result <= exp_A;
		end
		else
		begin
			mantissa_A <= (temp_mantissa_A >> (exp_B - exp_A));
			mantissa_B <= temp_mantissa_B;
			exp_result <= exp_B;
		end
		$display("Mantissa A: %b", mantissa_A);
		$display("Mantissa B: %b", mantissa_B);
		$display("exp_A: %b", exp_A);
		$display("exp_B: %b", exp_B);
		$display("exp_result: %b", exp_result);
//		signed_mantissa_A <= {sign_A, mantissa_A};
//		signed_mantissa_B <= {sign_B, mantissa_B};
	end
//	wire [11:0] temp_signed_mantissa_A = {sign_A, mantissa_A};
//	wire [11:0] temp_signed_mantissa_B = {sign_B, mantissa_B};
//	wire [11:0] two_c_A = ~mantissa_A + 1'b1;
//	wire [11:0] two_c_B = ~mantissa_B + 1'b1;
//	two_c_12 t1(two_c_A, mantissa_A);
//	two_c_12 t2(two_c_B, mantissa_B);
	wire [12:0] signed_mantissa_A;// = (sign_A) {sign_A, ? : {sign_A, mantissa_A};
	wire [12:0] signed_mantissa_B;// = {sign_B, mantissa_B};
	assign signed_mantissa_A[12] = sign_A;
	assign signed_mantissa_B[12] = sign_B;
	assign signed_mantissa_A[11:0] = (sign_A) ? -mantissa_A : mantissa_A;
	assign signed_mantissa_B[11:0] = (sign_B) ? -mantissa_B : mantissa_B;
//	wire [12:0] temp_signed_result = signed_mantissa_A + signed_mantissa_B;
	wire [12:0] signed_result = signed_mantissa_A + signed_mantissa_B;

//	wire [11:0] two_c_sr = ~temp_signed_result[11:0] + 1'b1;

//	two_c_12 t3(two_c_sr, temp_signed_result[11:0]);

//	assign signed_result[12] = temp_signed_result[12];
//	wire [11:0] temp_signed_part = temp_signed_result[11:0];
//	assign signed_result = (temp_signed_result[12] == 1'b1) ? {temp_signed_result[12], -temp_signed_part} : temp_signed_result;

	reg [10:0] temp_result;// = signed_result[10:0];

	integer i;
	integer counter;
	integer temp;
//	always@(temp_signed_result)
	always@(signed_mantissa_A or signed_mantissa_B)
	begin
		counter = 0;
		$display("Signed A: %b", signed_mantissa_A);
		$display("Signed B: %b", signed_mantissa_B);
//		$display("Temp signed result: %b", temp_signed_result);
//		$display("2csr: %b", two_c_sr);
//		$display("Signed result: %b", signed_result);
		temp_result = signed_result[10:0];
		if(temp_result != 11'b0)
		begin
			for(i = 10; i >=0 && temp_result[i] == 1'b0; i = i - 1)
			begin
				if(temp_result[i] == 1'b0)
				begin
					counter = counter + 1;
				end
//				else
//				begin
//					temp_result <= temp_result << (counter + 1);
//					exp_result <= exp_result - counter;
//					break;
//				end
			end
			temp = ~temp;
			$display("Counter: %b", counter);
//			while (temp_result[10] != 1'b1)
//			begin
//				temp_result <= temp_result << 1'b1;
//				exp_result <= exp_result - 1'b1;
//			end
//			temp_result <= temp_result << 1'b1;
		end
	end
	always @(temp)
	begin
		temp_result <= temp_result << (counter);
		exp_result <= exp_result - counter + signed_result[11];	
		$display("Temp result: %b", temp_result);
		$display("Exp result: %b", exp_result);
	end
	assign result = {signed_result[12], exp_result, temp_result[9:0]};

//	always @(temp_signed_result)
//	begin
//		$display("Signed result: %b", signed_result);
//	end
endmodule
module two_c_12(result, A);
output [11:0] result;
input [11:0] A;
assign result = ~A + 1'b1;
endmodule
