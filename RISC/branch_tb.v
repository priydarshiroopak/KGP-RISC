`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:29:34 11/08/2022
// Design Name:   branch
// Module Name:   branch_tb.v
// Project Name:  KGP_RISC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: branch
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module branch_tb;

	// Inputs
	reg [31:0] pc_ip;
	reg [31:0] destination_addr;
	reg [31:0] reg_1;
	reg [1:0] branch_signal;
	reg [5:0] func_code;
	reg [2:0] alu_flag;
	reg rst;
	reg clk;

	// Outputs
	wire [31:0] pc_op;
	wire [31:0] pc_next;

	// Instantiate the Unit Under Test (UUT)
	branch uut (
		.pc_ip(pc_ip), 
		.destination_addr(destination_addr), 
		.reg_1(reg_1), 
		.branch_signal(branch_signal), 
		.func_code(func_code), 
		.alu_flag(alu_flag), 
		.rst(rst), 
		.clk(clk), 
		.pc_op(pc_op), 
		.pc_next(pc_next)
	);
	
	always #2 clk = ~clk;

	initial begin
		// Initialize Inputs
		pc_ip = 10;
		destination_addr = 21;
		reg_1 = 15;
		rst = 0;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
      $monitor("branch_signal=%b, func_code=%b, prev_flag=%b, pc_next=%d, pc_op=%d", branch_signal, func_code, alu_flag, pc_next, pc_op);
		#20;
		branch_signal = 0;
		func_code = 5'b0;
		alu_flag = 3'b0;
		#20
		
		branch_signal = 2'b11;
		func_code = 5'b10001;
		#20
		
		branch_signal = 2'b11;
		func_code = 5'b10010;
		alu_flag = 3'b001;
		#20
		branch_signal = 2'b11;
		func_code = 5'b10010;
		alu_flag = 3'b000;
		#20
		
		branch_signal = 2'b11;
		func_code = 5'b10011;
		alu_flag = 3'b001;
		#20
		branch_signal = 2'b11;
		func_code = 5'b10011;
		alu_flag = 3'b000;
		#20;
		
		branch_signal = 2'b11;
		func_code = 5'b10100;
		alu_flag = 3'b100;
		#20
		branch_signal = 2'b11;
		func_code = 5'b10100;
		alu_flag = 3'b000;
		#20;
				
		branch_signal = 2'b11;
		func_code = 5'b10101;
		alu_flag = 3'b100;
		#20;
		branch_signal = 2'b11;
		func_code = 5'b10101;
		alu_flag = 3'b000;
		#20;
		
		branch_signal = 2'b11;
		func_code = 5'b11000;
		alu_flag = 3'b010;
		#20;
		branch_signal = 2'b11;
		func_code = 5'b11000;
		alu_flag = 3'b000;
		#20;
		
		branch_signal = 2'b11;
		func_code = 5'b11111;
		alu_flag = 3'b000;
		#20;
		
		branch_signal = 2'b10;
		func_code = 5'b11111;
		alu_flag = 3'b000;
		#20;
		
		// Add stimulus here

	end
      
endmodule

