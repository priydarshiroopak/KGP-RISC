`timescale 1ns / 1ps

module program_counter(
    input [31:0] pc_ip,
    input clk,
    input rst,
    output reg [31:0] pc_op
    );

    always @(posedge clk) begin
        if(rst) begin
            pc_op <= 32'b0;
        end else begin
            pc_op <= pc_ip;
        end
    end

endmodule