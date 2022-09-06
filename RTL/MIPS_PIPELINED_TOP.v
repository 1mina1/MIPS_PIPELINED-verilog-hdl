// FILE NAME: MIPS_PIPELINED_TOP.v
// TYPE: module
// DEPARTMENT: communication and electronics department
// AUTHOR: Mina Hanna
// AUTHOR EMAIL: mina.hannaone@gmail.com
//------------------------------------------------
// Release history
// VERSION DATE AUTHOR DESCRIPTION
// 1.0 4/9/2022 Mina Hanna final version
//------------------------------------------------
// KEYWORDS: pipeline mips
//------------------------------------------------
// PURPOSE: this is the top module for the pipelined mips\
///////////inputs and outputs ports declaration//////////////
module MIPS_PIPELINED_TOP #(parameter WIDTH =32) (
  input     wire    CLK,
  input     wire    RST
  );
  ////////////////////Wires Definitions//////////////////////
  wire    [WIDTH-1:0]    PcJump;
  wire    [WIDTH-1:0]    PcBranch;
  wire    [WIDTH-1:0]    InstrF;
  wire    [WIDTH-1:0]    PcPlus4F;
  wire    [WIDTH-1:0]    AluOutM;
  wire    [WIDTH-1:0]    ResultW;
  wire    [WIDTH-1:0]    RD1D;
  wire    [WIDTH-1:0]    RD2D;
  wire    [WIDTH-1:0]    SignImmD;
  wire    [WIDTH-1:0]    AluOutE;
  wire    [WIDTH-1:0]    WriteDataE;
  wire    [WIDTH-1:0]    ReadDataM;
  wire    [4:0]          WriteRegE;
  wire    [4:0]          WriteRegM;
  wire    [4:0]          WriteRegW;
  wire    [4:0]          RsD;
  wire    [4:0]          RtD;
  wire    [4:0]          RdD;
  wire    [4:0]          RsE;
  wire    [4:0]          RtE;
  wire    [2:0]          ALuControlD;
  wire    [1:0]          PcSrc;
  wire    [1:0]          ForwardAE;
  wire    [1:0]          ForwardBE;
  wire                   ForwardAD;
  wire                   ForwardBD;
  wire                   RegWriteW;
  wire                   RegWriteM;
  wire                   RegWriteD;
  wire                   RegWriteE;
  wire                   MemWriteD;
  wire                   MemWriteE;
  wire                   MemToRegD;
  wire                   MemToRegE;
  wire                   MemToRegM;
  wire                   AluSrcD;
  wire                   RegDstD;
  wire                   JumpD;
  wire                   BranchD;
  wire                   StallD;
  wire                   StallF;
  wire                   FlushE;
  ///////////////////models instantiations///////////////////
  //////////////////instructions decompositions ////////////
  Fetch_Unit #(.WIDTH(WIDTH)) U0_Fetch_Unit(
  .FU_PcSrc(PcSrc),
  .FU_PcBranch(PcBranch),
  .FU_PcJump(PcJump),
  .FU_StallF(StallF &((~(PcSrc[0] & ForwardAD))&(~(PcSrc[0] & ForwardBD)))),
  .FU_CLK(CLK),
  .FU_RST(RST),
  .FU_Instr(InstrF),
  .FU_PcPlus4(PcPlus4F)
  );
  Decode_Unit #(.WIDTH(WIDTH)) U0_Decode_Unit(
  .DU_InstrF(InstrF),
  .DU_PCPLUS4F(PcPlus4F),
  .DU_ALUOUTM(AluOutM),
  .DU_ResultW(ResultW),
  .DU_WriteRegW(WriteRegW),
  .DU_RegWriteW(RegWriteW),
  .DU_StallD(StallD),
  .DU_ForwardAD(ForwardAD),
  .DU_ForwardBD(ForwardBD),
  .DU_CLK(CLK),
  .DU_RST(RST),
  .DU_RsD(RsD),
  .DU_RtD(RtD),
  .DU_RdD(RdD),
  .DU_PcBranchD(PcBranch),
  .DU_PcJumpD(PcJump),
  .DU_PcSrc(PcSrc),
  .DU_R1(RD1D),
  .DU_R2(RD2D),
  .DU_SignImmD(SignImmD),
  .DU_RegWriteD(RegWriteD),
  .DU_MemWriteD(MemWriteD),
  .DU_MemToRegD(MemToRegD),
  .DU_ALuControlD(ALuControlD),
  .DU_AluSrcD(AluSrcD),
  .DU_JumpD(JumpD),
  .DU_BranchD(BranchD),
  .DU_RegDstD(RegDstD)
  );
  Execute_Unit #(.WIDTH(WIDTH)) U0_Execute_Unit(
  .EU_RD1D(RD1D),
  .EU_RD2D(RD2D),
  .EU_RsD(RsD),
  .EU_RtD(RtD),
  .EU_RdD(RdD),
  .EU_SignImmD(SignImmD),
  .EU_ResultW(ResultW),
  .EU_AluOutM(AluOutM),
  .EU_ForwardAE(ForwardAE),
  .EU_ForwardBE(ForwardBE),
  .EU_RegWriteD(RegWriteD),
  .EU_MemWriteD(MemWriteD),
  .EU_MemToRegD(MemToRegD),
  .EU_ALuControlD(ALuControlD),
  .EU_AluSrcD(AluSrcD),
  .EU_RegDstD(RegDstD),
  .EU_FlushE(FlushE),
  .EU_CLK(CLK),
  .EU_RST(RST),
  .EU_AluOutE(AluOutE),
  .EU_WriteDataE(WriteDataE),
  .EU_WriteRegE(WriteRegE),
  .EU_RsE(RsE),
  .EU_RtE(RtE),
  .EU_RegWriteE(RegWriteE),
  .EU_MemWriteE(MemWriteE),
  .EU_MemToRegE(MemToRegE)
  );
  
  Memory_Unit #(.WIDTH(WIDTH)) U0_Memory_Unit(
  .MU_AluOutE(AluOutE),
  .MU_WriteDataE(WriteDataE),
  .MU_WriteRegE(WriteRegE),
  .MU_RegWriteE(RegWriteE),
  .MU_MemWriteE(MemWriteE),
  .MU_MemToRegE(MemToRegE),
  .MU_CLK(CLK),
  .MU_RST(RST),
  .MU_AluOutM(AluOutM),
  .MU_ReadDataM(ReadDataM),
  .MU_WriteRegM(WriteRegM),
  .MU_RegWriteM(RegWriteM),
  .MU_MemToRegM(MemToRegM) 
  );
  
  WriteBack #(.WIDTH(WIDTH)) U0_WriteBack(
  .WB_AluOutM(AluOutM),
  .WB_ReadDataM(ReadDataM),
  .WB_WriteRegM(WriteRegM),
  .WB_RegWriteM(RegWriteM),
  .WB_MemToRegM(MemToRegM),
  .WB_CLK(CLK),
  .WB_RST(RST),
  .WB_ResultW(ResultW),
  .WB_WriteRegW(WriteRegW),
  .WB_RegWriteW(RegWriteW)
  );
  ////////////////////////Hazard unit///////////////////////////
  Hazard_Unit U0_Hazard_Unit(
  .HU_BranchD(BranchD),
  .HU_JumpD(JumpD),
  .HU_RsD(RsD),
  .HU_RtD(RtD),
  .HU_RsE(RsE),
  .HU_RtE(RtE),
  .HU_WriteRegE(WriteRegE),
  .HU_MemtoRegE(MemToRegE),
  .HU_RegWriteE(RegWriteE),
  .HU_WriteRegM(WriteRegM),
  .HU_WriteRegW(WriteRegW),
  .HU_RegWriteM(RegWriteM),
  .HU_RegWriteW(RegWriteW),
  .HU_StallF(StallF),
  .HU_StallD(StallD),
  .HU_ForwardAD(ForwardAD),
  .HU_ForwardBD(ForwardBD),
  .HU_FlushE(FlushE),
  .HU_ForwardAE(ForwardAE),
  .HU_ForwardBE(ForwardBE)
  );
endmodule