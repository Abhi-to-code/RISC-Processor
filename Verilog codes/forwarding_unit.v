`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.04.2025 19:59:54
// Design Name: 
// Module Name: forwarding_unit
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


module forwarding_unit(
input  [3:0] ID_EX_rn1, ID_EX_rn2, EX_MEM_wn, MEM_WB_wn,   
input  EX_MEM_RegWrite, MEM_WB_RegWrite ,MEM_WB_MW, //id_ex mw
output reg write_data_control,
output reg [1:0] fa, fb 
);

//initial begin
//    fa = 2'b01;
//    fb = 2'b00;
//    write_data_control = 0;
//end

//always @(*) begin
//    if ((ID_EX_rn1 == EX_MEM_wn) &&(EX_MEM_wn != 0) && (EX_MEM_RegWrite) ) begin
//        fa <= 2'b10;

//    end //use ex_mem_wn != 0
    
//    if ((ID_EX_rn2 == EX_MEM_wn) &&(EX_MEM_wn != 0) && (EX_MEM_RegWrite) ) begin
//        fb <= 2'b01;
        
//    end //use ex_mem_wn != 0
    
//    if ((ID_EX_rn2 == MEM_WB_wn) &&(MEM_WB_wn!=0) && (MEM_WB_RegWrite) ) begin
//        fb <= 2'b10;
        
//    end //use ex_mem_wn != 0
    
//    if ((ID_EX_rn1 == MEM_WB_wn) &&(MEM_WB_wn!=0) && (MEM_WB_RegWrite) ) begin
//        fa <= 2'b00;
        
//    end //use ex_mem_wn != 0
//    if ((EX_MEM_wn == MEM_WB_wn) &&(MEM_WB_wn!=0) && (MEM_WB_MW) ) begin
//          write_data_control<=1'b1;  
//        end
//    else
//        write_data_control<=1'b0; 

 
//end

//always @(*) begin

//    fa = 2'b01;
//    fb = 2'b00;
    
//    if ((MEM_WB_RegWrite && (MEM_WB_wn != 0) && 
//        !(EX_MEM_RegWrite && (EX_MEM_wn != 0) && (EX_MEM_wn != ID_EX_rn1)) && 
//        (MEM_WB_wn == ID_EX_rn1))) begin
        
//        fa <= 2'b00;  
//    end
    
//    if (MEM_WB_RegWrite && (MEM_WB_wn != 0) && 
//        !(EX_MEM_RegWrite && (EX_MEM_wn != 0) && (EX_MEM_wn != ID_EX_rn2)) && 
//        (MEM_WB_wn == ID_EX_rn2)) begin
        
//        fb <= 2'b10; 

//    end
    
//    if (EX_MEM_RegWrite && (EX_MEM_wn != 0) && 
//        !(MEM_WB_RegWrite && (MEM_WB_wn != 0) && (MEM_WB_wn != ID_EX_rn1)) && 
//        (EX_MEM_wn == ID_EX_rn1)) begin
        
//        fa <= 2'b10; 
//    end
    
//    if (EX_MEM_RegWrite && (EX_MEM_wn != 0) && 
//        !(MEM_WB_RegWrite && (MEM_WB_wn != 0) && (MEM_WB_wn != ID_EX_rn2)) && 
//        (EX_MEM_wn == ID_EX_rn2)) begin
        
//        fb <= 2'b01; 

//    end
    
//end

always @(*) begin
    write_data_control <= 0;
    fa <= 2'b01;
    if (EX_MEM_RegWrite && (EX_MEM_wn != 4'b0) && (EX_MEM_wn == ID_EX_rn1))
        fa <= 2'b10;
    else if (MEM_WB_RegWrite && (MEM_WB_wn != 4'b0) && (MEM_WB_wn == ID_EX_rn1))
        fa <= 2'b00;
    
    fb <= 2'b00;
    if (EX_MEM_RegWrite && (EX_MEM_wn != 4'b0) && (EX_MEM_wn == ID_EX_rn2))
        fb <= 2'b01;
        if (MEM_WB_MW) begin
            fb <= 2'b00;
            write_data_control <= 1;
        end
    else if (MEM_WB_RegWrite && (MEM_WB_wn != 4'b0) && (MEM_WB_wn == ID_EX_rn2))
        fb <= 2'b00;
end

endmodule
