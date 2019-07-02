
module TopLevel_tb;

// inputs
reg CLK;
reg start;
reg reset;

// outputs
wire halt;

// instantiate the device
TopLevel DUT (
	.CLK,
	.start,
	.reset,
	.halt
);

initial begin
// initialize inputs
CLK = 0;
start = 0;
reset = 0;

// wait 100 ns for global reset to finish
#10ns

// TESTING

start = 1;
#10ns
start = 0;
wait(halt);
#10ns $stop;

end

always begin
  #5ns CLK = 1;            // tic
  #5ns CLK = 0;			   // toc
end

endmodule
