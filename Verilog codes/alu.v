`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.04.2025 22:24:29
// Design Name: 
// Module Name: alu
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


module alu(
input [31:0] a,b,
input [1:0] alu_op,
output reg [31:0] result
);

always @(*) begin
    case(alu_op)
        2'b00: result = a + b;
        2'b01: result = a - b;
        2'b10: result = a | b;
        2'b11: result = ~(a & b);
    endcase
end
endmodule
