`timescale 1ns / 1ps

module register_file(
    input [4:0] reg_addr_1,
    input [4:0] reg_addr_2,
    input [1:0] reg_write,
    input [31:0] writeData,
    output [31:0] read_data_1,
    output [31:0] read_data_2,
    input clk,
    input rst,
	 output [31:0] retReg // for getting final output while testing
    );

    reg [31:0] reg_[31:0];

    always @(posedge clk) begin
        if(rst) begin
            reg_[0] <= 32'd12;
            reg_[1] <= 32'd3;
            reg_[2] <= 32'd5;
            reg_[3] <= 32'd0;
            reg_[4] <= 32'd32;
            reg_[5] <= 32'd0;
            reg_[6] <= 32'd0;
            reg_[7] <= 32'd0;
            reg_[8] <= 32'd0;
            reg_[9] <= 32'd0;
            reg_[10] <= 32'd0;
            reg_[11] <= 32'd0;
            reg_[12] <= 32'd0;
            reg_[13] <= 32'd0;
            reg_[14] <= 32'd0;
            reg_[15] <= 32'd0;
            reg_[16] <= 32'd0;
            reg_[17] <= 32'd0;
            reg_[18] <= 32'd0;
            reg_[19] <= 32'd0;
            reg_[20] <= 32'd0;
            reg_[21] <= 32'd0;
            reg_[22] <= 32'd0;
            reg_[23] <= 32'd0;
            reg_[24] <= 32'd0;
            reg_[25] <= 32'd0;
            reg_[26] <= 32'd0;
            reg_[27] <= 32'd0;
            reg_[28] <= 32'd0;
            reg_[29] <= 32'd0;
            reg_[30] <= 32'd0;
            reg_[31] <= 32'd0;
        end else begin
            case(reg_write)
                2'b01:
                    begin
                        reg_[reg_addr_1] <= writeData;  ////write to register 1
                    end 
                2'b10:
                    begin
                        reg_[reg_addr_2] <= writeData;  //write to register 2 in case of load word
                    end
                2'b11:
                    begin
                        reg_[5'b11111] <= writeData;   //write to register 32 in case of bl 
                    end
                default:
                    begin
                        // do nothing
                    end 
            endcase
        end
		  //$display("reg_0=%d,reg_1=%d,reg_2=%d",reg_[0],reg_[1],reg_[2]);
    end

    assign read_data_1 = reg_[reg_addr_1];
    assign read_data_2 = reg_[reg_addr_2];
	 assign retReg = reg_[5'b00001];
endmodule