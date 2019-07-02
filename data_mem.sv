// Create Date:    2017.01.25
// Design Name:
// Module Name:    DataRAM
// single address pointer for both read and write
// CSE141L
module data_mem(
	input clk,
	input reset,
	input[7:0] mem_addr,
	input mem_read,
	input mem_write,
	input[7:0] write_value,
	output logic[7:0] read_value);

logic [7:0] core[256];

//  initial 
//    $readmemh("dataram_init.list", my_memory);
always_comb                     // reads are combinational
	if(mem_read) 
		read_value = core[mem_addr];
    else 
		read_value = 'bZ;           // tristate, undriven

always_ff @ (posedge clk)		 // writes are sequential
	if(mem_write)
      core[mem_addr] <= write_value;

endmodule
