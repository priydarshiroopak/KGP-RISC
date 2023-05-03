`timescale 1ns / 1ps

module main_control(
    input [5:0]opcode,
    output reg [1:0]branch,
    output reg mem_read,
    output reg mem_write,
    output reg [1:0]mem_to_reg,
    output reg alu_op,
    output reg alu_src,
    output reg [1:0]reg_write,
	 output reg ls_signal
    );

    
    always @(*) begin
        case(opcode)
            6'b000001:							// Add, comp, and, xor, diff
                begin
                    branch <= 2'b00;
                    mem_read <= 1'b0;
                    mem_write <= 1'b0;
                    mem_to_reg <= 2'b10;
                    alu_op <= 1'b1;
                    alu_src <= 1'b1;
                    reg_write <= 2'b01;
						  ls_signal <= 1'b0;
                end
            6'b000010:							// addi, compi
                begin
                    branch <= 2'b00;
                    mem_read <= 1'b0;
                    mem_write <= 1'b0;
                    mem_to_reg <= 2'b10;
                    alu_op <= 1'b1;
                    alu_src <= 1'b0;
                    reg_write <= 2'b01;
						  ls_signal <= 1'b0;
                end
            6'b000011:							// sll, srl, sra
                begin
                    branch <= 2'b00;
                    mem_read <= 1'b0;
                    mem_write <= 1'b0;
                    mem_to_reg <= 2'b10;
                    alu_op <= 1'b1;
                    alu_src <= 1'b0;
                    reg_write <= 2'b01;
						  ls_signal <= 1'b0;
                end
            6'b000100:							// sllv, srlv,srav
                begin
                    branch <= 2'b00;
                    mem_read <= 1'b0;
                    mem_write <= 1'b0;
                    mem_to_reg <= 2'b10;
                    alu_op <= 1'b1;
                    alu_src <= 1'b1;
                    reg_write <= 2'b01;
						  ls_signal <= 1'b0;
                end
            6'b000101:							// lw
                begin
                    branch <= 2'b00;
                    mem_read <= 1'b1;
                    mem_write <= 1'b0;
                    mem_to_reg <= 2'b11;
                    alu_op <= 1'b0;
                    alu_src <= 1'b0;
                    reg_write <= 2'b10;
						  ls_signal <= 1'b1;
                end
            6'b000110:							// sw
                begin
                    branch <= 2'b00;
                    mem_read <= 1'b0;
                    mem_write <= 1'b1;
                    mem_to_reg <= 2'b11;
                    alu_op <= 1'b0;
                    alu_src <= 1'b0;
                    reg_write <= 2'b00;
						  ls_signal <= 1'b1;
                end
            6'b001000:							// b, bcy, bncy
                begin
                    branch <= 2'b11;
                    mem_read <= 1'b0;
                    mem_write <= 1'b0;
                    mem_to_reg <= 2'b10;
                    alu_op <= 1'b1;
                    alu_src <= 1'b1;
                    reg_write <= 2'b00;
						  ls_signal <= 1'b0;
                end
            6'b001010:							// bl
                begin
                    branch <= 2'b11;
                    mem_read <= 1'b0;
                    mem_write <= 1'b0;
                    mem_to_reg <= 2'b01;
                    alu_op <= 1'b1;
                    alu_src <= 1'b1;
                    reg_write <= 2'b11;
						  ls_signal <= 1'b0;
                end
            6'b001011:							// bltz, bz, bnz
                begin
                    branch <= 2'b11;
                    mem_read <= 1'b0;
                    mem_write <= 1'b0;
                    mem_to_reg <= 2'b10;
                    alu_op <= 1'b1;
                    alu_src <= 1'b1;
                    reg_write <= 2'b00;
						  ls_signal <= 1'b0;
                end
            6'b001001:							// br
                begin
                    branch <= 2'b10;
                    mem_read <= 1'b0;
                    mem_write <= 1'b0;
                    mem_to_reg <= 2'b10;
                    alu_op <= 1'b1;
                    alu_src <= 1'b1;
                    reg_write <= 2'b00;
						  ls_signal <= 1'b0;
                end
            default:
                begin
                    branch <= 2'b00;
                    mem_read <= 1'b0;
                    mem_write <= 1'b0;
                    mem_to_reg <= 2'b00;
                    alu_op <= 1'b0;
                    alu_src <= 1'b0;
                    reg_write <= 2'b00;
						  ls_signal <= 1'b0;
                end
        endcase
    end

endmodule
