`timescale 1ns / 1ps

module instruction_fetcher(
    input [31:0] pc,
    input clk,
    output [31:0] instr
    );
Instr_Rom instr_memory(
  .clka(clk), // input clka
  .addra(pc[15:0]), // input [15 : 0] addra
  .douta(instr) // output [31 : 0] douta
);

//always @(posedge clk)begin
//$display("instruciton fetcher : pc=%b, instr=%b",pc,instr);
//end
endmodule