`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.04.2025 22:27:56
// Design Name: 
// Module Name: pc_counter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module pc_counter(
input clk,
input [31:0] pc_in,
input pc_write,
output reg [31:0] pc_out
);

initial pc_out = 32'b00;

always @(posedge clk) begin
    if (pc_write)
        pc_out <= pc_in; 
end
endmodule
