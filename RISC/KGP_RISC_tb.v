`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:06:58 11/04/2022
// Design Name:   KGP_RISC
// Module Name:   /KGP_RISC_tb.v
// Project Name:  KGP_RISC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: KGP_RISC
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module KGP_RISC_tb;

	// Inputs
	reg clk;
	reg rst;

	// Outputs
	
	wire [31:0] retReg, alu_out,reg_data_1,reg_data_2,instr,pc_out,pc,branch,alu_ip2,read_data_out;
	wire [2:0]flags;
	wire ls_signal;
	
	// Instantiate the Unit Under Test (UUT)
	KGP_RISC uut (
		.clk(clk), 
		.rst(rst), 
		.retReg(retReg),
		.alu_out(alu_out),
		.reg_data_1(reg_data_1),
		.reg_data_2(reg_data_2),
		.instr(instr),
		.pc_out(pc_out),
		.pc(pc),
		.branch(branch),
		.flags(flags),
		.alu_ip2(alu_ip2),
		.ls_signal(ls_signal),
		.read_data_out(read_data_out)
	);
	
	always begin
	#20 clk = ~clk;
	end
	
	initial begin
		// Initialize Inputs
		clk = 1;
		rst = 1;

		// Wait 100 ns for global reset to finish
		#100;
		rst = 0;
      
		// Add stimulus here

	end
	
	always @(posedge clk) begin
		$display("ip_1=%d, ip_2=%d, alu_out = %d, retReg=%d, instr=%b, pc=%d, ls_signal=%b,read_data_out=%d",reg_data_1,alu_ip2,alu_out,retReg,instr,pc,ls_signal,read_data_out);
	end
      
endmodule

