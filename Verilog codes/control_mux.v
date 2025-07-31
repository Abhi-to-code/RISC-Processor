`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.07.2025 10:04:55
// Design Name: 
// Module Name: control_mux
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


module control_mux(
input [7:0] a,
input ST,
output reg [7:0] control
);

always @(*) begin
    if (ST == 0)
        control <= a;
    else
        control <= 7'b0; 
end
endmodule
