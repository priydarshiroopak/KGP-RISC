`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Group 16 - Computer Organisation and Architecture
// Roopak Priydarshi (20CS30042)
// Saras Umakant Pantulwar (20CS30046)
// Look Ahead Carry unit (for usage in 16-bit adders)
//////////////////////////////////////////////////////////////////////////////////

module LookAheadCarryUnit(
    input c_in,
    input [3:0] P,
    input [3:0] G,
    output [4:1] c,
    output P_cla,
    output G_cla
    );

/*
	Logic:
	
	Take c_in to be c[0] then
	c[i] = G[i-1] | (P[i-1] & c[i-1]), 1 <= i <= 4
	
	Recursively expanding we get
	c[1] = G[0] | (P[0] & c[0]) = G[0] | (P[0] & c_in)
	c[2] = G[1] | (P[1] & c[1]) = G[1] | (P[1] & G[0]) | (P[1] & P[0] & c_in)
	c[3] = G[2] | (P[2] & c[2]) = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & c_in)
	c[4] = G[3] | (P[3] & c[3]) = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) | (P[3] & P[2] & P[1] & P[0] & c_in)
	
	Also block propogate P_cla and generate G_cla are calculated as
	P_cla = P[3] & P[2] & P[1] & P[0]
	G_cla = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0])
*/
	
	// calculate the lookahead carries using block propagate and generate from previous level
	
    wire [9:0]f;
    and and0(f[0], P[0], c_in);
    and and1(f[1], P[1], G[0]);
    and and2(f[2], P[1], P[0], c_in);
    and and3(f[3], P[2], G[1]);
    and and4(f[4], P[2], P[1], G[0]);
    and and5(f[5], P[2], P[1], P[0], c_in);
    and and6(f[6], P[3], G[2]);
    and and7(f[7], P[3], P[2], G[1]);
    and and8(f[8], P[3], P[2], P[1], G[0]);
    and and9(f[9], P[3], P[2], P[1], P[0], c_in);

    or  or0(c[1], G[0], f[0]);
    or  or1(c[2], G[1], f[1], f[2]);
    or  or2(c[3], G[2], f[3], f[4], f[5]);
    or  or3(c[4], G[3], f[6], f[7], f[8], f[9]);


	// calculate the block propagate and generate for the next level
    and pro(P_cla, P[3], P[2], P[1], P[0]);
    or  gen(G_cla, G[3], f[6], f[7], f[8]);
endmodule