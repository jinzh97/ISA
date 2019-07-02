// CSE141L
// control decoder (combinational, not clocked)
// inputs from instrROM, ALU flags
// outputs to program_counter (fetch unit)
module Ctrl (					
	input[8:0] instruction,		// Destinations:
	input[7:0] upper,
	input[7:0] lower,
	output logic reg_write,		// reg_file	
	output logic acc_write,		// reg_file
	output logic reg_read,		// reg_file
	output logic memToReg,		// reg_file
	output logic mem_read,		// data_mem
	output logic mem_write,		// data_mem
	output logic[3:0] op,
	output logic[4:0] imm,
	output logic[4:0] reg_addr,
	output logic flag,
	output logic halt
  );

assign op = instruction[8:5];
assign flag = instruction[4];


always_comb begin

	imm = instruction[4:0];
	reg_addr = instruction[3:0];
	case(op)
		'b0000: begin	// SETI
			reg_write = 0;
			acc_write = 1;
			reg_read = 0;
			memToReg = 0;
			mem_read = 0;
			mem_write = 0;
			imm = instruction[4:0];
			halt = 0;
		end
		
		'b0001: begin	// SLT
			reg_write = 0;
			acc_write = 1;
			reg_read = 1;
			memToReg = 0;
			mem_read = 0;
			mem_write = 0;
			reg_addr = instruction[4:0];
			halt = 0;
		end
		
		'b0010: begin	// ADDI
			reg_write = 0;
			acc_write = 1;
			reg_read = 0;
			memToReg = 0;
			mem_read = 0;
			mem_write = 0;
			imm = instruction[4:0];
			halt = 0;
		end
		
		'b0011: begin // SUBI
			reg_write = 0;
			acc_write = 1;
			reg_read = 0;
			memToReg = 0;
			mem_read = 0;
			mem_write = 0;
			imm = instruction[4:0];
			halt = 0;
		end
		
		'b0100: begin // OR
			reg_write = 0;
			acc_write = 1;
			reg_read = 1;
			memToReg = 0;
			mem_read = 0;
			mem_write = 0;
			reg_addr = instruction[3:0];
			halt = 0;
		end
		
		'b0101: begin // ADDR
			reg_write = 0;
			acc_write = 1;
			reg_read = 1;
			memToReg = 0;
			mem_read = 0;
			mem_write = 0;
			reg_addr = instruction[4:0];
			halt = 0;
		end
		
		'b0110: begin // JUMP
			reg_write = 0;
			acc_write = 0;
			reg_read = 0;
			memToReg = 0;
			mem_read = 0;
			mem_write = 0;
			imm = instruction[4:0];
			halt = 0;
		end
		
		'b0111: begin // SEQ
			reg_write = 0;
			acc_write = 1;
			reg_read = 1;
			memToReg = 0;
			mem_read = 0;
			mem_write = 0;
			reg_addr = instruction[4:0];
			halt = 0;
		end
		
		'b1000: begin // BONE
			reg_write = 0;
			acc_write = 0;
			reg_read = 0;
			memToReg = 0;
			mem_read = 0;
			mem_write = 0;
			imm = instruction[4:0];
			halt = 0;
		end
		
		'b1001: begin // BZERO
			reg_write = 0;
			acc_write = 0;
			reg_read = 0;
			memToReg = 0;
			mem_read = 0;
			mem_write = 0;
			imm = instruction[4:0];
			halt = 0;
		end
		
		'b1010: begin // PARITY
			reg_write = 0;
			acc_write = 1;
			reg_read = 0;
			memToReg = 0;
			mem_read = 0;
			mem_write = 0;
			reg_addr = 15;
			imm = instruction[4:0];
			halt = 0;
		end
		
		'b1011: begin // LOAD
			if(flag) begin
				reg_write = 0;
				acc_write = 1;
				reg_read = 1;
				memToReg = 1;
				mem_read = 1;
				mem_write = 0;
				reg_addr = instruction[3:0];
				halt = 0;
			end
			
			else begin
				reg_write = 0;
				acc_write = 1;
				reg_read = 1;
				memToReg = 0;
				mem_read = 0;
				mem_write = 0;
				reg_addr = instruction[4:0];
				halt = 0;
			end
		end
		
		'b1100: begin // STORE
			if(flag) begin
				reg_write = 0;
				acc_write = 0;
				reg_read = 1;
				memToReg = 0;
				mem_read = 0;
				mem_write = 1;
				reg_addr = instruction[3:0];
				halt = 0;
			end
			
			else begin
				reg_write = 1;
				acc_write = 0;
				reg_read = 0;
				memToReg = 0;
				mem_read = 0;
				mem_write = 0;
				reg_addr = instruction[4:0];
				halt = 0;
			end
		end
		
		'b1101: begin // SHIFT
			reg_write = 0;
			acc_write = 1;
			reg_read = 0;
			memToReg = 0;
			mem_read = 0;
			mem_write = 0;
			imm = instruction[3:0];
			halt = 0;
		end
		
		'b1110: begin // SHIFTR
			reg_write = 0;
			acc_write = 1;
			reg_read = 1;
			memToReg = 0;
			mem_read = 0;
			mem_write = 0;
			reg_addr = instruction[3:0];
			halt = 0;
		end
		
		'b1111: begin // STOP
			reg_write = 0;
			acc_write = 0;
			reg_read = 0;
			memToReg = 0;
			mem_read = 0;
			mem_write = 0;
			halt = 1;
		end
		default: begin
			reg_write = 0;
			acc_write = 0;		// reg_file
			reg_read = 0;		// reg_file
			memToReg = 0;		// reg_file
			mem_read = 0;		// data_mem
			mem_write = 0;		// data_mem
			imm = 0;
			reg_addr = 0;
			halt = 0;
		end
	endcase
end
endmodule
