`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Group 16 - Computer Organisation and Architecture
// Roopak Priydarshi (20CS30042)
// Saras Umakant Pantulwar (20CS30046)
// 16-bit adder using look ahead unit and four 4-bit RCA's
//////////////////////////////////////////////////////////////////////////////////

module CLA_16bit_LCU(
    input [15:0] ip1,
    input [15:0] ip2,
    input c_in,
    output [15:0] sum,
    output c_out,
    output p,
    output g
    );
	 
	wire [4:1] c; // wires for connecting carries from lookahead carry unit to the 4-bit CLAs
	wire [3:0] P, G; // wires for connecting block propagate and generate from 4-bit CLAs to lookahead carry unit
	 
	// 16 bit adder by using four augmented 4-bit CLAs and a lookahead carry unit
	CLA_4bit_aug cla4_1(.ip1(ip1[3:0]), .ip2(ip2[3:0]), .c_in(c_in), .sum(sum[3:0]), .P(P[0]), .G(G[0]));
	CLA_4bit_aug cla4_2(.ip1(ip1[7:4]), .ip2(ip2[7:4]), .c_in(c[1]), .sum(sum[7:4]), .P(P[1]), .G(G[1]));
	CLA_4bit_aug cla4_3(.ip1(ip1[11:8]), .ip2(ip2[11:8]), .c_in(c[2]), .sum(sum[11:8]), .P(P[2]), .G(G[2]));
	CLA_4bit_aug cla4_4(.ip1(ip1[15:12]), .ip2(ip2[15:12]), .c_in(c[3]), .sum(sum[15:12]), .P(P[3]), .G(G[3]));
	
	LookAheadCarryUnit lcu(.c_in(c_in), .P(P), .G(G), .c(c), .P_cla(p), .G_cla(g));
	
	assign c_out = c[4];
endmodule