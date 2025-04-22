`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.04.2025 20:39:59
// Design Name: 
// Module Name: hazard_detection
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


module hazard_detection(
input [3:0]if_id_rn1, if_id_rn2, 
input [3:0]id_ex_rn2,
input id_ex_memread,
output reg IFIDWrite, ST, EnIW,
output reg pc_write
    );
    
initial begin
    pc_write = 1;
    IFIDWrite = 1;
    ST = 0;
    EnIW = 1;
end
always @(*) begin
    //default no stall
    
    if (id_ex_memread && ((id_ex_rn2 == if_id_rn1) || (id_ex_rn2 == if_id_rn2))) begin
        pc_write <= 0;
        IFIDWrite <= 0;
        ST <= 1;
				EnIW <= 0;      
    end
end
endmodule
