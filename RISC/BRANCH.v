`timescale 1ns / 1ps

module branch(
   input [31:0] pc_ip,
	input [31:0] destination_addr,
	input [31:0] reg_1,
	input [1:0] branch_signal,
	input [5:0] func_code,
	input [2:0] alu_flag,
	input rst,
	input clk,
   output reg [31:0] pc_op,
	output reg [31:0] pc_next
	
    );
	reg [2:0] prev_flag;

	always @(posedge clk) begin
		if(rst)
			prev_flag <= 3'b000;
		else
			prev_flag <= alu_flag;
	end

	always @(negedge clk) begin
		pc_next <= pc_ip+ 32'b1;
		if(rst)
			pc_op <= 32'b0;
		else begin 
			if (branch_signal[1]==1'b0)
				pc_op<=pc_ip+32'b1;
			else begin
				case(branch_signal[0])
				1'b1: begin
					case(func_code)
						5'b10001: begin
							pc_op<=destination_addr;
						end
						5'b10010:begin
							if(prev_flag[0]==1'b1)
								pc_op<=destination_addr;
							else
								pc_op<=pc_ip+32'b1;
						end
						5'b10011:begin
							if(prev_flag[0]==1'b0)
								pc_op<=destination_addr;
							else
								pc_op<=pc_ip+32'b1;
						end
						5'b10100:begin
							if(prev_flag[2]==1'b1)
								pc_op<=destination_addr;
							else
								pc_op<=pc_ip+32'b1;
						end
						5'b10101:begin
							if(prev_flag[2]==1'b0)
								pc_op<=destination_addr;
							else
								pc_op<=pc_ip+32'b1;
						end
						5'b11000:begin
							if(prev_flag[1]==1'b0)
								pc_op<=destination_addr;
							else
								pc_op<=pc_ip+32'b1;
						end
						default: begin
							pc_op<=pc_ip+32'b1;
						end
					endcase
					end
				1'b0: begin
					pc_op<=reg_1;
				end
				endcase	
			end
		end
	end
endmodule