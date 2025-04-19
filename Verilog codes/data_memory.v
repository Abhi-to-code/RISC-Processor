`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.04.2025 22:31:16
// Design Name: 
// Module Name: data_memory
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


module data_memory(
input clk,
input MR, MW,
input [31:0] add, wd,
output reg [31:0] data
);

reg [7:0] mem [0:40];

initial begin
    mem[0] = 8'b0;
    mem[16] = 8'd45;
end

always @(posedge clk) begin
    if (MR == 1 && MW == 0)
        data <= {mem[add],mem[add+1], mem[add+2], mem[add+3]};
    else if (MR == 0 && MW == 1)
        {mem[add],mem[add+1], mem[add+2], mem[add+3]} <= wd;
end
endmodule
