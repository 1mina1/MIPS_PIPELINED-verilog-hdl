// FILE NAME: Memory_Unit.v
// TYPE: module
// DEPARTMENT: communication and electronics department
// AUTHOR: Mina Hanna
// AUTHOR EMAIL: mina.hannaone@gmail.com
//------------------------------------------------
// Release history
// VERSION DATE AUTHOR DESCRIPTION
// 1.0 4/9/2022 Mina Hanna final version
//------------------------------------------------
// KEYWORDS: pipeline mips, memory instruction
//------------------------------------------------
// PURPOSE: this is the memory unit of the mips\
///////////inputs and outputs ports declaration/////////////
module Memory_Unit #(parameter WIDTH =32) (
  input    wire    [WIDTH-1:0]    MU_AluOutE,
  input    wire    [WIDTH-1:0]    MU_WriteDataE,
  input    wire    [4:0]          MU_WriteRegE,
  input    wire                   MU_RegWriteE,
  input    wire                   MU_MemWriteE,
  input    wire                   MU_MemToRegE,
  input    wire                   MU_CLK,
  input    wire                   MU_RST,
  output   wire    [WIDTH-1:0]    MU_AluOutM,
  output   wire    [WIDTH-1:0]    MU_ReadDataM,
  output   wire    [4:0]          MU_WriteRegM,
  output   wire                   MU_RegWriteM,
  output   wire                   MU_MemToRegM 
  );
  
  ///////////////////////////wires definitions/////////////////////
  wire    [WIDTH-1:0]     WriteDataM;
  wire                    MemWriteM;
  //////////////////////////modules instantiations/////////////////
  /////////////////////////input FF///////////////////////////////
  ETOMFF #(.WIDTH(WIDTH)) U0_ETOMFF(
  .ETOMFF_AluOutE(MU_AluOutE),
  .ETOMFF_WriteDataE(MU_WriteDataE),
  .ETOMFF_WriteRegE(MU_WriteRegE),
  .ETOMFF_RegWriteE(MU_RegWriteE),
  .ETOMFF_MemWriteE(MU_MemWriteE),
  .ETOMFF_MemToRegE(MU_MemToRegE),
  .ETOMFF_CLK(MU_CLK),
  .ETOMFF_RST(MU_RST),
  .ETOMFF_AluOutM(MU_AluOutM),
  .ETOMFF_WriteDataM(WriteDataM),
  .ETOMFF_WriteRegM(MU_WriteRegM),
  .ETOMFF_RegWriteM(MU_RegWriteM),
  .ETOMFF_MemWriteM(MemWriteM),
  .ETOMFF_MemToRegM(MU_MemToRegM) 
  );
  
  /////////////////////////Data memory///////////////////////////
  Data_memory #(.WIDTH(WIDTH)) U0_Data_memory(
  .DataMemory_A(MU_AluOutM),
  .DataMemory_WD(WriteDataM),
  .DataMemory_WE(MemWriteM),
  .DataMemory_CLK(MU_CLK),
  .DataMemory_RST(MU_RST),
  .DataMemory_RD(MU_ReadDataM),
  .test()
  );
endmodule