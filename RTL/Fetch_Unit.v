// FILE NAME: Fetch_Unit.v
// TYPE: module
// DEPARTMENT: communication and electronics department
// AUTHOR: Mina Hanna
// AUTHOR EMAIL: mina.hannaone@gmail.com
//------------------------------------------------
// Release history
// VERSION DATE AUTHOR DESCRIPTION
// 1.0 4/9/2022 Mina Hanna final version
//------------------------------------------------
// KEYWORDS: pipeline mips, fetch instruction
//------------------------------------------------
// PURPOSE: this is the fetch unit of the mips\
///////////inputs and outputs ports declaration//////////////
module Fetch_Unit #(parameter WIDTH =32) (
  input     wire     [1:0]          FU_PcSrc,
  input     wire     [WIDTH-1:0]    FU_PcBranch,
  input     wire     [WIDTH-1:0]    FU_PcJump,
  input     wire                    FU_StallF,
  input     wire                    FU_CLK,
  input     wire                    FU_RST,
  output    wire     [WIDTH-1:0]    FU_Instr,
  output    wire     [WIDTH-1:0]    FU_PcPlus4
  );
  
  //////////////////////wires  definitions /////////////////////
  wire    [WIDTH-1:0]    PC;
  wire    [WIDTH-1:0]    PCF;
  //////////////////////modules instantiations//////////////////
  Instruction_memory #(.WIDTH(WIDTH)) U0_Instruction_memory(
  .InstructionMemory_PC(PCF),
  .InstructionMemory_OUT(FU_Instr));
  
  PCFF #(.WIDTH(WIDTH)) U0_PCFF(
  .PC_IN(PC),
  .PC_EN((~(FU_StallF))),
  .PC_CLK(FU_CLK),
  .PC_RST(FU_RST),
  .PC_OUT(PCF)
  );
  
  Adder #(.WIDTH(WIDTH)) U0_Adder(
  .Adder_IN1(PCF),
  .Adder_IN2('d4),
  .Adder_OUT(FU_PcPlus4)
  );
  
  mux4X1 #(.WIDTH(WIDTH)) U0_mux4X1(
  .sel(FU_PcSrc),
  .IN_1(FU_PcPlus4),
  .IN_2(FU_PcBranch),
  .IN_3(FU_PcJump),
  .IN_4(),
  .OUT(PC)
  );
  
endmodule
  