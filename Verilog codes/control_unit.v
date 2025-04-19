`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.04.2025 22:52:45
// Design Name: 
// Module Name: control_unit
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


module control_unit(
input [3:0] op,
output reg ALUSrc, MR, MW, MReg, EnRW,
output reg [1:0] ALUOp
);

always @(*) begin
    case(op)
        4'b0000: begin //0000 ADD reg1, reg2, reg3
            ALUOp <= 2'b00;
            ALUSrc <= 0;
            MReg <= 1;
            EnRW <= 1;
        end
        
        4'b0001: begin //0004 SUB reg4, reg1, reg5
            ALUOp <= 2'b01;
            ALUSrc <= 0;
            MReg <= 1;
            EnRW <= 1;            
        end
        
        4'b0011: begin //0008 OR reg6, reg1, reg4
            ALUOp <= 2'b10;
            ALUSrc <= 0;
            MReg <= 1;
            EnRW <= 1;
        end
        
        4'b0111: begin//0012 SW reg6, 5(reg7)
            ALUOp <= 2'b00;
            MR <= 0;
            MW <= 1;
            ALUSrc <= 1;
            MReg <= 0;
            EnRW <= 0;
        end
        4'b1111: begin //0016 NANDI reg9, reg8, AB1E
            ALUOp <= 2'b11;
            ALUSrc <= 1;
            MReg <= 0;
            EnRW <= 1;
        end
    endcase
end
endmodule
