module parity(
	input[4:0] par_num,
	input[7:0] upper,
	input[7:0] lower,
	output logic par_bit
);

always_comb
		case(par_num)
			0: par_bit = lower[0] ^ lower[1] ^ lower[3] ^ lower[4] ^ 
				         lower[6] ^ upper[0] ^ upper[2];
						 
			1: par_bit = lower[0] ^ lower[2] ^ lower[3] ^ lower[5] ^ 
				         lower[6] ^ upper[1] ^ upper[2];
						 
			2: par_bit = lower[1] ^ lower[2] ^ lower[3] ^ lower[7] ^ 
				         upper[0] ^ upper[1] ^ upper[2];
						 
			3: par_bit = lower[4] ^ lower[5] ^ lower[6] ^ lower[7] ^ 
				         upper[0] ^ upper[1] ^ upper[2];
						 
			4: par_bit = lower[2] ^ lower[4] ^ lower[6] ^ upper[0] ^ 
				         upper[2] ^ upper[4] ^ upper[6];
						 
			5: par_bit = lower[2] ^ lower[5] ^ lower[6] ^ upper[1] ^ 
				         upper[2] ^ upper[5] ^ upper[6];
						 
			6: par_bit = lower[4] ^ lower[5] ^ lower[6] ^ upper[3] ^ 
				         upper[4] ^ upper[5] ^ upper[6];
						 
			7: par_bit = upper[0] ^ upper[1] ^ upper[2] ^ upper[3] ^
						 upper[4] ^ upper[5] ^ upper[6];
			default: par_bit = 0;
		endcase	
endmodule
