// Create Date:    2016.10.15
// Module Name:    ALU 
// Project Name:   CSE141L
//
// Revision 2018.01.27
// Additional Comments: 
//   combinational (unclocked) ALU
module ALU(
	input logic[4:0] imm, // Immediate value
	input logic[7:0] acc_in, // Accumulator input
	input logic[7:0] reg_in, // Register input
	input logic[3:0] op, // ALU opcode 
	input logic flag,
	output logic br_comp, // Result of comparison for branching 1 or 0 
	output logic[7:0] out // or:  output reg [7:0] OUT
);

wire par_bit;
parity parity_inst(.par_num(imm), .upper(reg_in), .lower(acc_in), .par_bit(par_bit));

always_comb begin
	out = 0; // default -- clear carry out and result out
	br_comp = 0;
	
// single instruction for both LSW & MSW
	case(op)
		'b0000: out = imm; // SETI
		'b0001: 
			begin
				if(acc_in > reg_in) out = 1;
				else out = 0;
			end
		'b0010: out = acc_in + imm; // ADDI
		'b0011: out = acc_in - imm; // SUBI 
		'b0100: begin
			if(flag) out = acc_in ^ reg_in; // XOR
			else out = acc_in | reg_in; // OR
		end
		'b0101: out = acc_in + reg_in; // ADDR
		'b0110: br_comp = 1; // JUMP
		'b0111: // SEQ
			begin
				if(acc_in == reg_in) out = 1;
				else out = 0;
			end
		'b1000: br_comp = acc_in == 1; // BONE
		'b1001: br_comp = acc_in == 0; // BZERO
		'b1010: out = par_bit; // PARITY TBD
		'b1011: out = reg_in; // LOAD
		'b1100: out = acc_in; // STORE
		'b1101: begin
			if(flag) out = acc_in >> imm; 
			else out = acc_in << imm; // SHIFT			
		end
		'b1110: begin
			if(flag) out = acc_in >> reg_in; 
			else out = acc_in << reg_in; // SHIFT
		end		
	endcase
end											
endmodule