`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:28:43 11/09/2022 
// Design Name: 
// Module Name:    mux_2_1 
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
module mux_2_1(
	input signal,
	input [31:0]a,
	input [31:0]b,
	output reg [31:0] c
    );
	always @(*) begin
		case(signal)
			1'b1:
				begin
					c <= a;
				end
			1'b0:
				begin
					c <= b;
				end
			
			default:
				begin
					// do nothing
				end
		endcase
	end

endmodule
