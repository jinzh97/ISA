// CSE141L
// program counter
// accepts branch and jump instructions
// default = increment by 1
// issues halt when PC reaches 63
module PC(
	input start,
	input clk,
	input branch,
	input flag,
	input logic[4:0] imm,
	output logic[9:0] pc
);

logic[9:0] target;
logic[4:0] addr;

assign addr = imm;

LUT LUT_inst(imm, target);

always @(posedge clk) begin
	if(start) begin
		if(pc >= 50)pc <= 65;
		else pc <= 0;
	end
	else begin		 
		if(branch) 
			if(flag == 0) pc <= pc + $signed(imm) + 1;
			else begin
				pc <= target;
			end
		else 
			pc <= pc + 1;
	end
end
endmodule





        