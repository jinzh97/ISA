// Create Date:    2017.01.25
// Design Name:    CSE141L
// Module Name:    reg_file 
//
// Additional Comments: 					  $clog2

module reg_file #(parameter reg_width=8, reg_pointer=4, num_reg=16) (		 
	input clk,
	input reg_write,
	input acc_write,
	input reg_read,
	input memToReg,
	input[reg_width-1:0] value_in,
	input [reg_pointer-1:0] reg_addr,
	output logic [reg_width-1:0] reg_out,
	output logic [reg_width-1:0] acc_out
);

//register arrays
logic[reg_width-1:0] register[num_reg-1:0];

//accumulator array
logic[reg_width-1:0] accumulator;

// combinational reads w/ blanking of address 0
assign reg_out = register[reg_addr];
assign acc_out = accumulator;

// sequential (clocked) writes 
always_ff @ (posedge clk) begin
	if(reg_write)	               
		register[reg_addr] <= accumulator;
	else if(acc_write) begin
		//Mux to choose between memory or alu
		accumulator <= value_in;
	end
end
endmodule
