`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

module alu(
    input [31:0] ip1,
    input [31:0] ip2,
    input [3:0] alu_signal,			// signal from alu_control
    output reg [31:0] out,				// result of alu
    output reg [2:0] flags				// set branch flags
    );

    wire [31:0] sum, comp, bit_and, bit_xor, sll, srl, sra;
    wire sum_carry;
	 reg	[5:0] i;
	 reg  [31:0] diff;
	 
	 always @(ip1, ip2) begin
		i = 0;
		while( i != 6'd32 && ip1[i]^ip2[i] == 32'd0) begin
			i = i+1;
		end
		diff = {26'd0, i};
	 end
	

    // sum using the cla developed in assignment 1, cascading two 16-bit CLAs
    wire sum_c_out, p1, g1, p2, g2;
    CLA_16bit_LCU cla1(.ip1(ip1[15:0]), .ip2(ip2[15:0]), .c_in(1'b0), .sum(sum[15:0]), .c_out(sum_c_out), .p(p1), .g(g1));
	 CLA_16bit_LCU cla2(.ip1(ip1[31:16]), .ip2(ip2[31:16]), .c_in(sum_c_out), .sum(sum[31:16]), .c_out(sum_carry), .p(p2), .g(g2));
	 
	 //assign {sum_carry,sum[31:0]} = ip1 + ip2;
    assign bit_and = ip1 & ip2;		// and
    assign comp = ~ip2 + 1'b1; 		// complement
    assign bit_xor = ip1 ^ ip2;		// xor
    
	 //assign ip2= {27'b0, ip2[4:0]};
    assign sra = ip1 >>> ip2;			// sra
    assign sll = ip1 << ip2;			// sll	
    assign srl = ip1 >> ip2;			// srl
	
    always @(*) begin
		// flag[0] shows if input 1 == zero
		// flag[1] shows if input 1 < zero
		// flag[2] carry
		//$display("input1=%d,input2=%d",ip1,ip2);
		if (ip1 == 32'd0) flags[0] = 1'b1;
		else flags[0] = 1'b0;
		if (ip1[31] == 1'b1) flags[1] = 1'b1;
		else flags[1] = 1'b0;
        case(alu_signal[3:0])
            4'b0001: 					// add
                begin
                    out <= sum;
                    flags[2] <= sum_carry;
                end	
            4'b0010:						// and
                begin
                    out <= bit_and;
                    flags[2] <= 1'b0;
                end
				4'b0011:						// comp
                begin
                    out = comp;
                    flags[2] = 1'b0;
                end
            
            4'b0100:						// xor
                begin
                    out = bit_xor;
                    flags[2] = 1'b0;
                end
            4'b0101:						// sll
                begin
                    out = sll;
                    flags[2] = 1'b0;
                end
            4'b0110:						// srl
                begin
                    out = srl;
                    flags[2] = 1'b0;
                end
            4'b0111:						// sra
                begin
                    out = sra;
                    flags[2] = 1'b0;
                end
            4'b1000:						// diff
                begin
                    out = diff;
                    flags[2] = 1'b0;
                end
            default:
                begin
                    out = 32'b0;    
                    flags[2] = 1'b0;
						  //do nothing
                end
        endcase
    end
endmodule