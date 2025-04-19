`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.04.2025 22:44:11
// Design Name: 
// Module Name: register_file
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


module register_file(
input clk,
input [3:0] rn1, rn2, wn,
input [31:0] wd,
input EnRW,
output [31:0] rd1, rd2
);

reg [32:0] register [0:15];

initial begin
    register[0] = 32'd0;
    register[1] = 32'h0;
    register[2] = 32'h64511;
    register[3] = 32'h343EE;
    register[4] = 32'h0;
    register[5] = 32'h8E319;
    register[6] = 32'h0;
    register[7] = 32'hB;
    register[8] = 32'hF3390;
    register[9] = 32'h0;
    register[10] = 32'h0;
    register[11] = 32'h0;
    register[12] = 32'h0;
    register[13] = 32'h0;
    register[14] = 32'h0;
    register[15] = 32'h0; 
end

assign rd1 = register[rn1];
assign rd2 = register[rn2];


always @(negedge clk) begin
    if(EnRW)
        register[wn] <= wd;
end
endmodule
