`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Group 16 - Computer Organisation and Architecture
// Roopak Priydarshi (20CS30042)
// Saras Umakant Pantulwar (20CS30046)
// 4-bit Carry Look-ahead Adder (augmenetd to return generated and propogated bits)
////////////////////////////////////////////////////////////////////////////////
module CLA_4bit_aug(
    input [3:0] ip1,
    input [3:0] ip2,
    input c_in,
    output [3:0]sum,
    output P,
    output G
    );

/*
	Logic:
	
	g[i] = in1[i] & in2[i], 0 <= i <= 3
	p[i] = in1[i] ^ in2[i], 0 <= i <= 3
	
	Take c_in to be carry[0] then
	sum[i] = p[i] ^ carry[i], 0 <= i <= 3
	carry[i] = g[i-1] | (p[i-1] & carry[i-1]), 1 <= i <= 4
	
	Recursively expanding we get
	carry[1] = g[0] | (p[0] & carry[0]) = g[0] | (p[0] & c_in)
	carry[2] = g[1] | (p[1] & carry[1]) = g[1] | (p[1] & g[0]) | (p[1] & p[0] & c_in)
	carry[3] = g[2] | (p[2] & carry[2]) = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & c_in)
	carry[4] = g[3] | (p[3] & carry[3]) = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]) | (p[3] & p[2] & p[1] & p[0] & c_in)

    Also block propogate p and generate g are calculated as
    p = P[3] & P[2] & P[1] & P[0]
    g = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0])
*/
	
    wire [3:0] g, p, c;
    wire [9:0] f; // wires for bitwise generate, propagate and carries
	
    // calculate bitwise generate and propagate
    // assign g = ip1 & ip2;
    and gen0(g[0], ip1[0], ip2[0]);
    and gen1(g[1], ip1[1], ip2[1]);
    and gen2(g[2], ip1[2], ip2[2]);
    and gen3(g[3], ip1[3], ip2[3]);

    // assign p = ip1 ^ ip2;
    xor  pro0(p[0], ip1[0], ip2[0]);
    xor  pro1(p[1], ip1[1], ip2[1]);
    xor  pro2(p[2], ip1[2], ip2[2]);
    xor  pro3(p[3], ip1[3], ip2[3]);
	
    // calculate subsequent carries using generates and propagates
    and and0(f[0], p[0] , c[0]);
    and and1(f[1], p[1] , g[0]);
    and and2(f[2], p[1] , p[0] , c[0]);
    and and3(f[3], p[2] , g[1]);
    and and4(f[4], p[2] , p[1] , g[0]);
    and and5(f[5], p[2] , p[1] , p[0] , c[0]);
    and and6(f[6], p[3] , g[2]);
    and and7(f[7], p[3] , p[2] , g[1]);
    and and8(f[8], p[3] , p[2] , p[1] , g[0]);
    and and9(f[9], p[3] , p[2] , p[1] , p[0] , c[0]);
    
    assign c[0] = c_in;
    or  or0(c[1], g[0], f[0]);
    or  or1(c[2], g[1], f[1], f[2]);
    or  or2(c[3], g[2], f[3], f[4], f[5]);
    or  or3(c_out, g[3], f[6], f[7], f[8], f[9]);


    // calculate final sum using propagate and carries
    // i.e. sum = p ^ c;
    xor s0(sum[0], p[0], c[0]);
    xor s1(sum[1], p[1], c[1]);
    xor s2(sum[2], p[2], c[2]);
    xor s3(sum[3], p[3], c[3]);

    // calculate block propogate and generate for next level
    and pro(P, p[0], p[1], p[2], p[3]);
    or  gen(G, g[3], f[6], f[7], f[8]);

endmodule