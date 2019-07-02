// Create Date:    2018.04.05
// Design Name:    BasicProcessor
// Module Name:    TopLevel 
// CSE141L
// partial only										   
module TopLevel(		   // you will have the same 3 ports
    input     start,	   // init/reset, active high
	input     CLK,		   // clock -- posedge used inside design
	input  	  reset,
    output    halt		   // done flag from DUT
    );

wire [9:0] PC;            // program count
wire [8:0] Instruction;   // our 9-bit opcode
wire		branch;
wire reg_write;		// reg_file	
wire acc_write;		// reg_file
wire reg_read;		// reg_file
wire memToReg;		// reg_file
wire mem_read;		// data_mem
wire mem_write;		// data_mem
wire[3:0] op;
logic [15:0]cycle_ct;
wire[4:0] imm;
wire[4:0] reg_addr;
wire flag;
wire[7:0] mem_in; //From Memory
wire[7:0] alu_result; //From ALU
wire[7:0] reg_out;
wire[7:0] acc_out;
wire[7:0] regWriteValue;

// Fetch = Program Counter + Instruction ROM
// Program Counter
assign regWriteValue = memToReg? mem_in : alu_result;

  PC PC1 (
	.start (start), 
	.clk(CLK),            	  
	.branch(branch),
	.flag(flag),
	.imm(imm),  //imm computed from control decoder
	.pc(PC) // program count = index to instruction memory
	);		

// Control decoder
  Ctrl Ctrl1 (
	.instruction(Instruction),    // from instr_ROM
	.reg_write(reg_write),
	.acc_write(acc_write),
	.reg_read(reg_read),
	.memToReg(memToReg),
	.mem_read(mem_read),
	.mem_write(mem_write),
	.op(op),
	.imm(imm),
	.reg_addr(reg_addr),
	.flag(flag),
	.lower(lower),
	.upper(upper),
	.halt(halt)
  );
// instruction ROM TODODODODO
  InstROM instr_ROM1(
	.InstAddress   (PC), 
	.InstOut       (Instruction)
	);

// reg file	
	reg_file reg_file1 (
		.clk(CLK),
		.reg_write(reg_write),
		.acc_write(acc_write),
		.reg_read(reg_read),
		.memToReg(memToReg),
		.value_in(regWriteValue),
		.reg_addr(reg_addr),
		.reg_out(reg_out),
		.acc_out(acc_out)
	);

    ALU ALU1  (
	  .imm(imm),
	  .acc_in(acc_out),
	  .reg_in(reg_out),
	  .op(op),
	  .flag(flag),
	  .br_comp(branch),
	  .out(alu_result)
	  );
  
	data_mem data_mem1(
		.clk(CLK),
		.reset(reset),
		.mem_addr(reg_out),
		.mem_read(mem_read),
		.mem_write(mem_write),
		.write_value(acc_out),
		.read_value(mem_in)
	);
	
// count number of instructions executed
always_ff @(posedge CLK)
  if (start == 1)	   // if(start)
  	cycle_ct <= 0;
  else if(halt == 0)   // if(!halt)
  	cycle_ct <= cycle_ct+16'b1;

endmodule
