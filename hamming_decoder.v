`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:00:43 10/29/2015 
// Design Name: 
// Module Name:    hamming_decoder 
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

module hamming_decoder(output reg[10:0] out,          // mesaj corectat
                       output reg[3:0]  error_index,  // numarul bitului corectat (1-15)
                       output reg       error,        // 1 daca a fost detectata cel putin o eroare
                       output reg       uncorrectable,// 1 daca au fost detectate doua erori
                       input     [16:1] in);
							
		reg P1, P2, P4, P8;
		reg D1, D2, D3, D4, D5, D6, D7, D8, D9, D10, D11;
		reg[16:1] my_in;
		
		
      always @(*)
		begin
			my_in = in[16:1];
			P1 = in[1];
			P2 = in[2];
			P4 = in[4];
			P8 = in[8];
				
			D1 = in[3];
			D2 = in[5];
			D3 = in[6];
			D4 = in[7];
			D5 = in[9];
			D6 = in[10];
			D7 = in[11];
			D8 = in[12];
			D9 = in[13];
			D10 = in[14];
			D11 = in[15];
			
			P1 = P1 ^ D1 ^ D2 ^ D4 ^ D5 ^ D7 ^ D9 ^ D11;
			P2 = P2 ^ D1 ^ D3 ^ D4 ^ D6 ^ D7 ^ D10 ^ D11;
			P4 = P4 ^ D2 ^ D3 ^ D4 ^ D8 ^ D9 ^ D10 ^ D11;
			P8 = P8 ^ D5 ^ D6 ^ D7 ^ D8 ^ D9 ^ D10 ^ D11;
				
			error = 0;
			error_index = {P8, P4, P2, P1};
			if(error_index != 0) //avem o eroare(sau doua) si incercam sa o corectam
			begin
				error = 1;
				my_in[error_index] = my_in[error_index] ^ 1;
			end			
			uncorrectable = 0; //presupunem ca nu avem dubla eroare
//----------------------------------verificam daca avem dubla eroare---------
			P1 = my_in[1];
			P2 = my_in[2];
			P4 = my_in[4];
			P8 = my_in[8];
			
			D1 = my_in[3];
			D2 = my_in[5];
			D3 = my_in[6];
			D4 = my_in[7];
			D5 = my_in[9];
			D6 = my_in[10];
			D7 = my_in[11];
			D8 = my_in[12];
			D9 = my_in[13];
			D10 = my_in[14];
			D11 = my_in[15];
				
		   //decodificam sirul
			out[0] = D1;
			out[1] = D2;
			out[2] = D3;
			out[3] = D4;
			out[4] = D5;
			out[5] = D6;
			out[6] = D7;
			out[7] = D8;
			out[8] = D9;
			out[9] = D10;
			out[10] = D11;
				
			if(in[16] != (^my_in[15:1])) //avem dubla eroare
			begin 
				uncorrectable  = 1'b1;
				error_index = 4'b0;
				error = 1'b1;
				//lasam ca output sirul initial
				out[0] = in[3];
				out[1] = in[5];
				out[2] = in[6];
				out[3] = in[7];
				out[4] = in[9];
				out[5] = in[10];
				out[6] = in[11];
				out[7] = in[12];
				out[8] = in[13];
				out[9] = in[14];
				out[10] = in[15];	
			end
				
		end
			
endmodule
