`timescale 1ns / 1ps

module mux_3_1(
    input [1:0]mem_reg_pc,
    input [31:0] mem_data,
    input [31:0] alu_data,
    input [31:0] pc_in,
    output reg [31:0] writedata
    );
	
	always @(*) begin
		case(mem_reg_pc)
			2'b11:
				begin
					writedata <= mem_data;
				end
			2'b10:
				begin
					writedata <= alu_data;
				end
			2'b01:
				begin
					writedata <= pc_in;
				end
			default:
				begin
					// do nothing
				end
		endcase
	end

endmodule