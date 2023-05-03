`timescale 1ns / 1ps

module data_memory(
    input [31:0] address,
    input clk,
    input read_signal,
    input write_signal,
    input [31:0] write_data,
    output [31:0] read_data_out
    );
	
   Data_Ram data_memory (
  .clka(~clk), // input clka
  .wea(write_signal), // input [0 : 0] wea
  .addra(address[15:0]), // input [15 : 0] addra
  .dina(write_data), // input [31 : 0] dina
  .douta(read_data_out) // output [31 : 0] douta
);
always@(posedge clk)begin
if(read_signal)begin
$display("read_data_out=%d, address=%b, write_signal=%b,read_signal=%b",read_data_out,address,write_signal,read_signal);
end
else begin
if(write_signal)begin
$display("write_data=%d, address=%b, write_signal=%b,read_signal=%b",write_data,address,write_signal,read_signal);
end
end
end

endmodule