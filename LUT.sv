// CSE141L
// possible lookup table for PC target
// leverage a few-bit pointer to a wider number
module LUT(
  input[4:0] addr,
  output logic[9:0] Target
  );

always_comb 
  case(addr)	
	'b10000: Target = 4; //LOOP PROGRAM 1
	'b10001: Target = 64; //EXIT PROGRAM 1
	'b10010: Target = 166; //EXIT PROGRAM 2
	'b10011: Target = 73; //LOOP PROGRAM 2
	'b10100: Target = 131; //LOWER
	'b10101: Target = 135; //DECODE
	'b10110: Target = 218; //PART2SETUP
	'b10111: Target = 177; //PART1
	'b11000: Target = 270; //PART3SETUP
	'b11001: Target = 228; //PART2
	'b11010: Target = 318; //EXIT PROGRAM 3
	'b11011: Target = 280;//PART 3
	'b11100: Target = 312;//INC1
	'b11101: Target = 314;//INC2
	default: Target = 0;
  endcase

endmodule


