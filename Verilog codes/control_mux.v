`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.04.2025 22:06:32
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
input [6:0] a,
input ST,
output reg [6:0] control
);

always @(*) begin
    if (ST == 0)
        control <= a;
    else
        control <= 7'b0; 
end
endmodule
