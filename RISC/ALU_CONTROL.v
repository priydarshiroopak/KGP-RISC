`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:48:13 10/21/2022 
// Design Name: 
// Module Name:    ALU_CONTROL 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module alu_control(
	input [4:0] func,
	input alu_op,
	output reg [3:0] alu_signal
    );
	 always @(*) begin
        case(alu_op)					// signal form main control
            1'b1:						// alu_op will depend on funciton bits
                begin
                    case(func)
                        
                        5'b00001: alu_signal <= 4'b0001; // add
								5'b00010: alu_signal <= 4'b0010; // and
                        5'b00011: alu_signal <= 4'b0011; // compliment
								5'b00100: alu_signal <= 4'b0100; // xor
                        5'b00101: alu_signal <= 4'b0101; // sll
								5'b00110: alu_signal <= 4'b0110; // srl
								5'b00111: alu_signal <= 4'b0111; // sra
								5'b01000: alu_signal <= 4'b1000; // diff
                        default: alu_signal <= 4'b0000; 
                    endcase
                end
            1'b0:						// alu_op independent of function bits (add always)
                begin
                    alu_signal <= 4'b0001; // add
                end
           
            default:
					begin
						//do nothing
					end
				
				endcase
    end

endmodule

