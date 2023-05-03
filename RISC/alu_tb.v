`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:24:59 11/08/2022
// Design Name:   alu
// Module Name:   alu_tb.v
// Project Name:  KGP_RISC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: alu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module alu_tb;

	// Inputs
	reg signed [31:0] ip1;
	reg signed [31:0] ip2;
	reg [3:0] alu_signal;

	// Outputs
	wire signed [31:0] out;
	wire [2:0] flags;

	// Instantiate the Unit Under Test (UUT)
	alu uut (
		.ip1(ip1), 
		.ip2(ip2), 
		.alu_signal(alu_signal), 
		.out(out), 
		.flags(flags)
	);

	initial begin
		// Initialize Inputs
		$monitor("ip1 = %d, ip2 = %d, alu_signal = %b, out = %d, flags = %b",ip1,ip2,alu_signal,out,flags);
		// Wait 100 ns for global reset to finish
		#100;
       ip1 = -32'b1;
		 ip2 = 32'b1;
		 alu_signal = 4'b0001;
		 #100;
		 alu_signal = 4'b0010;
		 #100;
		 alu_signal = 4'b0011;
		 #100;
		 alu_signal = 4'b0100;
		 #100;
		 alu_signal = 4'b0101;
		 #100;
		 alu_signal = 4'b0110;
		 #100;
		 alu_signal = 4'b0111;
		// Add stimulus here

	end
      
endmodule

