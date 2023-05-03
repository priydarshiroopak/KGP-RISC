`timescale 1ns / 1ps

module KGP_RISC(
    input clk,
    input rst,
	 output [31:0] retReg, alu_out,reg_data_1,reg_data_2,instr,pc_out,pc, branch,flags,alu_ip2,ls_signal,read_data_out
    );

   // Wires
	wire [31:0] pc;
	wire [31:0] instr;
	wire [1:0] branch;
	wire mem_read;
	wire mem_write;
	wire [1:0] mem_to_reg;
	wire alu_op;
	wire alu_src;
	wire [1:0] reg_write;
	wire [3:0] alu_signal;
	wire ls_signal;
	wire [31:0] alu_out, read_data_out;
	wire [31:0] write_data;
	wire [31:0] reg_data_1;
	wire [31:0] reg_data_2;
	wire [31:0] branch_address;
	wire [2:0]  flags;
	wire [31:0] imm;
	wire [31:0] alu_ip2;
	wire [31:0] pc_next,pc_out;

	// sign extend instr[15:0] to 32 bits (imm)
	//assign imm = ls_signal ?{{16{instr[15]}}, instr[15:0]}:{ {16{instr[20]}}, instr[20:5]};

    // sign extend instr[20:6] to 32 bits (branch_address)
	assign branch_address= { {16{instr[20]}}, instr[20:5] };

    // alu 2nd input selector
	//assign alu_ip2 = alu_src ? reg_data_2 : imm;
	mux_2_1 mux_1(
		.signal(ls_signal),
		.a({{16{instr[15]}}, instr[15:0]}),
		.b({ {16{instr[20]}}, instr[20:5]}),
		.c(imm)
	);
	
	mux_2_1 mux_2(
		.signal(alu_src),
		.a(reg_data_2),
		.b(imm),
		.c(alu_ip2)
	);
	
	mux_3_1 WDS(
		.mem_reg_pc(mem_to_reg),
		.mem_data(read_data_out),
		.alu_data(alu_out),
		.pc_in(pc_next),
		.writedata(write_data)
	);
	
	main_control MCU (
		.opcode(instr[31:26]), 
		.branch(branch), 
		.mem_read(mem_read), 
		.mem_write(mem_write), 
		.mem_to_reg(mem_to_reg), 
		.alu_op(alu_op),
		.alu_src(alu_src), 
		.reg_write(reg_write),
		.ls_signal(ls_signal)
	);
	
	data_memory DM (
		.address(alu_out),
		.clk(clk),
		.read_signal(mem_read),
		.write_signal(mem_write),
		.write_data(reg_data_2),
		.read_data_out(read_data_out)
	);

	instruction_fetcher IF (
		.pc(pc_out),
		.clk(clk),
		.instr(instr)
	);

	program_counter PC (
		.pc_ip(pc_out),
		.clk(clk),
		.rst(rst),
		.pc_op(pc)
	);

	alu_control ACU (
		.func(instr[4:0]), 
		.alu_op(alu_op), 
		.alu_signal(alu_signal)
	);

	alu ALU (
		.ip1(reg_data_1), 
		.ip2(alu_ip2), 
		.alu_signal(alu_signal), 
		.out(alu_out),
		.flags(flags)
	);
	
	branch BM (
		.pc_ip(pc),
		.destination_addr(branch_address), 
		.reg_1(reg_data_1),
		.branch_signal(branch),
		.func_code(instr[5:0]),
		.alu_flag(flags),
		.rst(rst),
		.clk(clk),
		.pc_op(pc_out),
		.pc_next(pc_next)
	);
	
	register_file RF (
		.reg_addr_1(instr[25:21]), 
		.reg_addr_2(instr[20:16]), 
		.reg_write(reg_write), 
		.writeData(write_data), 
		.read_data_1(reg_data_1), 
		.read_data_2(reg_data_2), 
		.clk(clk), 
		.rst(rst),
		.retReg(retReg)
	);


endmodule