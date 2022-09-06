// FILE NAME: Execute_Unit.v
// TYPE: module
// DEPARTMENT: communication and electronics department
// AUTHOR: Mina Hanna
// AUTHOR EMAIL: mina.hannaone@gmail.com
//------------------------------------------------
// Release history
// VERSION DATE AUTHOR DESCRIPTION
// 1.0 4/9/2022 Mina Hanna final version
//------------------------------------------------
// KEYWORDS: pipeline mips, execute instruction
//------------------------------------------------
// PURPOSE: this is the Execute unit of the mips\
///////////inputs and outputs ports declaration/////////////
module Execute_Unit #(parameter WIDTH = 32) (
  input    wire    [WIDTH-1:0]     EU_RD1D,
  input    wire    [WIDTH-1:0]     EU_RD2D,
  input    wire    [4:0]           EU_RsD,
  input    wire    [4:0]           EU_RtD,
  input    wire    [4:0]           EU_RdD,
  input    wire    [WIDTH-1:0]     EU_SignImmD,
  input    wire    [WIDTH-1:0]     EU_ResultW,
  input    wire    [WIDTH-1:0]     EU_AluOutM,
  input    wire    [1:0]           EU_ForwardAE,
  input    wire    [1:0]           EU_ForwardBE,
  input    wire                    EU_RegWriteD,
  input    wire                    EU_MemWriteD,
  input    wire                    EU_MemToRegD,
  input    wire    [2:0]           EU_ALuControlD,
  input    wire                    EU_AluSrcD,
  input    wire                    EU_RegDstD,
  input    wire                    EU_FlushE,
  input    wire                    EU_CLK,
  input    wire                    EU_RST,
  output   wire    [WIDTH-1:0]     EU_AluOutE,
  output   wire    [WIDTH-1:0]     EU_WriteDataE,
  output   wire    [4:0]           EU_WriteRegE,
  output   wire    [4:0]           EU_RsE,
  output   wire    [4:0]           EU_RtE,
  output   wire                    EU_RegWriteE,
  output   wire                    EU_MemWriteE,
  output   wire                    EU_MemToRegE
  );
  
  ////////////////////wires definitions//////////////////////
  wire    [WIDTH-1:0]    RD1E;
  wire    [WIDTH-1:0]    RD2E;
  wire    [WIDTH-1:0]    SrcA;
  wire    [WIDTH-1:0]    SrcB;
  wire    [WIDTH-1:0]    SignImmE;
  wire    [4:0]          RdE;
  wire    [2:0]          AluControlE;
  wire                   AluSrcE;
  wire                   RegDstE;
  
  ////////////////////modules instantiations/////////////////
  /////////////////// input FF///////////////////////////////
  DTOEFF #(.WIDTH(WIDTH)) U0_DTOEFF(
  .DTOEFF_RD1D(EU_RD1D),
  .DTOEFF_RD2D(EU_RD2D),
  .DTOEFF_RsD(EU_RsD),
  .DTOEFF_RtD(EU_RtD),
  .DTOEFF_RdD(EU_RdD),
  .DTOEFF_SignImmD(EU_SignImmD),
  .DTOEFF_RegWriteD(EU_RegWriteD),
  .DTOEFF_MemWriteD(EU_MemWriteD),
  .DTOEFF_MemToRegD(EU_MemToRegD),
  .DTOEFF_ALuControlD(EU_ALuControlD),
  .DTOEFF_AluSrcD(EU_AluSrcD),
  .DTOEFF_RegDstD(EU_RegDstD),
  .DTOEFF_CLK(EU_CLK),
  .DTOEFF_RST(EU_RST),
  .DTOEFF_CLR(EU_FlushE),
  .DTOEFF_RD1E(RD1E),
  .DTOEFF_RD2E(RD2E),
  .DTOEFF_RsE(EU_RsE),
  .DTOEFF_RtE(EU_RtE),
  .DTOEFF_RdE(RdE),
  .DTOEFF_SignImmE(SignImmE),
  .DTOEFF_RegWriteE(EU_RegWriteE),
  .DTOEFF_MemWriteE(EU_MemWriteE),
  .DTOEFF_MemToRegE(EU_MemToRegE),
  .DTOEFF_ALuControlE(AluControlE),
  .DTOEFF_AluSrcE(AluSrcE),
  .DTOEFF_RegDstE(RegDstE)
  );
  
  ///////////////////////////muxes///////////////////////
  MUX #(.WIDTH(5)) U0_MUX(
  .MUX_IN1(EU_RtE),
  .MUX_IN2(RdE),
  .MUX_SelectionBit(RegDstE),
  .MUX_OUT(EU_WriteRegE)
  );
  MUX #(.WIDTH(WIDTH)) U1_MUX(
  .MUX_IN1(EU_WriteDataE),
  .MUX_IN2(SignImmE),
  .MUX_SelectionBit(AluSrcE),
  .MUX_OUT(SrcB)
  );
  mux4X1 #(.WIDTH(WIDTH)) U0_mux4X1(
  .sel(EU_ForwardAE),
  .IN_1(RD1E),
  .IN_2(EU_ResultW),
  .IN_3(EU_AluOutM),
  .IN_4(),
  .OUT(SrcA)
  );
  mux4X1 #(.WIDTH(WIDTH)) U1_mux4X1(
  .sel(EU_ForwardBE),
  .IN_1(RD2E),
  .IN_2(EU_ResultW),
  .IN_3(EU_AluOutM),
  .IN_4(),
  .OUT(EU_WriteDataE)
  );
 ////////////////////////////ALU//////////////////////////
 ALU #(.WIDTH(WIDTH)) U0_ALU(
  .ALU_srca(SrcA),
  .ALU_srcb(SrcB),
  .Control(AluControlE),
  .ALU_out(EU_AluOutE),
  .ALU_Zero()); 
endmodule