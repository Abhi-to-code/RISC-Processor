`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.04.2025 22:35:51
// Design Name: 
// Module Name: inst_memory
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


module inst_memory(
input [31:0] address,
input EnIM,
output reg [31:0] inst
);

reg [7:0] memory [0:31];

initial begin
memory[0] = 8'h01; memory[1] = 8'h23; memory[2] = 8'h00; memory[3] = 8'h0;
memory[4] = 8'h14; memory[5] = 8'h15; memory[6] = 8'h0; memory[7] = 8'h0;
memory[8] = 8'h36; memory[9] = 8'h14; memory[10] = 8'h0; memory[11] = 8'h0;
memory[12] = 8'h70; memory[13] = 8'h76; memory[14] = 8'h00; memory[15] = 8'h05;
memory[16] = 8'hF0; memory[17] = 8'h89; memory[18] = 8'hAB; memory[19] = 8'h1E;
memory[20] = 8'h0; memory[21] = 8'h0; memory[22] = 8'h0; memory[23] = 8'h0;
 
end

always @(*) begin
    if (EnIM)
        inst <= {memory[address], memory[address + 1], memory[address + 2], memory[address + 3]};   
end
endmodule
