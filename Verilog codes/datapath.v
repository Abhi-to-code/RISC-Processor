`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.04.2025 19:11:26
// Design Name: 
// Module Name: datapath
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


module datapath(
input clk,
output reg [31:0] address, Instruction, ALU_a, ALU_b, ALU_result,
output reg [31:0] reg1, reg4, reg6, reg9, memory_at_16,
output reg [6:0] control_bits,
output reg [1:0] FA, FB,
output reg [3:0] RN1, RN2, WN, EX_MEM_WN, MEM_WB_WN
);

wire [31:0] pc_in, pc_out;
wire pc_write, EnIM, EnIW;

pc_counter pc(clk, pc_in, 1'b1, pc_out);

adder add(pc_out, 32'd4, pc_in);

wire [31:0] inst, ifid_out;
wire IFID_Write, ST; //from hazard;
wire [3:0] op, wn, rn1, rn2;
inst_memory instruction_memory(pc_out, 1, inst);

IF_ID_reg IFID_register(clk, EnIW, inst, ifid_out); //IFID write change

/////////////////////////////////
hazard_detection hazard(rn1, rn2, id_ex_out[39:36], id_ex_out[112], IFID_Write, ST, EnIW, pc_write);
//////////////////////////

wire [15:0] imm;

assign op = ifid_out[31:28];
assign wn = ifid_out[27:24];
assign rn1 = ifid_out[23:20];
assign rn2 = ifid_out[19:16];
assign imm = ifid_out[15:0];

wire ALUSrc, MR, MW, MReg, EnRW;
wire [1:0] ALUOp;

control_unit Control(op, ALUSrc, MR, MW, MReg, EnRW, ALUOp);

wire [6:0] control_mux_in, control_mux_out;
assign control_mux_in = {EnRW, MW, MR, ALUSrc, MReg, ALUOp}; // wb, m, ex

control_mux mux_control(control_mux_in, 0, control_mux_out);// change ST 

wire [37:0] mem_wb_out, mem_wb_in;
//wire [3:0] mem_wb_wn;
//wire [31:0] mem_wb_wd; 
//wire mem_wb_EnRW;

wire [31:0] rd1, rd2;
register_file register_file1(clk, rn1, rn2, mem_wb_out[3:0], mem_wb_out[35:4], mem_wb_out[36], rd1, rd2);
// assign the value from mem_wb register

wire [31:0] offset;
sign_ex sign_extend(imm, offset);

wire [114:0] id_ex_in, id_ex_out;

assign id_ex_in = {control_mux_out, rd1, rd2, rn1, rn2, wn, offset};

ID_EX_reg id_ex_register(clk, id_ex_in, id_ex_out);

wire [3:0] wn1;
mux_4bit rn2_wn_mux(id_ex_out[39:36], id_ex_out[35:32], id_ex_out[110], wn1);
                   // rn2, wn, MR

wire [31:0] fb_mux_in;
mux_2_1 alusrc_mux(id_ex_out[75:44], id_ex_out[31:0], id_ex_out[111], fb_mux_in); 
                  //rd2, offset, alusrc

wire [70:0] ex_mem_out, ex_mem_in;

// Forwarding UNIt
wire write_data_control;
wire [1:0] fa, fb;
forwarding_unit foward_unit(id_ex_out[43:40], id_ex_out[39:36], ex_mem_out[3:0], mem_wb_out[3:0], ex_mem_out[70], mem_wb_out[36], id_ex_out[113],write_data_control, fa, fb); //change this
////////////////////////////////////

wire [31:0] alu_a, alu_b;
mux_3_1 forwardB_mux(fb_mux_in, ex_mem_out[67:36], mem_wb_out[35:4], fb, alu_b); //change fb
                     //fb_mux_in, alu_out, alu_out
mux_3_1 fowardA_mux(mem_wb_out[35:4], id_ex_out[107:76], ex_mem_out[67:36], fa, alu_a); //change fa
                   //alu_out, rd1, alu_out

wire [31:0] alu_out;
alu alu1(alu_a, alu_b, id_ex_out[109:108], alu_out);

assign ex_mem_in = {id_ex_out[114], id_ex_out[113], id_ex_out[112], alu_out, id_ex_out[75:44], wn1};
                   //regwrite, MW, MR, alu_out, rd2, wn

EX_MEM_reg exmem_register(clk, ex_mem_in, ex_mem_out);  

wire write_data_control1;
regis register(clk, write_data_control, write_data_control1);

wire [31:0] mux_wd, data_out;//data_out is not required because we are not using load
mux_2_1 write_data_mux (ex_mem_out[35:4], mem_wb_out[35:4], write_data_control1, mux_wd);

data_memory DataMemory(clk, ex_mem_out[68], ex_mem_out[69], ex_mem_out[67:36], mux_wd, data_out);

assign mem_wb_in = {ex_mem_out[69], ex_mem_out[70], ex_mem_out[67:36], ex_mem_out[3:0]};
                   //memwrite, regwrite, alu_out, wn
MEM_WB_reg memwb_register(clk, mem_wb_in, mem_wb_out);


always @(posedge clk) begin
    address <= pc_out;
    Instruction <= inst;
    ALU_a <= alu_a;
    ALU_b <= alu_b;
    ALU_result <= alu_out;
    memory_at_16 <= {DataMemory.mem[16], DataMemory.mem[17], DataMemory.mem[18], DataMemory.mem[19]};
    control_bits <= id_ex_out[114:108];
    FA <= fa;
    FB <= fb;
    RN1 <= id_ex_out[43:40]; //rn1
    RN2 <= id_ex_out[39:36];// rn2
    EX_MEM_WN <= ex_mem_out[3:0]; // wnex_mem_out[3:0]
    MEM_WB_WN <= mem_wb_out[3:0]; // wn mem_wb_out[3:0]  
    
end

always @(negedge clk) begin
    reg1 <= register_file1.register[1];
    reg4 <= register_file1.register[4];
    reg6 <= register_file1.register[6];
    reg9 <= register_file1.register[9];   
end
endmodule
