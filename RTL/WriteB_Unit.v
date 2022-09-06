// FILE NAME: WriteB_Unit.v
// TYPE: module
// DEPARTMENT: communication and electronics department
// AUTHOR: Mina Hanna
// AUTHOR EMAIL: mina.hannaone@gmail.com
//------------------------------------------------
// Release history
// VERSION DATE AUTHOR DESCRIPTION
// 1.0 4/9/2022 Mina Hanna final version
//------------------------------------------------
// KEYWORDS: pipeline mips, Write back instruction
//------------------------------------------------
// PURPOSE: this is the Write back unit of the mips\
///////////inputs and outputs ports declaration/////////////
module WriteBack #(parameter WIDTH = 32) (
  input    wire    [WIDTH-1:0]    WB_AluOutM,
  input    wire    [WIDTH-1:0]    WB_ReadDataM,
  input    wire    [4:0]          WB_WriteRegM,
  input    wire                   WB_RegWriteM,
  input    wire                   WB_MemToRegM,
  input    wire                   WB_CLK,
  input    wire                   WB_RST,
  output   wire    [WIDTH-1:0]    WB_ResultW,
  output   wire    [4:0]          WB_WriteRegW,
  output   wire                   WB_RegWriteW
  );
  
  //////////////////////wires definitions/////////////////////
  wire    [WIDTH-1:0]    AluOutW;
  wire    [WIDTH-1:0]    ReadDataW;
  wire                   MemToRegW;
  /////////////////////models instantiations//////////////////
  /////////////////////input FF//////////////////////////////
  MTOWBFF #(.WIDTH(WIDTH)) U0_MTOWBFF(
  .MTOWBFF_AluOutM(WB_AluOutM),
  .MTOWBFF_ReadDataM(WB_ReadDataM),
  .MTOWBFF_WriteRegM(WB_WriteRegM),
  .MTOWBFF_RegWriteM(WB_RegWriteM),
  .MTOWBFF_MemToRegM(WB_MemToRegM),
  .MTOWBFF_CLK(WB_CLK),
  .MTOWBFF_RST(WB_RST),
  .MTOWBFF_AluOutW(AluOutW),
  .MTOWBFF_ReadDataW(ReadDataW),
  .MTOWBFF_WriteRegW(WB_WriteRegW),
  .MTOWBFF_RegWriteW(WB_RegWriteW),
  .MTOWBFF_MemToRegW(MemToRegW)
  );
///////////////////////muxes////////////////////////////////////////
MUX #(.WIDTH(WIDTH)) U0_MUX(
  .MUX_IN1(AluOutW),
  .MUX_IN2(ReadDataW),
  .MUX_SelectionBit(MemToRegW),
  .MUX_OUT(WB_ResultW)
  );
endmodule