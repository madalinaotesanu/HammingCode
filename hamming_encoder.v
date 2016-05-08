`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:57:17 10/29/2015 
// Design Name: 
// Module Name:    hamming_encoder 
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
module hamming_encoder(output reg[16:1] out,
		       input     [10:0] in);
	always @(*)	
	begin
		//P1 = D1 ^ D2 ^ D4 ^ D5 ^ D7 ^ D9 ^ D11
		out[1]  = in[0] ^ in[1] ^ in[3] ^ in[4] ^ in[6] ^ in[8] ^ in[10];
		//P2 = D1 ^ D3 ^ D4 ^ D6 ^ D7 ^ D10 ^ D11
		out[2]  = in[0] ^ in[2] ^ in[3] ^ in[5] ^ in[6] ^ in[9] ^ in[10];
		out[3]  = in[0];
		//P4 = D2 ^ D3 ^ D4 ^ D8 ^ D9 ^ D10 ^ D11
		out[4]  = in[1] ^ in[2] ^ in[3] ^ in[7] ^ in[8] ^ in[9] ^ in[10];
		out[5]  = in[1];
		out[6]  = in[2];
		out[7]  = in[3];
		//P8 = XOR(Di), i=5,11
		out[8]  = ^in[10:4];
		out[9]  = in[4];
		out[10] = in[5];
		out[11] = in[6];
		out[12] = in[7];
		out[13] = in[8];
		out[14] = in[9];
		out[15] = in[10];
		//bit_paritate = XOR(out[i]), i=1,15
		out[16] = ^out[15:1];		
	end

endmodule
