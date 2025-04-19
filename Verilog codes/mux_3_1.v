`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.04.2025 22:22:13
// Design Name: 
// Module Name: mux_3_1
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


module mux_3_1(
input [31:0] a,b,c,
input [1:0] s,
output reg [31:0] out
);

always @(*) begin
    case(s)
        2'b00: out<= a;
        2'b01: out<= b;
        2'b10: out<= c;
    endcase
end
endmodule
